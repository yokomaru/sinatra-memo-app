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
  if Memo.create(params)
    redirect '/'
  else
    erb :new
  end
end

get '/memos/:id' do |id|
  @memo = Memo.find_by_id(id)
  if @memo.nil?
    redirect to not_found
  else
    erb :show
  end
end

get '/memos/:id/edit' do |id|
  @memo = Memo.find_by_id(id)
  if @memo.nil?
    redirect to not_found
  else
    erb :edit
  end
end

patch '/memos/:id' do |id|
  memo = Memo.find_by_id(id)

  redirect to not_found if memo.nil?
  if Memo.update(params)
    redirect "/memos/#{id}"
  else
    erb :edit
  end
end

delete '/memos/:id' do |id|
  memo = Memo.find_by_id(id)
  redirect to not_found if memo.nil?
  if Memo.destroy(id)
    redirect '/'
  else
    erb :show
  end
end

not_found do
  status 404
  erb :not_found
end

Memo.create_db if $PROGRAM_NAME == __FILE__
