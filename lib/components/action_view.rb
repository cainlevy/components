module Components
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
      Components.render(name, args,
        :form_authenticity_token => (form_authenticity_token if protect_against_forgery?),
        :standard_component_options => controller.send(:standard_component_options)
      )
    end
  end
end
