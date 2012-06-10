#!/usr/bin/env ruby

require "haml"
require "sinatra"
require "sinatra/content_for"

get "/" do
  haml :intro
end

get "/clients" do
  haml :clients
end

get "/contact" do
  haml :contact
end

get "/disclaimer" do
  haml :disclaimer
end

get "/founder" do
  haml :founder
end

get "/omission" do
  haml :omission
end

get "/team" do
  haml :team
end

get "/clients/:client" do
  haml :"clients/#{params[:client]}"
end


get "/css/:stylesheet" do |css|
  content_type "text/css", :charset => "utf-8"
  last_modified File.mtime("views/css/#{css}.erb")
  erb "css/#{css}".to_sym
end

not_found do
  haml :"404"
end

error do
  @e = request.env["sinatra_error"]
  File.read(File.join("public", "index.html"))
end

helpers do

  def partial(page, options={})
    haml page.to_sym, options.merge!(:layout => false)
  end

  def md(markdown_file)
    GitHub::Markup.render( markdown_file )
  end

end

