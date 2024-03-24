[![Pull Requests Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](http://makeapullrequest.com)
[![Codemagic build status](https://api.codemagic.io/apps/65d834ac3786568a8b6ef02e/65d83d4548306436129e0db1/status_badge.svg)](https://codemagic.io/apps/65d834ac3786568a8b6ef02e/65d83d4548306436129e0db1/latest_build)

<p align="center">
  <img src="https://github.com/tinp-lab/tokeru/assets/30540418/64db0860-14aa-4a6d-b834-ecfa9589c0d5" alt="tokeru icon" width="800" />
</p>

Tokeru は、ただの TODO アプリです。  
しかし、他のどのアプリよりも常に最前面に表示されることで、今何をすべきなのかを明確にします。  

```
...目の前のタスクに集中したい、やりたいことを後回しにしたくない
```

そんなモチベーションで開発されました。

### タスクを追加する。

操作性は抜群です。タスクを追加するにはチェックリストのように「Enter」を押すだけです。

<img src="https://github.com/tinp-lab/tokeru/assets/30540418/4f9ef5fa-7c4f-47ca-ac00-c7ef5d5556ac" width="600"/>


### 最適なウィンドウサイズになります。

常に表示されますが、他のウィンドウにフォーカスしたらTodo 1つ分のサイズに小さくなります。  
Todoを整理する時は、また大きくなります。

<img src="https://github.com/tinp-lab/tokeru/assets/30540418/2c6d3ae5-d458-4dcf-8f95-742039d2083d" width="600"/>

### 瞬間移動できます。

邪魔だと感じたら"逆サイド"に移動できます。

<img src="https://github.com/tinp-lab/tokeru/assets/30540418/4cdc8773-db02-4e95-bc66-607ccc340f27" alt="tokeru icon" width="600"/>


### ショートカット対応しています。

閉じることもできます。「cmd、shift、","」でまたひらけます。

# ユーザーとして使う

TestFlight から利用できます。

https://testflight.apple.com/join/LaDGDUKa

# Tokeru開発のモチベーションと機能が解決するもの

日々のTodoには、仕事以外にもやりたいことがあり、思いついた時はモチベーションが高いはずです。  
天才だ、これをやれば成長できる！などと舞い上がる時もあります。  
しかし、Notionやタスク管理ツールのやりたいことリストに追加してもそのモチベーションが消えてしまい、結局やっていないのにチェックをつけた経験は1度や2度ではないはずです。  
Tokeruはそんなやりたいことのモチベーションの賞味期限を意識するためのプロダクトを目指しています。

### ウィンドウがずっと浮いているとどんな課題を解決するのか

Tokeruの最大の特徴として、ウィンドウがずっと浮いた状態にあります。  

<img src="https://github.com/tinp-lab/tokeru/assets/30540418/2c6d3ae5-d458-4dcf-8f95-742039d2083d" width="400"/>


普通のタスク管理ツールは、もちろん浮いていないのでTodoを追加するのにウィンドウを移動する必要があります。  
自分もそのようなタスク管理ツールを使っていましたが課題を感じていました。  

それは、1つのタスクを終えた後にTodoにチェックを入れるのを忘れ、予定していたタスクとは違う作業に取り掛かってしまうケースがあります。  
そうするとせっかく計画していたタスクは結局やらずに明日になってしまい、そのTodoはいつまで経っても完了せずにモチベーションが消えてしまいます。  

Tokeruが理想とするのは、常に今やることを意識し、それが終わったらチェックを入れて次のタスクに素早く取り掛かることです。  
今はTodo管理機能しかありませんが、今構想しているのは今日の残りの時間を表示したり、今行っているTodoにどれくらい時間をかけているかなど、今に集中するためにウィンドウを常にそばに置いています。  

### なぜTodoアプリなのにメモがあるのか

> [!WARNING]
> この機能は開発中です

Todoリストを正確に作ることは意外と難しいものです。
Todoの抽象度がバラバラだったり、時間かかるものとすぐ終わるものができてしまったり。
自分のやりたいことだとしても、それを正確に言語化するのは困難です。

Todoリストの扱いづらいところは、汚しづらいところです。
すでに作成してあるTodoがあったり、一度作ると印象的にも消しずらいため思考の発散のような作業ができません。
しかし、Todoをよりうまく作成するには発散をする必要があるのです。
やりたいと思ったことを思った瞬間に書いたり、適当にリストを作ってみたり、感情のような文章を殴り書きしたり。
そんな作業が必要です。

そのためにも"発散する場所"が必要だと考えました。
Tokeruのメモは常に浮いているためすぐに書き出すことができます。
発散した後、そのままTodoにすることもできます。

Tokeruのメモ機能はタイトル、フォルダなど一般的な便利とされる機能はないですし、ウィンドウが非アクティブになって小さくなった時にもメモ機能は表示され続けます。
それはメモをあくまで発散の手助けとして使ってほしいからです。長期的に残したいメモはNotionやメモ帳のような便利で書くのが大変なアプリにお任せしています。

### Todoが24時間で消えると何が嬉しいのか

> [!WARNING]
> この機能は開発中です

24時間で消えるTodoなんて聞いたことないと思いますが、Tokeruは個人開発なのでチャレンジングな機能を取り入れています。
そもそもTokeruの解決したい課題は、Todoの後回しによるモチベーション低下です。
つまりTodoを長い間管理することを良しとしていません。
今日やることだけをTokeruに書き出し、終わらなかったものはまた明日やりたいと思ったらTodoリストにまた書けば良いのです。
また書くという行動が大切で、昨日の自分にやれと言われたものよりも今日やりたいと思ったことの方がモチベーション高く行えます。
Tokeruは今日のモチベーションを大切にしているのです。


### なぜ今日の時間を意識するのか

> [!WARNING]
> この機能は開発中です

Tokeruの開発者は元々夜型でした。
しかし、友達と朝活を始めることで苦労の末に朝型に移行することができました。
朝型になったことのメリットは大きく、余裕もって出社できるし、体の調子も良いし、妻と寝る時間を揃えられるのも良かった点です。
しかしデメリットもありました。それは夜よりも作業をサボってしまうことでした。
なぜサボってしまうのか自分なりに考察し、導き出した答えは「1日に余裕があると錯覚している」からでした。
夜型の時は夜に個人開発をするため、「寝るまでの時間 = 作業できる時間」であるため逆算が簡単でした。
しかし朝型になり「寝るまでの時間 ≠ 作業できる時間」となり、逆算が難しくなると同時に1日に余裕があると錯覚してしまうため精神的怠惰な状態になっていました。
(アニメを見たりスマホを見ながらゴロゴロしたり)

もちろん朝型の人でも時間の捉え方には個人差があるとは思いますが、私が言いたいのは今日どれくらい作業ができるかを意識すると集中力や瞬間的なパフォーマンス力が上がるということです。
それは今取り掛かっているTodoと相性が良いことに気がつきました...!
幸いにもTokeruは常に最新のTodoを1つ表示する機能が備わっています。
是非、今日の時間を意識しながらTodoにフォーカスしてみてください。

# "Tokeru" という名前の由来

Tokeruは日本語の溶けるからきています。  
モチベーションをアイスのような"溶ける"ものだと捉えています。  
冷蔵庫から出した瞬間(頭の中からTodoリストに出した瞬間)から溶け出し、気づいた頃には食べれないほどに溶けています。  
そうならないためにも、できるだけはやくTodoを完了させ、個人のパフォーマンスを最大限発揮してもらいたいという願いからTokeruという名前が来ています。  

# 技術スタック

Flutterを採用しています。

# PR大歓迎なのでPublicにしています

Tokeru はオープンソースプロジェクトであり、コミュニティからの貢献を歓迎しています。バグ報告、機能提案、プルリクエストの提出を通じて Tokeru の改善に協力することができます。
テストコード、リファクタも大歓迎！
