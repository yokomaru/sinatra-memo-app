# frozen_string_literal: true

require 'json'
require 'pg'

class Memo
  FILE_PATH = 'db/memo.json'

  def self.all
    conn = set_connect
    results = conn.exec("SELECT * FROM memos")
    conn.close
    results
  end

  def self.find_by_id(id)
    conn = set_connect
    memo = conn.exec_params("SELECT * FROM memos where id = $1", [id]).to_a
    memo[0]
  end

  def self.create(params)
    begin
      conn = set_connect
      conn.exec_params("INSERT INTO memos (title, content) VALUES ($1, $2)", [params[:content], params[:title]])
      conn.close
      true
    rescue PG::Error => err
      puts err
      false
    end
  end

  def self.update(params)
    begin
      conn = set_connect
      conn.exec("UPDATE memos SET title = $1, content = $2 where id = $3", [params[:title], params[:content], params[:id]])
      conn.close
      true
    rescue PG::Error => err
      puts err
      false
    end
  end

  def self.destroy(id)
    begin
      conn = set_connect
      conn.exec_params("DELETE FROM memos where id = $1", [id])
      conn.close
      true
    rescue PG::Error => err
      puts err
      false
    end
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
