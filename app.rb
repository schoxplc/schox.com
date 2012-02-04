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
  haml :index
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

