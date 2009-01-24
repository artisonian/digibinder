require 'rubygems'
require 'sinatra'
require 'couchrest'
require 'models'

DB = 'digibinder-app'

layout 'layout'

get '/' do
  erb :index
end

get '/sections' do
  @sections = Section.view(DB, 'sections/by_title')
  erb :sections
end

post '/sections' do
  @section = Section.new(DB, request.params)
  @section.save
  redirect '/sections'
end

get '/sections/:id' do
  @section = Section.find(DB, params[:id])
  erb :show
end

post '/sections/:id' do
  @section = Section.find(DB, params[:id])
  @section.save(request.params)
  redirect "/sections/#{params[:id]}"
end

get '/sections/:id/edit' do
  @section = Section.find(DB, params[:id])
  erb :edit
end

get '/tags' do
  @tags = Section.view(DB, 'tags/total', :group => true)
  erb :tags
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