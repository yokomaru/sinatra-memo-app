require 'sinatra'
require 'sinatra/reloader'
require './models/memos'
require 'json'

enable :method_override

get '/' do
  #@memos = Memo.all
  File.open('public/memos.json') { |file| JSON.load(file) } || []
  erb :index
end

get '/memos' do
  redirect '/'
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  # Memo.all
  @memos = File.open('public/memos.json') { |file| JSON.load(file) } || []
  max_id = @memos.empty? ? 1 : @memos.map{|memo| memo["id"].to_i}.max + 1
  hash = {"id": max_id.to_s, "title": params[:title], "content": params[:content]}
  @memos.push(hash.dup)
  # Memo.save
  File.open('public/memos.json', 'w') do |file|
    str = JSON.dump(@memos, file)
  end
  redirect "/memos/#{max_id}"
end

get '/memos/:id' do |id|
  # Memo.all
  @memos = File.open('public/memos.json') { |file| JSON.load(file) }
  # Memo.find_by_id(id)
  @memo = @memos.find {|x| x["id"].include?(id)}
	erb :show
end

get '/memos/:id/edit' do |id|
  # Memo.all
  @memos = File.open('public/memos.json') { |file| JSON.load(file) }
  # Memo.find_by_id(id)
  @memo = @memos.find {|x| x["id"].include?(id)}
	erb :edit
end

patch '/memos/:id' do |id|
  # Memo.all
  @memos = File.open('public/memos.json') { |file| JSON.load(file) }
  # Memo.find_by_id(id)
  @memo = @memos.find {|x| x["id"].include?(id)}
  @memos.find do |memo|
    if memo["id"].include?(id)
      memo['title'] = params[:title]
      memo['content'] = params[:content]
    end
  end
  # Memo.save
  File.open('public/memos.json', 'w') do |file|
    str = JSON.dump(@memos, file)
  end
  redirect to "/memos/#{params[:id]}"
end

delete '/memos/:id' do |id|
  #Memo.find_by_id(params[:id])
  @memo = @memos.find {|x| x["id"].include?(id)}
  # Memo.all
  @memos = File.open('public/memos.json') { |file| JSON.load(file) }
  # Memo.destroy
  @memos.find.with_index do |memo, i|
    if memo["id"].include?(id)
      @memos.delete_at(i)
    end
  end
  # Memo.save
  File.open('public/memos.json', 'w') do |file|
    str = JSON.dump(@memos, file)
  end
  redirect '/'
  erb :index
end
