require 'rubygems'
require 'sinatra'
require 'couchrest'

DB = CouchRest.database!("http://127.0.0.1:5984/digibinder-app")

layout 'layout'

get '/' do
  erb :index
end