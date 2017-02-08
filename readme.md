# naosuke bot

## りくわいあめんつ

- mecab
  - `brew install mecab`
- [mecab-ipadic-neologd](https://github.com/neologd/mecab-ipadic-neologd)

## せっとあっぷ

1. mecabのデフォルト辞書をneologdに変更する
  - `/usr/local/etc/mecabrc`の`dicdir`をneologdのパスにする
2. `bundle install --path .bundle`
3. `cp env.example .env`
4. Twitterのキーを.envに保存する

## 使い方

1. twilog.orgからデータを取得する
2. `bundle exec ruby filter.rb #{Twilog orgのCSV}`
3. `bundle exec ruby twitter.rb`
