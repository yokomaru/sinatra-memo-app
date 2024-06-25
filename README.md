# Welcome to メモアプリ

## What's メモアプリ?
- FBCの**Sinatra を使ってWebアプリケーションの基本を理解する**課題で作成したメモアプリです。

## Demo
![MemoAppDemo_2024061102](https://github.com/yokomaru/sinatra-memo-app/assets/44030266/27d8050b-dfdc-4951-9c71-2fd2e11e39ea)

## Description
- メモの作成・更新・削除・一覧・閲覧機能を実装しています。

## Feature
- 存在しないid、ページにアクセスすると404エラーを表示します。

## Getting Started

1. ターミナルにてカレントディレクトリをクローンしたい場所に変更します。

```shell
$ cd your-workspace
```

2. `git clone` を入力し、作成された`sinatra-memo-app`ディレクトリをカレントディレクトリにしてください。

```shell
$ git clone https://github.com/yokomaru/sinatra-memo-app.git
$ cd sinatra-memo-app
```

3. `bundle install`を実行してください。

```shell
$ bundle install
```

4. PostgreSQLを立ち上げてください。

- 以下手順はMacOSかつbrewを利用した方法になります。
- インストールがまだの場合は[PostgreSQL: macOS packages](https://www.postgresql.org/download/macosx/)よりご確認ください。

    - 起動
    ```shell
    $ brew services start postgresql
    ```

    - 停止

    ```shell
    $ brew services stop postgresql
    ```

5. メモアプリを立ち上げてください(立ち上げと同時にDBとテーブル作成処理が走ります)。

```shell
$ bundle exec ruby app.rb
```

6. `http://localhost:4567` にアクセスしてください。

## Usage
### 一覧
<img width="787" alt="一覧画面" src="https://github.com/yokomaru/sinatra-memo-app/assets/44030266/2c433635-f8e7-4151-a8e9-4816b8ab9bce">

- 作成したメモの一覧を表示
- 追加ボタンから新規作成画面に遷移
- メモの件名から詳細画面に遷移

### 新規作成
<img width="807" alt="新規作成" src="https://github.com/yokomaru/sinatra-memo-app/assets/44030266/bd945b97-8735-41f4-9177-a070dbe86f14">

- 新しいメモ作成画面の表示
- 件名と内容を記入して保存を押すとメモが作成される
  - 件名が一覧画面に表示されます
  - 作成後は一覧画面に遷移
- アプリ名または戻るボタンで一覧画面に遷移

### 詳細
<img width="747" alt="詳細" src="https://github.com/yokomaru/sinatra-memo-app/assets/44030266/6a2cd661-7386-4815-8c27-febbc1a7edeb">

- 作成したメモの詳細を表示
- 編集ボタンから編集画面に遷移
- 削除ボタンで削除
- アプリ名または戻るボタンで一覧画面に遷移

### 編集
<img width="774" alt="編集" src="https://github.com/yokomaru/sinatra-memo-app/assets/44030266/dac6e11e-f9ba-489b-96fa-9a2bd07f8a88">

- 作成したメモを編集
- 件名と内容を記入して保存を押すとメモが更新される
- 編集後は詳細画面に遷移

### 削除
- 作成したメモを削除
- 詳細画面の削除ボタンを押すと削除処理が実行
- 削除後一覧画面に遷移
