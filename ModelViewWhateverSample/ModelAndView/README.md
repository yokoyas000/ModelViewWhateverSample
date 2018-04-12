# 概要
この階層は Model と View のみでいい感じにやる例の階層です
- [(Qiita)ライブラリを使わずにMV*の話(iOS)〜ViewとModelの役割〜](https://qiita.com/yokoyas000/items/5aeff895233f9c1af9d4)

# ViewとModelの役割

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
        - Modelを「Viewの存在がなくても成り立つクラス」として作れる
        - Modelの状態の変更を、複数Viewに同タイミングで渡せる
        - Modelで行なった処理の結果を、Viewは受動的に知ることができる
