require 'rubygems'
require 'sinatra'

root_dir = File.dirname(__FILE__)

Sinatra::Application.set(
  :views    => File.join(root_dir, 'views'),
  :app_file => File.join(root_dir, 'digibinder.rb'),
  :run => false,
  :environment => ENV['RACK_ENV'].to_sym,
  :db => 'http://127.0.0.1:5984/digibinder-app'
)

run Sinatra::Application