module Components
  module ActionController
    protected

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
      Components.render(name, args,
        :form_authenticity_token => (form_authenticity_token if protect_against_forgery?),
        :standard_component_options => standard_component_options
      )
    end

    # Override this method on your controller (probably your ApplicationController)
    # to define common arguments for your components. For example, you may always
    # want to provide the current user, in which case you could return {:user =>
    # current_user} from this method.
    #
    # In order to use this, your component actions should accept an options hash
    # as their last argument.
    #
    # I feel like this is a better solution than simply making request and
    # session details directly available to the components.
    def standard_component_options; end
  end
end