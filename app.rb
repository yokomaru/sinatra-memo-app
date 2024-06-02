require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

ActiveRecord::Base.establish_connection(
    "adapter" => "sqlite3",
    "database" => "memo.db"
)

class Memo < ActiveRecord::Base
end

enable :method_override

get '/' do
  @memos = Memo.order("id desc").all
  erb :index
end

get '/memos' do
  redirect '/'
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  @memo = Memo.create({title: params[:title], content: params[:content]})
  redirect "/memos/#{@memo.id}"
end

get '/memos/:id' do |id|
  @memo = Memo.find_by_id(params[:id])
	erb :show
end

get '/memos/:id/edit' do |id|
  @memo = Memo.find_by_id(params[:id])
	erb :edit
end

patch '/memos/:id' do |id|
  @memo = Memo.find_by_id(params[:id])
	@memo.title = params[:title]
  @memo.content = params[:content]
	@memo.save
	redirect to "/memos/#{params[:id]}"
end

delete '/memos/:id' do |id|
  Memo.find(params[:id]).destroy
  redirect '/'
  erb :index
end
