# frozen_string_literal: true

require 'json'
require 'pg'

class Memo
  FILE_PATH = 'db/memo.json'

  def self.all
    conn = set_connect
    results = conn.exec("SELECT * FROM meos")
    conn.close
    results
  end

  def self.find_by_id(id)
    conn = set_connect
    memo = conn.exec("SELECT * FROM memos where id = #{id}").to_a
    memo[0]
  end


  def self.create(params)

    conn = set_connect
    conn.exec("INSERT INTO memos (title, content) VALUES ('#{params[:title]}', '#{params[:content]}')")
    results = conn.exec("select * from memos")
    conn.close
    true
  end

  def self.update(params)

    conn = set_connect
    conn.exec("UPDATE memos SET title = '#{params[:title]}', content = '#{params[:content]}'  where id = #{params[:id]}")
    results = conn.exec("select * from memos")
    conn.close
    true
  end
  def self.destroy(id)
    conn = set_connect
    conn.exec("DELETE FROM meos where id = #{id}")
    conn.close
    true
  end

  def self.create_db
    return if File.exist?(FILE_PATH)

    File.open(FILE_PATH, 'w') do |file|
      JSON.dump([], file)
    end
  end

  private
  def self.set_connect
    PG.connect(dbname: 'postgres')
  end
end
