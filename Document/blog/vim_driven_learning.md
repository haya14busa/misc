Vim駆動学習を始めよう! Vim Driven Learning
=====

この記事は [Vim Advent Calendar 2013](http://atnd.org/events/45072) 78日目の記事になります。私事ですが本日2014/02/16日、1歳の誕生日(Vim歴換算)を迎えました(!)ので個人的な話題を含むVACの記事になります。そういうものが嫌いな方はブラウザバック推奨です。

vimtutorを終えた一年前のツイート:

https://twitter.com/haya14busa/statuses/302754464400568320?tw_i=302754464400568320&tw_e=details&tw_p=archive

(ツイートの文面が恥ずかしい...)

Vim歴1年めでたいです。うれしい。

『Vim駆動学習』
-----
なぜ『Vim駆動学習』というタイトルかというと、僕のプログラミング歴自体がVim歴+半年弱程度なので、僕のプログラミング力の大部分は『Vim駆動』で学習し、向上してきたといっても過言ではないからです。そして、『Vim駆動』で学習してきて自分自身良かったと思っています。

(最近はVim駆動でVim script,つまりVim自体を学んでいる割合が高すぎるのでそろそろVim以外の進捗もだしていこうと反省はしていますが...)

<!-- 付け加えると、別に駆動開発でもよいです。 -->

『Vim駆動学習』によって得られた物
-----
### 1. GitHubでStars over 1000(!)のリポジトリをメイン開発する経験
- vim-easymotionというカーソル移動系のVimプラグイン
- Repository: [https://github.com/Lokaltog/vim-easymotion](https://github.com/Lokaltog/vim-easymotion)

1からスターover 1000のリポジトリを作り上げたわけでは勿論なく、プログラミング力というより単なる活動量のゴリ押しとアイデアによって、開発が止まっていたプロジェクトを乗っ取った(collaboratorになって開発しませんかと提案された)というのが現実です。実は数字に見合うほどのことはできていないです。

しかし、これだけユーザー数が多いプラグインを扱えるというのはｸﾞｻｸﾞｻくるissueがちょっぴりつらいものの、今までに無い経験でとても楽しく、『Vim駆動学習』としてVim プラグインを扱うならではのものだと思います。

<!-- 主観ですが同じくらいの経験で他の言語でこれほどのユーザーがいる開発を個人でするにはまずプログラミング力が足りていないと思うので Vim プラグインという手軽さがなせる技かなぁと思います。 -->

また単にプロジェクトを引き継いでメンテナンスしているというだけではないのでちょっとずつスターも増えて

プログラミング力を上げて
『Vim駆動学習』で

海外のユーザーの方もよく使ってくれている、むしろもともと日本人より多い(はず)なので無い英語力を引っ張りだして無理やり使ういい機会にもなりました。

### 3. Vimコミュニティへの参加
### 2. 公式ドキュメントを読む大事さ
### 4. 以前と比べて数十倍の生産性(妄想)
### 4. **プログラミングが楽しいと思える心**



vimrcの記録
-----
Vimの戦闘力は単純にvimrcの行数が多ければいいというわけではありませんが１つの指標として
<!-- 調べてみました。 -->

一応Scouter情報も載せます。

- [thinca/vim-scouter](https://github.com/thinca/vim-scouter)
- [Vim-users.jp - Hack #39: Vimの戦闘力を計測する](http://vim-users.jp/2009/07/hack-39/)

### 一年前のvimrc
- Date: 2013/02/16
- Lines:0

厳密にはとある方が公開されていたシンプルな100行未満のvimrcを最初に使用していました。プラグインなし、基本オプション設定のみのものだった気がします。

### git & GitHub 使い始めのvimrc
- Date: 2013/07/16
- Source: https://github.com/haya14busa/dotfiles/blob/2f3395fb468892764f69e4126e24c11b78a9cad3/.vimrc
- Lines:205
- Scouter:156

大体半年後ですがあんまり増えてないですね

### 現在のvimrc
- Date: 2014/02/16
- Source:
- Lines: 2789
- Scouter: 1288

Outline
====
- vimを使ってちょうど一年
- プログラミング歴はvim歴プラス半年ほど
- プログラミング力の向上
- プログラミングが楽しくなる
- 一生使える物。学習コストを差し引いてもお釣りが絶対くる
- vim-easymotion, GitHub stars over 1000のリポジトリでメインで開発しています!乗っ取り
- 英語,ライセンス,テスト
- gitやtmuxもvimを覚えてから始めた
- Vimプラグイン読書会を運営
- Vimのヘルプを翻訳(オプション1つだけ)
- GitHubのCurrent Streak続けてます
- Vimをはじめた動機
- Vim活記録 -> How to learn vim

どうやってVimを学んだか
-----
- help
- Lingr
- vimrc読書会
- Vimプラグイン読書会
- Vim Advent Calendarを読む/書く
- その他Vimに関する記事
- 実践Vim(Plactical Vim)
- VimConf2013
- 番外編: 英語,スクリーンキャスト
  - reddit, vim\_dev, screencaset

どうやってvimrcを成長させたか
-----
- はじめはコピー
- よかったこと/悪かったこと
- 知らないプラグインは入れない

どうやってVim pluginを開発しはじめるか
-----
- vimrc読書会
- Vimプラグイン読書会
- LingrやTwitterで上級Vimmerに教えてもらう
- vitalなどライブラリを使わせてもらう

1年間使ってみて選ぶおすすめプラグイン10選
-----
1年間使ってみて選ぶおすすめvimrc Tips10選
-----

Vimのここが好き
-----
- テキストオブジェクト(textobject)
- 繰り返し操作('.' repeat, macro)
- コミュニティーが活発
  - Lingr
  - vim-jp
- ubiqutious

MEMO
----
- Lingr初発言: http://lingr.com/room/vim/archives/2013/09/30
