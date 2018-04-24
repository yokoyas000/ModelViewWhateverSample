# 概要

MVWhateverの種類と実装の例

## ModelViewWhateverSample/OnlyModelAndView

Model と View のみでいい感じにやる例の階層です

- [Qiita](https://qiita.com/yokoyas000/items/5aeff895233f9c1af9d4)

### 言いたいこと

1. Viewとは
    - 画面/要素の表示を行う
    - ユーザー操作の受付を行う
    - (動作を受付た後の処理を決める)
1. Modelとは
    - なんらかの状態・値を持つ
    - Modelの外から指示を受け処理を行う
    - 状態・値の変化をModelの外へ **間接的に** 知らせる機能持つ
1. 間接的な通知方法として、Observerパターンを利用する
    - 理由
        - Modelを「Model単独で成り立つクラス」として作れる
        - Modelの状態の変更を、複数Viewに同タイミングで渡せる
        - Modelで行なった処理の結果を、Viewは受動的に知ることができる

<img width="764" src="https://github.com/yokoyas000/ModelViewWhateverSample/blob/master/images/MV-Whatever.002.jpg">


## ModelViewWhateverSample/ModelViewWhatever

Whatever の部分の種類など

- [Qiita](https://qiita.com/yokoyas000/items/8f4db2b3c5f622690d14)

### 言いたいこと

- アプリの責務の分け方
    - Model
        - アプリ内で扱う状態・値を持つ
        - Modelの外から指示を受け処理を行う
        - 状態・値の変化をModelの外へ間接的に知らせる
    - View/Whatever
        - 画面の構築/表示
        - ユーザー操作の受付
        - アクションを定義する
        - アクションの結果/途中経過を受け取る
        - 内部表現を視覚表現へ変換する
    - MVWhateverの種類
        - View/Whatever間での仕事の分け方は複数ある
        - (Model-View-Whatever 間の接続の仕方も複数ある)
- 分けた後のクラス連結の仕方
    - Commandパターン(直接指示する)
    - Observerパターン(間接的に通知する)

### ModelViewWhateverSample/ModelViewWhatever/ModelViewController/Sample1
※ 当Repositoryでの役割の分け方,クラス間接続の図解
 「MVCといったらこれ」と言っているわけではないです。(得心しているverではあります。)
<img width="764" src="https://github.com/yokoyas000/ModelViewWhateverSample/blob/master/images/MV-Whatever.007.jpg">

### ModelViewWhateverSample/ModelViewWhatever/ModelViewPresenter/Sample2
※ 当Repositoryでの役割の分け方,クラス間接続の図解
 「MVPといったらこれ」と言っているわけではないです。
<img width="764" src="https://github.com/yokoyas000/ModelViewWhateverSample/blob/master/images/MV-Whatever.008.jpg">

### ModelViewWhateverSample/ModelViewWhatever/ModelViewViewModel/Sample
※ 当Repositoryでの役割の分け方,クラス間接続の図解
 「MVVMといったらこれ」と言っているわけではないです。(得心しているverではあります。)
<img width="764" src="https://github.com/yokoyas000/ModelViewWhateverSample/blob/master/images/MV-Whatever.009.jpg">

