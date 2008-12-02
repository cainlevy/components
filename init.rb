if ActiveSupport.const_defined? "Dependencies"
  ActiveSupport::Dependencies.load_paths << RAILS_ROOT + '/app/components'
else
  Dependencies.load_paths << RAILS_ROOT + '/app/components'
end

Components # trigger load
