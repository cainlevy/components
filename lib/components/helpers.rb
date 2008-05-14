# I haven't yet embraced the entirety of ActionController's helpers system, so I'm cherry-picking what I want.
# Hmm, sure wish I knew a Module analogue to Class inheritance, so I could just "sub-module" this and disable what I don't want.
module Components::Helpers
  def self.included(base) #:nodoc:
    # Initialize the base module to aggregate its helpers.
    base.class_inheritable_accessor :master_helper_module
    base.master_helper_module = Module.new

    # Extend base with class methods to declare helpers.
    base.extend(ClassMethods)

    base.class_eval do
      # Wrap inherited to create a new master helper module for subclasses.
      class << self
        alias_method_chain :inherited, :helper
      end
    end
  end

  module ClassMethods #:nodoc:
    def helper_method(*methods)
      methods.flatten.each do |method|
        master_helper_module.module_eval <<-end_eval
          def #{method}(*args, &block)
            controller.send(%(#{method}), *args, &block)
          end
        end_eval
      end
    end

    private

    def inherited_with_helper(child)
      inherited_without_helper(child)

      begin
        child.master_helper_module = Module.new
        child.master_helper_module.send! :include, master_helper_module
      rescue MissingSourceFile => e
        raise unless e.is_missing?("helpers/#{child.controller_path}_helper")
      end
    end
  end
end