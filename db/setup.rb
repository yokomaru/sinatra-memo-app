require 'pg'

db_create_conn = PG.connect(dbname: 'postgres')
db_existence = db_create_conn.exec("SELECT datname FROM pg_catalog.pg_database WHERE lower(datname) = lower('sinatra_memo_app')")

if db_existence.cmd_tuples == 1
  puts "sinatra_memo_app already exists"
  table_create_conn = PG.connect(dbname: 'sinatra_memo_app')
  table_existence = table_create_conn.exec("SELECT * FROM information_schema.tables WHERE table_name = 'memos';")
  if table_existence.cmd_tuples == 0
    table_create_conn.exec("CREATE TABLE memos (id serial PRIMARY KEY, title varchar(100), content varchar(10000))")
  else
    puts "memos already exists"
  end
else
  db_create_conn.exec("CREATE DATABASE sinatra_memo_app")
  table_create_conn = PG.connect(dbname: 'sinatra_memo_app')
  table_create_conn.exec("CREATE TABLE memos (id serial PRIMARY KEY, title varchar(100), content varchar(10000))")
end

db_create_conn.close
table_create_conn.close
