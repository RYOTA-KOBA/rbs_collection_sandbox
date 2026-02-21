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
# または
rake setup
```

### 2. RBS 生成と型検査を一括実行する（Rake）

```bash
# 全 gem に対して実行
rake

# 特定の gem に対してのみ実行
rake check[<gem名>]
```

### 手動で実行する場合

```bash
# RBS の生成（特定の gem）
bin/rbs_inline <gem名>

# 型検査（全 gem）
bin/steep_check

# 型検査（特定の gem）
bin/steep_check <gem名>
```

## 例: colorize

`gems/colorize/` に colorize gem の型定義テストが含まれています。

- `gems/colorize/_test/sample.rb` — colorize を使用したサンプルコード（rbs-inline アノテーション付き）
- `gems/colorize/sig/colorize.rbs` — colorize gem の型定義
- `gems/colorize/sig/generated/_test/sample.rbs` — rbs-inline で生成された型定義

## 例: rubyXL

`gems/rubyXL/` に rubyXL gem (3.4.27) の型定義テストが含まれています。

- `gems/rubyXL/_test/sample.rb` — rubyXL を使用したサンプルコード（rbs-inline アノテーション付き）
- `gems/rubyXL/sig/rubyXL.rbs` — rubyXL gem の型定義
- `gems/rubyXL/sig/generated/_test/sample.rbs` — rbs-inline で生成された型定義

## 新しい gem を追加する手順

1. `gems/<gem名>/` ディレクトリを作成する
2. `gems/<gem名>/_test/sample.rb` にサンプルコードを記述する（`# rbs_inline: enabled` を先頭に追加）
3. `gems/<gem名>/sig/<gem名>.rbs` に gem の型定義を記述する
4. `Steepfile` に新しいターゲットを追加する
5. `rake check[<gem名>]` で RBS 生成と型検査を実行する
