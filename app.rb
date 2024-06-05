# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require_relative 'models/memo'

enable :method_override

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  @memos = Memo.all
  erb :index
end

get '/memos' do
  redirect '/'
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  @memos = Memo.all
  max_id = Memo.fetch_max_id(@memos)
  hash = { 'id': max_id.to_s, 'title': h(params[:title]), 'content': h(params[:content]) }
  @memos.push(hash)
  Memo.save(@memos)
  redirect "/memos/#{max_id}"
end

get '/memos/:id' do |id|
  @memos = Memo.all
  @memo = Memo.find_by_id(@memos, id)
  redirect to not_found if @memo.nil?
  erb :show
end

get '/memos/:id/edit' do |id|
  @memos = Memo.all
  @memo = Memo.find_by_id(@memos, id)
  redirect to not_found if @memo.nil?
  erb :edit
end

patch '/memos/:id' do |id|
  @memos = Memo.all
  @memo = Memo.find_by_id(@memos, id)
  @memos.find do |memo|
    if memo['id'].include?(id)
      memo['title'] = h(params[:title])
      memo['content'] = h(params[:content])
    end
  end
  Memo.save(@memos)
  redirect to "/memos/#{params[:id]}"
end

delete '/memos/:id' do |id|
  @memos = Memo.all
  @memo = Memo.find_by_id(@memos, id)
  Memo.destroy(@memos, id)
  Memo.save(@memos)
  redirect '/'
end

not_found do
  status 404
  erb :not_found
end
