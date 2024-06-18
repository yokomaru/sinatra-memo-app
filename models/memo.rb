# frozen_string_literal: true

require 'pg'

class Memo
  class << self
    def all
      conn.exec('SELECT * FROM memos')
    end

    def find_by_id(id)
      conn.exec_prepared('select_where_id', [id]).to_a[0]
    end

    def create(params)
      result = conn.exec_prepared('create', [params[:content], params[:title]])
      exec_result(result)
    end

    def update(params)
      result = conn.exec_prepared('update', [params[:title], params[:content], params[:id]])
      exec_result(result)
    end

    def destroy(id)
      result = conn.exec_prepared('destroy', [id])
      exec_result(result)
    end

    def conn
      if @con.nil?
        @con = PG.connect(dbname: 'sinatra_memo_app')
        @con.prepare('select_where_id', 'SELECT * FROM memos where id = $1')
        @con.prepare('create', 'INSERT INTO memos (title, content) VALUES ($1, $2)')
        @con.prepare('destroy', 'DELETE FROM memos where id = $1')
        @con.prepare('update', 'UPDATE memos SET title = $1, content = $2 where id = $3')
      end
      @con
    end

    def exec_result(result)
      result.cmd_tuples == 1 # SQL実行によって影響のあった行が１行ある場合trueを返す
    end
  end
end
