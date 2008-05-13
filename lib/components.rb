module Components
  def self.render(name, component_args = [], options = {})
    klass, method = name.split('/')
    component = (klass + "_component").camelcase.constantize.new
    component.form_authenticity_token = options[:form_authenticity_token]
    component.send(method, *component_args).to_s
  end

  module ActionController
    def component(name, *args)
      Components.render(name, args, :form_authenticity_token => form_authenticity_token)
    end
  end

  module ActionView
    def component(name, *args)
      Components.render(name, args, :form_authenticity_token => form_authenticity_token)
    end
  end
end

ActionController::Base.class_eval do include Components::ActionController end
ActionView::Base.class_eval       do include Components::ActionView       end