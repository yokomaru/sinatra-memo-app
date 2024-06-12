# frozen_string_literal: true

require 'json'

class Memo
  FILE_PATH = 'db/memo.json'

  def self.all
    File.open(FILE_PATH, 'r') do |file|
      content = file.read
      content.empty? ? [] : JSON.parse(content)
    end
  end

  def self.find_by_id(id)
    memos = Memo.all
    memos.find { |x| x['id'] == id }
  end

  def self.save(memos)
    File.open(FILE_PATH, 'w') do |file|
      JSON.dump(memos, file)
    end
  end

  def self.create(params)
    memos = Memo.all
    max_id = Memo.fetch_max_id(memos)
    memos << { 'id': max_id.to_s, 'title': params[:title], 'content': params[:content] }
    Memo.save(memos)
  end

  def self.update(params)
    memos = Memo.all
    memos.find do |memo|
      if memo['id'] == params[:id]
        memo['title'] = params[:title]
        memo['content'] = params[:content]
      end
    end
    Memo.save(memos)
  end

  def self.destroy(id)
    memos = Memo.all
    memos.find.with_index do |memo, i|
      memos.delete_at(i) if memo['id'] == id
    end
    Memo.save(memos)
  end

  def self.fetch_max_id(memos)
    memos.empty? ? 1 : memos.map { |memo| memo['id'].to_i }.max + 1
  end

  def self.create_db
    return if File.exist?(FILE_PATH)

    File.open(FILE_PATH, 'w') do |file|
      JSON.dump([], file)
    end
  end
end
