require "sinatra"
require "uri"

set :bind, "0.0.0.0"

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  return nil
end

def save_content(title, content)
  File.open("pages/#{title}.txt", "w") do |file|
    file.print(content)
  end
end

def delete_content(title)
  File.delete("pages/#{title}.txt")
end

get("/") do
  @array_pages = []
  
  d = Dir.new("pages")
  d.each do |page| 
    if(page != "." && page != ".." && page != "layout.erb")
      @array_pages.push(page)
    end
  end
  
  # erb :index, layout: :page
  erb :index
end

get("/new") do
  erb :new
end

get("/:title") do
  @title = params[:title]
  @content = page_content(@title)
  erb :show
end

get("/:title/edit") do
  @title = params[:title]
  @content = page_content(@title)
  erb :edit
end

post '/create' do
  @title = params[:title]
  @content = params[:content]
  save_content(@title, @content)
  redirect(URI.escape("/#{@title}"))
end

put "/:title" do
  @title = params[:title]
  @content = params[:content]
  save_content(@title, @content)
  redirect(URI.escape("/#{@title}"))
end

delete "/:title" do
  delete_content(params[:title])
  redirect "/"
end
