module Components #:nodoc:
  def self.render(name, component_args = [], options = {})
    klass, method = name.split('/')
    component = (klass + "_component").camelcase.constantize.new
    component.form_authenticity_token = options[:form_authenticity_token]
    component.send(method, *component_args).to_s
  end

  module ActionController
    # Renders the named component with the given arguments. The component name must indicate both
    # the component class and the class' action.
    #
    # Example:
    #
    #   class UsersController < ApplicationController
    #     def show
    #       render :text => component("users/details", params[:id])
    #     end
    #   end
    #
    # would render:
    #
    #   class UsersComponent < Components::Base
    #     def details(user_id)
    #       "all the important details about the user, nicely marked up"
    #     end
    #   end
    def component(name, *args)
      Components.render(name, args, :form_authenticity_token => (form_authenticity_token if protect_against_forgery?))
    end
  end

  module ActionView
    # Renders the named component with the given arguments. The component name must indicate both
    # the component class and the class' action.
    #
    # Example:
    #
    #   /app/views/users/show.html.erb
    #
    #     <%= component "users/details", @user.id %>
    #
    # would render:
    #
    #   class UsersComponent < Components::Base
    #     def details(user_id)
    #       "all the important details about the user, nicely marked up"
    #     end
    #   end
    def component(name, *args)
      Components.render(name, args, :form_authenticity_token => (form_authenticity_token if protect_against_forgery?))
    end
  end
end

ActionController::Base.class_eval do include Components::ActionController end
ActionView::Base.class_eval       do include Components::ActionView       end

unless ActionView::Base.instance_methods.include?("file_exists?")
  ActionView::Base.class_eval do
    delegate :file_exists?, :to => :finder
  end
end