require 'sinatra'
require 'diff/lcs'
require_relative 'diff_html_formatter'

get '/' do
  erb :index
end

post '/compare' do
  original = params[:original]
  modified = params[:modified]

  @result = DiffHTMLFormatter.new(original, modified).to_html
  erb :result
end
