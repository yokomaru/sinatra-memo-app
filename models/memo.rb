# frozen_string_literal: true

require 'json'
require 'pg'

class Memo
  FILE_PATH = 'db/memo.json'

  def self.all
    conn.exec("SELECT * FROM memos")
  end

  def self.find_by_id(id)
    conn.exec_params("SELECT * FROM memos where id = $1", [id]).to_a[0]
  end

  def self.create(params)
    result = conn.exec_params("INSERT INTO memos (title, content) VALUES ($1, $2)", [params[:content], params[:title]])
    exec_result(result)
  end

  def self.update(params)
    result = conn.exec_params("UPDATE memos SET title = $1, content = $2 where id = $3", [params[:title], params[:content], params[:id]])
    exec_result(result)
  end

  def self.destroy(id)
    result = conn.exec_params("DELETE FROM memos where id = $1", [id])
    exec_result(result)
  end

  def self.create_db
    return if File.exist?(FILE_PATH)

    File.open(FILE_PATH, 'w') do |file|
      JSON.dump([], file)
    end
  end

  private
    def self.conn
      @con ||= PG.connect(dbname: 'postgres')
    end

    def self.exec_result(result)
      result.cmd_tuples == 1 ? true : false
    end

end
