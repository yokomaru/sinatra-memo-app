require 'pg'

conn = PG.connect(dbname: 'postgres')
conn.exec("DROP DATABASE sinatra_memo_app")
conn.exec("CREATE DATABASE sinatra_memo_app")
conn.exec("CREATE TABLE memos (id serial PRIMARY KEY, title varchar(100), content varchar(10000))")
conn.close
