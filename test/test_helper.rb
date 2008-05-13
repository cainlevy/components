# fake the rails root
RAILS_ROOT = File.dirname(__FILE__)

# require support libraries
require 'test/unit'
require 'rubygems'
require 'active_support'
require 'action_controller'
require 'action_controller/test_process' # for the assertions
require 'action_view'
require 'logger'
require 'mocha'

RAILS_DEFAULT_LOGGER = Logger.new(File.dirname(__FILE__) + '/debug.log')

Dependencies.load_paths << File.dirname(__FILE__) + '/../lib/'
require File.dirname(__FILE__) + '/../init'

