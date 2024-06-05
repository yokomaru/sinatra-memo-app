# Welcome to Memo App

## What's Memo App?
- FBCの**Sinatra を使ってWebアプリケーションの基本を理解する**課題で作成したメモアプリです。

## Demo

## Description
- メモの作成・更新・削除・一覧・閲覧機能を実装しています。

## Feature
- 存在しないid、ページにアクセスすると404エラーが表示されます。

## Getting Started

1. ターミナルにてカレントワーキングディレクトリを、ディレクトリをクローンしたい場所に変更します。

  ```zsh
  $ cd your-workspace
  ```

2. git clone を入力し、作成された`sinatra-memo-app`ディレクトリをカレントワーキングディレクトリを移してください。

  ```zsh
  $ git clone https://github.com/yokomaru/sinatra-memo-app.git
	$ cd sinatra-memo-app
  ```

3.bundle installを実行してください

	```zsh
		$ bundle install
	```

4. MemoAppを立ち上げてください

	```zsh
	$ bundle exec ruby app.rb
	```

5. `http://localhost:4567` にアクセスしてください


## Usage

### 一覧
   - 作成したメモの一覧を表示
   - 追加ボタンから新規作成画面に遷移
   - メモの件名から詳細画面に遷移
### 新規作成
   - 新しいメモ作成画面の表示
   - 件名と内容を記入して保存を押すとメモが作成される
      - 件名が一覧画面に表示されます
   - アプリ名または戻るボタンで一覧画面に遷移
### 詳細
   - 作成したメモの詳細を表示
   - 編集ボタンから編集画面に遷移
   - 削除ボタンで削除
   - アプリ名または戻るボタンで一覧画面に遷移
### 削除
   - 作成したメモを削除
   - 削除後一覧画面に遷移
### 編集
  - 作成したメモを編集
  - 件名と内容を記入して保存を押すとメモが更新される
  - 編集後は詳細画面に遷移