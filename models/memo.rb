# frozen_string_literal: true

require 'json'

class Memo
  def self.all
    File.open('public/memo.json') { |file| JSON.parse(file.read) } || []
  end

  def self.find_by_id(memos, id)
    memos.find { |x| x['id'].include?(id) }
  end

  def self.save(memos)
    File.open('public/memo.json', 'w') do |file|
      JSON.dump(memos, file)
    end
  end

  def self.destroy(memos, id)
    memos.find.with_index do |memo, i|
      memos.delete_at(i) if memo['id'].include?(id)
    end
  end

  def self.fetch_max_id(memos)
    memos.empty? ? 1 : memos.map { |memo| memo['id'].to_i }.max + 1
  end
end
