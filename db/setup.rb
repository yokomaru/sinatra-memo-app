# frozen_string_literal: true

require 'pg'

def setup
  db_create_connection = PG.connect(dbname: 'postgres')
  db_existence = db_create_connection.exec("SELECT datname FROM pg_catalog.pg_database WHERE lower(datname) = lower('sinatra_memo_app')")
  if db_existence.cmd_tuples.zero?
    db_create_connection.exec('CREATE DATABASE sinatra_memo_app')
  else
    puts 'NOTICE:  database "sinatra_memo_app" already exists, skipping'
  end
  db_create_connection.close
  table_create_connection = PG.connect(dbname: 'sinatra_memo_app')
  table_create_connection.exec('CREATE TABLE IF NOT EXISTS memos (id serial PRIMARY KEY, title varchar(100), content varchar(10000))')
  table_create_connection.close
end
