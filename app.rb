require 'sinatra'
require 'sinatra/reloader'

before do
  @author = "yokomaru"
end

after do
  logger.info "page displayed"
end

helpers do
  def  strong(a)
   "<strong>#{a}</strong>"
  end
end

get '/' do
  @title = "index"
  @content = "index #{strong(@author)}"
  erb :index
end

get '/memos' do
  redirect '/'
end

get '/memos/new' do
  '新しいメモの作成ページ'
end

get '/memos/:id' do |id|
  "メモの編集ページ id = #{id}"
end

get '/memos/:id/edit' do |id|
  "指定したidのメモの内容を取得する id = #{id}"
end

post '/memos' do
  '新しいメモを追加する'
end

patch '/memos/:id' do |id|
  "指定したidのメモを更新する id = #{id}"
end

delete '/memos/:id' do |id|
  "指定したidのメモを削除する id = #{id}"
end
