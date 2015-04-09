# 惚れさせ男子データベース

[![Build Status](https://travis-ci.org/june29/horesase-boys.png?branch=master)](https://travis-ci.org/june29/horesase-boys) [![Dependency Status](https://gemnasium.com/june29/horesase-boys.png)](https://gemnasium.com/june29/horesase-boys)

[地獄のミサワの「女に惚れさす名言集」](http://jigokuno.com/ "地獄のミサワの「女に惚れさす名言集」")の惚れさせ男子たちをデータベース化するプロジェクトです。

## 成果物

- [http://horesase-boys.herokuapp.com/meigens.json](http://horesase-boys.herokuapp.com/meigens.json)

## 動作環境

- Ruby 2.2.1

## 遊び方

http://jigokuno.com/ から最新の惚れさせ情報を取得して data ディレクトリ内に yml で保存する。

```
$ rake fetch
```

data ディレクトリ内の全 yml ファイルの内容と body ディレクトリ内にある本文データをまとめた dist/meigens.json を生成する。

```
$ rake build
```

## 本文データ

残念ながら、画像に書き込まれている惚れさせ本文は、このプロジェクトのスクリプトでは読み取ることができません。人間様の目によって読み取った文章をテキストファイルに打ち込むことになります。

本文データを拡充した Pull Request は、いつでも歓迎です。

## サンプルデータ

![惚れさせ1「ドラム」 - KAZ(32)](http://jigokuno.img.jugem.jp/20090111_795235.gif)

```
id: 1
title: ドラム
image: http://jigokuno.img.jugem.jp/20090111_795235.gif
character: KAZ(32)
cid: 1
eid: 1
```

本文は `body/[id].txt` に書き込みます。例:

```
この世に存在するドラムは

全て俺が叩く
```
