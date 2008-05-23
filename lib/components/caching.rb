# Component caching is at a very fine-grained level - a component is cached based on all
# of its arguments. Any more or less would result in inaccurate cache hits.
#
# === Howto
#
# First, configure fragment caching on ActionController. That cache store will be used
# for components as well.
#
# Second, decide which component actions should be cached. Some components cache better
# than others due to the nature of the arguments passed.
#
# For each component you wish to cache, add `cache :my_action` _after_ you define the
# action itself. This is necessary because your action will be wrapped with another
# method - :my_action_with_caching. This enables component actions to be cached no matter
# how they are called.
#
# === Example
#
#   class UserComponent < Components::Base
#     def show(user_id)
#       @user = User.find(user_id)
#       render
#     end
#     cache :show
#   end
#
# === Expiration
#
# I know of three general methods to expire caches:
#
#  * TTL: expires a cache after some number of seconds. This works well for content that
#    is hit frequently but can stand to be a bit stale at times.
#  * Versioning: caches are never actually expired, rather, they are eventually ignored
#    when all new cache requests are for a new version. This only works with cache stores
#    that have some kind of limited cache space, otherwise cache consumption will go
#    through the metaphorical roof.
#  * Direct Expiration: caches are expired by name. This does not work when cache keys
#    have variable elements, or when the complete list of cache keys is not available
#    or a brute-force regular expression approach.
#
# Of those three, direct expiration is not a viable option due to the variable nature of
# component cache keys. And since both of the remaining methods are best supported by some
# variation of memcache, that is the officially recommended cache store.
#
# TODO: describe how to implement TTL/Versioned expiration
module Components::Caching
  def self.included(base)
    base.class_eval do
      extend ClassMethods
    end
  end

  module ClassMethods
    # Caches the named actions by wrapping them via alias_method_chain. May only
    # be called on actions (methods) that have already been defined.
    #
    # Cache options will be passed through to the cache store's read/write methods.
    def cache(action, cache_options = nil)
      return unless ActionController::Base.cache_configured?

      class_eval <<-EOL, __FILE__, __LINE__
        cattr_accessor :#{action}_cache_options

        def #{action}_with_caching(*args)
          with_caching(:#{action}, args) do
            #{action}_without_caching(*args)
          end
        end
        alias_method_chain :#{action}, :caching
      EOL
      self.send("#{action}_cache_options=", cache_options)
    end

    def cache_store
      @cache_store ||= if ActionController::Base.respond_to?(:cache_store)
        # Rails 2.1
        ActionController::Base.cache_store
      else
        # Rails 2.0
        ActionController::Base.fragment_cache_store
      end
    end
  end

  protected

  def with_caching(action, args, &block)
    key = cache_key(action, args)
    cache_options = self.send("#{action}_cache_options")
    read_fragment(key, cache_options) || returning(block.call) { |fragment| write_fragment(key, fragment, cache_options) }
  end

  def read_fragment(key, cache_options = nil)
    returning self.class.cache_store.read(key, cache_options) do |content|
      logger.info "Component Cache hit: #{key}" unless content.blank?
    end
  end

  def write_fragment(key, content, cache_options = nil)
    logger.info "Component Cache miss: #{key}"
    self.class.cache_store.write(key, content, cache_options)
  end

  # TODO: test for consistency in cache key even w. options hashes at the end of args
  def cache_key(action, args = [])
    key = ([self.class.path, action] + args).collect do |arg|
      case arg
        when Hash:                arg.to_query # Rails 2.0 compat
        when ActiveRecord::Base:  "#{arg.class.to_s.underscore}#{arg.id}" # note: doesn't apply to record sets
        else                      arg.to_param
      end
    end.join('/')

    if ActiveSupport.const_defined?("Cache")
      # Rails 2.1
      ActiveSupport::Cache.expand_cache_key(key, :components)
    else
      # Rails 2.0
      key
    end
  end
end
