# 惚れさせ男子データベース

[![Build Status](https://travis-ci.org/june29/horesase-boys.png?branch=master)](https://travis-ci.org/june29/horesase-boys) [![Dependency Status](https://gemnasium.com/june29/horesase-boys.png)](https://gemnasium.com/june29/horesase-boys)

[地獄のミサワの「女に惚れさす名言集」](http://jigokuno.com/ "地獄のミサワの「女に惚れさす名言集」")の惚れさせ男子たちをデータベース化するプロジェクトです。

## 成果物

- [http://june29.github.io/horesase-boys/meigens.json](http://june29.github.io/horesase-boys/meigens.json)

## 動作環境

- Ruby 2.2.2

## 遊び方

http://jigokuno.com/ から最新の惚れさせ情報を取得して data ディレクトリ、及び body ディレクトリにデータをファイルで保存する。

```
$ rake fetch
```

data ディレクトリ内の全 yml ファイルの内容と body ディレクトリ内にある本文データをまとめた dist/meigens.json を生成する。

```
$ rake build
```

## 本文データ

`rake fetch` で取得する本文データは、本文中の改行を反映できていません。惚れさせ画像を見ながら、適切な位置に改行を補ってデータを完成させます。

本文データを拡充・修正する Pull Request は、いつでも歓迎です。

## サンプルデータ

![惚れさせ1「ドラム」 - KAZ(32)](http://livedoor.4.blogimg.jp/jigokuno_misawa/imgs/6/b/6bb141f8.gif)

```
id: 1
title: ドラム
image: http://livedoor.4.blogimg.jp/jigokuno_misawa/imgs/6/b/6bb141f8.gif
character: KAZ(32)
cid: 1
eid: 1
```

本文は `body/[id].txt` に書き込みます。例:

```
この世に存在するドラムは

全て俺が叩く
```
