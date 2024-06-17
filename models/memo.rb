# frozen_string_literal: true

require 'pg'

class Memo
  def self.all
    conn.exec('SELECT * FROM memos')
  end

  def self.find_by_id(id)
    conn.exec_prepared('select_where_id', [id]).to_a[0]
  end

  def self.create(params)
    result = conn.exec_prepared('create', [params[:content], params[:title]])
    exec_result(result)
  end

  def self.update(params)
    result = conn.exec_prepared('update', [params[:title], params[:content], params[:id]])
    exec_result(result)
  end

  def self.destroy(id)
    result = conn.exec_prepared('destroy', [id])
    exec_result(result)
  end

  def self.conn
    if @con.nil?
      @con = PG.connect(dbname: 'sinatra_memo_app')
      @con.prepare('select_where_id', 'SELECT * FROM memos where id = $1')
      @con.prepare('create', 'INSERT INTO memos (title, content) VALUES ($1, $2)')
      @con.prepare('destroy', 'DELETE FROM memos where id = $1')
      @con.prepare('update', 'UPDATE memos SET title = $1, content = $2 where id = $3')
    end
    @con
  end

  def self.exec_result(result)
    result.cmd_tuples == 1 # SQL実行によって影響のあった行が１行ある場合trueを返す
  end
end
