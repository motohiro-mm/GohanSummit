# GohanSummit

![logo](app/assets/images/ogp.png)

## 概要

ごはんサミットは、家族で献立の相談と献立表の共有ができるアプリです。<br>

### 特徴

- 1つのアプリで献立の相談と献立表の登録・確認が完結できるので、アプリを複数使用することによるコピー＆ペーストの手間がなくなります
- 会議室は日付ごとに作成されるので、あとで相談の内容を見返したいときにすぐに確認ができます
- 献立表を月・週・日ごとに表示できるので、前後の献立も簡単に確認できます

## URL

https://gohansummit.com

## 使い方

### 家族を招待する

#### 1. 招待する側が招待用URLを取得する

メニュー内の「家族を招待する」から献立表ごとに招待用URLを取得できます。<br>
このURLを招待したい家族に教えてください。<br>

<img width="40%" alt="招待用ページ" src="https://github.com/user-attachments/assets/e00557b9-ff9a-427e-b0ba-3b4c330e14c1">

#### 2. 招待された側が招待用URLからログインをする

招待された家族は招待用URLにアクセスし、初回ログインをしてください。<br>
招待用URLから初回ログインをすることで、家族と同じ献立表に参加することができます。<br>

<img width="40%" alt="welcomeページ" src="https://github.com/user-attachments/assets/286ba9ec-daff-4b5a-86a7-dda20271f940">

### 献立を相談する

「会議へ」ボタンから会議室へ移動します。<br>
会議室では、その日に何を食べるのかの相談をします。<br>
食べたい料理が浮かんだら「提案する」、その他は「コメントする」をして相談していきます。<br>

<img width="40%" alt="会議室ページ" src="https://github.com/user-attachments/assets/49cae554-2284-444b-b63f-19afb4c215ad">

### 献立を献立表に登録する

#### 会議で決めた献立を登録する

会議で提案した料理をそのまま献立表に登録できます。<br>
提案した料理の「登録」ボタンから、食べるタイミングを選択して献立表に登録しましょう。<br>

<img width="40%" alt="会議からの献立登録ページ" src="https://github.com/user-attachments/assets/e09c805b-7189-48b9-816f-a548efb3634c">

#### 会議をせずに直接登録する

会議をせずに献立を直接献立表に登録することもできます。<br>
「プラス」ボタンから献立の登録ができます。<br>

<img width="40%" alt="直接献立を登録するページ" src="https://github.com/user-attachments/assets/7507a86c-c44d-4f26-b095-6650c56c6e13">

### 献立を確認する

献立表はトップページで確認できます。<br>

<img width="40%" alt="献立表ページ" src="https://github.com/user-attachments/assets/7796c7b4-df30-47f5-95ec-1f33f50acbbc">

## 環境

- Ruby 3.3.5
- Ruby on Rails 7.2.1.1
- Hotwire

## 開発環境

### セットアップ、起動

- セットアップ

```angular2html
$ git clone https://github.com/motohiro-mm/GohanSummit.git
$ cd GohanSummit
$ bin/setup
```

- 起動

```angular2html
$ bin/dev
```

- 起動後

  - 通常ログイン：下記URLからログインします<br>
    http://localhost:3000/

  - seedデータが入っている献立表：下記URLから初回ログインしてください<br>
    http://localhost:3000/welcome?invitation_token=gohan20240915seed

### Lint、Test

- Lint

```angular2html
$ bin/lint
```

- Test

```angular2html
$ bundle exec rspec
```
