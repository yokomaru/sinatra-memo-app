require 'json'

class Memo
  def self.all
    File.open('public/memo.json') { |file| JSON.load(file) } || []
  end

  def self.find_by_id(memos, id)
    memos.find {|x| x["id"].include?(id)}
  end

  def self.save(memos)
    File.open('public/memo.json', 'w') do |file|
      str = JSON.dump(memos, file)
    end
  end

  def self.destroy(memos, id)
    memos.find.with_index do |memo, i|
      if memo["id"].include?(id)
        memos.delete_at(i)
      end
    end
  end

  def self.fetch_max_id(memos)
    memos.empty? ? 1 : memos.map{|memo| memo["id"].to_i}.max + 1
  end

end