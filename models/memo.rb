# frozen_string_literal: true

require 'json'
require 'pg'

class Memo
  FILE_PATH = 'db/memo.json'

  def self.all
    conn.exec("SELECT * FROM memos")
  end

  def self.find_by_id(id)
    conn.exec_prepared("select_where_id", [id]).to_a[0]
  end

  def self.create(params)
    result = conn.exec_prepared("create", [params[:content], params[:title]])
    exec_result(result)
  end

  def self.update(params)
    result = conn.exec_prepared("update", [params[:title], params[:content], params[:id]])
    exec_result(result)
  end

  def self.destroy(id)
    result = conn.exec_prepared("destroy", [id])
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
      if @con.nil?
        @con = PG.connect(dbname: 'postgres')
        @con.prepare("select_where_id", "SELECT * FROM memos where id = $1")
        @con.prepare("create", "INSERT INTO memos (title, content) VALUES ($1, $2)")
        @con.prepare("destroy", "DELETE FROM memos where id = $1")
        @con.prepare("update", "UPDATE memos SET title = $1, content = $2 where id = $3")
      end
      @con
    end

    def self.exec_result(result)
      result.cmd_tuples == 1 ? true : false
    end

end
