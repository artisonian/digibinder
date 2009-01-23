require 'rubygems'
require 'sinatra'
require 'couchrest'
require 'models'

DB = CouchRest.database!("http://127.0.0.1:5984/digibinder-app")

layout 'layout'

get '/' do
  erb :index
end

post '/notes' do
  @note = Section.new(DB, request.params)
  @note.save
  redirect '/'
end

helpers do
  
  # form helpers
  
  def text_field(name, value='')
    %(
    <p>
        <label for="#{name}">#{name.capitalize}:</label><br />
        <input name="#{name}" value="#{value}" />
    </p>
    )
  end
  
  def text_area(name, value='')
    %(
    <p>
        <label for="#{name}">#{name.capitalize}:</label><br />
        <textarea name="#{name}">#{value}</textarea>
    </p>
    )
  end
  
  def submit(value)
    %(
    <p><input type="submit" value="#{value}" /></p>
    )
  end
end