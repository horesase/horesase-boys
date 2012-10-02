# 惚れさせ男子データベース

[地獄のミサワの「女に惚れさす名言集」](http://jigokuno.com/ "地獄のミサワの「女に惚れさす名言集」")の惚れさせ男子たちをデータベース化するプロジェクトです。

## 成果物

- [https://raw.github.com/june29/horesase-boys/master/boys.json](https://raw.github.com/june29/horesase-boys/master/boys.json)

## 遊び方

http://jigokuno.com/ から最新の惚れさせ情報を取得して data ディレクトリ内に yml で保存する。

```
$ rake fetch
```

data ディレクトリ内の全 yml ファイルの内容をまとめた boys.json を生成する。

```
$ rake build
```

## 本文データ

残念ながら、画像に書き込まれている惚れさせ本文は、このプロジェクトのスクリプトでは読み取ることができません。人間様の目によって読み取った文章を yml ファイルの body に打ち込むことになります。

本文データを拡充した Pull Request は、いつでも歓迎です。
