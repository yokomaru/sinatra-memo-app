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
  memo = { 'id': max_id.to_s, 'title': params[:title], 'content': params[:content] }
  add_memos = @memos
  add_memos.push(memo)
  if Memo.save(add_memos)
    redirect "/memos/#{max_id}"
  else
    erb :new
  end
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
  @memos.find do |memo|
    if memo['id'].include?(id)
      memo['title'] = params[:title]
      memo['content'] = params[:content]
    end
  end
  if Memo.save(@memos)
    redirect "/memos/#{params[:id]}"
  else
    erb :edit
  end
end

delete '/memos/:id' do |id|
  @memos = Memo.all
  @memo = Memo.find_by_id(@memos, id)
  if Memo.destroy(@memos, id)
    redirect '/'
  else
    erb :show
  end
end

not_found do
  status 404
  erb :not_found
end
