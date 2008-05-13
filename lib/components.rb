module Components
  def self.render(name, *component_args)
    klass, method = name.split('/')
    component = (klass + "_component").camelcase.constantize.new
    component.send(method, *component_args).to_s
  end

  class Base
    include ActionController::UrlWriter

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
      @template ||= ActionView::Base.new(self.class.view_paths, assigns_for_view, self)
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