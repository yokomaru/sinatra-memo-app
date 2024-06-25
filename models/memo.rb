# frozen_string_literal: true

require 'pg'

class Memo
  class << self
    def all
      connection.exec('SELECT id, title FROM memos ORDER BY id ASC')
    end

    def find_by_id(id)
      connection.exec_prepared('select_where_id', [id]).to_a[0]
    end

    def create(params)
      result = connection.exec_prepared('create', [params[:content], params[:title]])
      exec_result(result)
    end

    def update(params)
      result = connection.exec_prepared('update', [params[:title], params[:content], params[:id]])
      exec_result(result)
    end

    def destroy(id)
      result = connection.exec_prepared('destroy', [id])
      exec_result(result)
    end

    def connection
      if @connection.nil?
        @connection = PG.connect(dbname: 'sinatra_memo_app')
        @connection.prepare('select_where_id', 'SELECT id, title, content FROM memos where id = $1')
        @connection.prepare('create', 'INSERT INTO memos (title, content) VALUES ($1, $2)')
        @connection.prepare('destroy', 'DELETE FROM memos where id = $1')
        @connection.prepare('update', 'UPDATE memos SET title = $1, content = $2 where id = $3')
      end
      @connection
    end

    def exec_result(result)
      result.cmd_tuples == 1 # SQL実行によって影響のあった行が１行ある場合trueを返す
    end
  end
end
