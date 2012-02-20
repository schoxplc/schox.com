#!/usr/bin/env ruby

require "haml"
require "net/http"
require "nokogiri"
require "sinatra"
require "sinatra/content_for"
require "uri"

configure do
end

before do
end

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

helpers do

  def partial(page, options={})
    haml page.to_sym, options.merge!(:layout => false)
  end

  def md(markdown_file)
    GitHub::Markup.render( markdown_file )
  end

end

