module Components
  class Base
    include ::ActionController::UrlWriter

    # for request forgery protection compatibility
    attr_accessor :form_authenticity_token
    delegate :request_forgery_protection_token, :allow_forgery_protection, :to => "ActionController::Base"
    def protect_against_forgery?
      allow_forgery_protection && request_forgery_protection_token
    end

    class << self
      def view_paths
        if read_inheritable_attribute(:view_paths).nil?
          write_inheritable_attribute(:view_paths, [File.join(RAILS_ROOT, 'app', 'components')])
        end
        read_inheritable_attribute(:view_paths)
      end

      def name
        @name ||= self.to_s.underscore.sub("_component", "")
      end
    end

    # must be public for access from ActionView
    def logger
      RAILS_DEFAULT_LOGGER
    end

    protected

    def render(file = nil)
      # infer the render file basename from the caller method.
      unless file
        caller.first =~ /`([^']*)'/
        file = $1
      end

      # pick the closest parent component with the file
      component = self.class
      unless file.include?("/")
        until template.file_exists? "#{component.name}/#{file}" or component.superclass == Components::Base
          component = component.superclass
        end
      end

      template.render("#{component.name}/#{file}")
    end

    def template
      @template ||= Components::View.new(self.class.view_paths, assigns_for_view, self)
    end

    def assigns_for_view
      @assigns_for_view ||= (instance_variables - unassignable_instance_variables).inject({}) do |hash, var|
        hash[var[1..-1]] = instance_variable_get(var)
        hash
      end
    end

    def unassignable_instance_variables
      %w(@component_name @template)
    end
  end
end