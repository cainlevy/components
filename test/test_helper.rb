# fake the rails root
RAILS_ROOT = File.dirname(__FILE__)

# require support libraries
require 'test/unit'
require 'rubygems'
gem 'rails', '2.1.1'
require 'active_support'
require 'action_controller'
require 'action_controller/test_process' # for the assertions
require 'action_view'
require 'active_record'
require 'logger'
require 'mocha'

RAILS_DEFAULT_LOGGER = Logger.new(File.dirname(__FILE__) + '/debug.log')

dep = ActiveSupport.const_defined?("Dependencies") ? ActiveSupport::Dependencies : Dependencies
%w(../lib app/controllers).each do |load_path|
  dep.load_paths << File.dirname(__FILE__) + "/" + load_path
end

require File.dirname(__FILE__) + '/../init'

# Rails 2.1+
if ActionController::Base.respond_to? :cache_store
  ActionController::Base.cache_store = :memory_store
else
  ActionController::Base.fragment_cache_store = :memory_store
end
