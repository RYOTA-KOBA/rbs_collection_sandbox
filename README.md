# rbs_collection_tester

このリポジトリは [gem_rbs_collection](https://github.com/ruby/gem_rbs_collection) に型定義を提出する前にローカルで動作確認するためのリポジトリです。

## ディレクトリ構成

```
gems/
  <gem名>/
    _test/
      sample.rb           # rbs-inline アノテーション付きのサンプルコード
    sig/
      <gem名>.rbs         # gem の型定義ファイル（手動で作成）
      generated/
        _test/
          sample.rbs      # rbs-inline で生成された型定義
```

## 使い方

### 1. セットアップ

```bash
bundle install
```

### 2. サンプルコードから RBS を生成する

```bash
# gems/<gem名> ディレクトリに移動して実行
cd gems/<gem名>
bundle exec rbs-inline --output _test/
```

### 3. 型検査を実行する

```bash
bundle exec steep check
```

## 例: colorize

`gems/colorize/` に colorize gem の型定義テストが含まれています。

- `gems/colorize/_test/sample.rb` — colorize を使用したサンプルコード（rbs-inline アノテーション付き）
- `gems/colorize/sig/colorize.rbs` — colorize gem の型定義
- `gems/colorize/sig/generated/_test/sample.rbs` — rbs-inline で生成された型定義

## 新しい gem を追加する手順

1. `gems/<gem名>/` ディレクトリを作成する
2. `gems/<gem名>/_test/sample.rb` にサンプルコードを記述する（`# rbs_inline: enabled` を先頭に追加）
3. `gems/<gem名>/sig/<gem名>.rbs` に gem の型定義を記述する
4. `cd gems/<gem名> && bundle exec rbs-inline --output _test/` で型定義を生成する
5. `Steepfile` に新しいターゲットを追加する
6. `bundle exec steep check` で型検査を実行する
