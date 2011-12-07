module Components #:nodoc:
  autoload :Base, 'components/base'
  autoload :View, 'components/view'
  autoload :Caching, 'components/caching'
  autoload :ActionController, 'components/action_controller'
  autoload :ActionView, 'components/action_view'

  def self.render(name, component_args = [], options = {})
    klass, method = name.split(/\/(?=[^\/]*$)/)

    component = (klass + "_component").camelcase.constantize.new
    component.form_authenticity_token = options[:form_authenticity_token]
    merge_standard_component_options!(component_args, options[:standard_component_options], component.method(method).arity)
    component.logger.debug "Rendering component #{name}"
    component.send(method, *component_args).to_s
  end

  def self.merge_standard_component_options!(args, standard_options, arity)
    if standard_options
      # when the method's arity is positive, it only accepts a fixed list of arguments, so we can't add another.
      args << {} unless args.last.is_a?(Hash) or not arity < 0
      args.last.reverse_merge!(standard_options) if args.last.is_a?(Hash)
    end
  end
end

ActionController::Base.class_eval { include Components::ActionController }
ActionView::Base.class_eval { include Components::ActionView }