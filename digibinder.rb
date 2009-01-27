require 'rubygems'
require 'sinatra'
require 'couchrest'
require 'models'

configure do
  use Rack::CommonLogger
  enable :sessions
end

layout 'layout'

get '/' do
  @notebooks = Notebook.view(options.db, 'notebooks/by_topic').rows
  erb :index
end

get '/sections' do
  @sections = Section.view(options.db, 'sections/by_title').rows
  erb :section_index
end

post '/sections' do
  @section = Section.new(options.db, request.params)
  @section.save
  redirect '/sections'
end

get '/sections/:id' do
  @section = Section.find(options.db, params[:id])
  erb :section_show
end

post '/sections/:id' do
  @section = Section.find(options.db, params[:id])
  @section.save(request.params)
  redirect "/sections/#{params[:id]}"
end

get '/sections/:id/edit' do
  @section = Section.find(options.db, params[:id])
  @notebooks = Notebook.view(options.db, 'notebooks/by_topic').rows
  erb :section_edit
end

get '/sections/:id/delete' do
  @section = Section.find(options.db, params[:id])
  @section.destroy
  redirect '/sections'
end

get '/tags' do
  @tags = Section.view(options.db, 'tags/total', :group => true).rows
  erb :tag_index
end

get '/tags/:name' do
  @tag = params[:name]
  @sections = Section.view(options.db, 'sections/by_tag', :key => @tag).rows
  erb :tag_show
end

post '/notebooks' do
  @notebook = Notebook.new(options.db, request.params)
  @notebook.save
  redirect '/'
end

get '/notebooks/new' do
  erb :notebook_new
end

get '/notebooks/:id' do
  @notebook = Notebook.find(options.db, params[:id])
  @sections = Section.view(options.db, 'sections/by_notebook', :key => @notebook.topic).rows
  erb :notebook_show
end

post '/notebooks/:id' do
  @notebook = Notebook.find(options.db, params[:id])
  @notebook.save(request.params)
  redirect "/notebooks/#{params[:id]}"
end

get '/notebooks/:id/edit' do
  @notebook = Notebook.find(options.db, params[:id])
  erb :notebook_edit
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