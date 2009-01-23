require 'rubygems'
require 'sinatra'
require 'couchrest'
require 'models'

DB = 'digibinder-app'

layout 'layout'

get '/' do
  erb :index
end

get '/notes' do
  @notes = Section.view(DB, 'sections/by_title')
  erb :notes
end

post '/notes' do
  @note = Section.new(DB, request.params)
  @note.save
  redirect '/notes'
end

get '/notes/:id' do
  @note = Section.find(DB, params[:id])
  erb :show
end

post '/notes/:id' do
  @note = Section.find(DB, params[:id])
  @note.save(request.params)
  redirect "/notes/#{params[:id]}"
end

get '/notes/:id/edit' do
  @note = Section.find(DB, params[:id])
  erb :edit
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
  
  def hidden_field(name, value)
    %(
    <input type="hidden" name="#{name}" value="#{value}" />
    )
  end
  
  def submit(value)
    %(
    <p><input type="submit" value="#{value}" /></p>
    )
  end
end