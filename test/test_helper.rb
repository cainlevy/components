# bootstrap
require 'rubygems'
require 'test/unit'
require 'mocha'

# load the test app, which will load gems
ENV['RAILS_ENV'] = 'test'
require File.join(File.dirname(__FILE__), 'r3', 'config', 'environment.rb')
require 'rails/test_help'
Rails.backtrace_cleaner.remove_silencers!