require 'rubygems'
require 'sinatra'
require 'couchrest'
require 'models'

DB = CouchRest.database!("http://127.0.0.1:5984/digibinder-app")

layout 'layout'

get '/' do
  erb :index
end

get '/notes' do
  @notes = DB.view('by_title/all')['rows']
  erb :notes
  # @obj = @notes[0]
  # erb :debug
end

get '/notes/:id' do
  @note = DB.get(params[:id])
  erb :show
end

post '/notes' do
  @note = Section.new(DB, request.params)
  @note.save
  redirect '/'
end

helpers do
  
  # link helpers
  
  def link_to(text, path=nil)
    href = path || text
    %(<a href="#{href}" title="#{text}">#{text}</a>)
  end
  
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