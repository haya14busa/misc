1.どのプラグインを読むか
2.複数に分かれているので、全体で読んでいるファイルを合わせるのがつらそう

- 続くかわからないし、１回で読みきりたい。
- ファイル分かれてると誰がどこ読んでるかあれなので、plugin/とautoload/に主に１つずつとかだと便利そう

Candidate plugins
-----
- matchit.vim toka ランタイムプラギン
- surround.vim tim-pope
  - 1 Fileでコメントはしやすい
- thinca ware
  - ref-vim (kamichidu)
    - ちょいボリューム多い(1000オーバーくらい)
  - visual-star
    - 短い(under 100)
  - quickrun
    - murisou
  - unite history一瞬 (53)
- kana ware
  - なんかvim-textobj-usrとなにか
- mattn ware
    - gist.vimとか
- なんかunite source
- clever-f
- vital (特殊)

Vim script読書会#1@12/14
-----
1. [junkfile.vim](https://github.com/Shougo/junkfile.vim)
2. [vim-visualstar](https://github.com/thinca/vim-visualstar)

[Vim-users.jp - Hack #181: Vimで使い捨てのファイルを作成する](http://vim-users.jp/2010/11/hack181/)
[vimでメモを取るJunkFileが便利。 « wp.krks.net](http://wp.krks.net/2011/04/vim%E3%81%A7%E3%83%A1%E3%83%A2%E3%82%92%E5%8F%96%E3%82%8Bjunkfile%E3%81%8C%E4%BE%BF%E5%88%A9%E3%80%82/)
[[qfixhowm] Vim でメモ — yuyunko's blog](http://yuyunko.bitbucket.org/blog/html/2013/06/29/qfixhowm.html)
[Vim - コード片置き場](https://sites.google.com/site/codehen/environment/vim)



unite-mcdonalds-vim
clever-f
surround.vim
scall.vim
smalls.vim
vital.vim
vim-textobj-user
vim-operator-replace
unite-fold
prettyprint.vim
vim-unite-giti

kana ware
mattn ware
thinca ware
kmnk ware [仕事が捗る！VimからGitを使う最適解 | RailsとRubyとVimのブログ](http://alpaca-tc.github.io/blog/vim/how-to-use-vim-unite-giti.html)


#01 読んだ 2013/12/14 Sat 21:00
-----
- junkfile.vim
- vim-visualstar
- http://lingr.com/room/vim/archives/2013/12/14#message-17822571

#02 予定 2014/01/12 Sat 21:00
-----
- clever-f
- unite-mcdonalds-vim, unite-fold

~~~
!reading_vimrc help
1 minute ago
reading_vimrc

vimrc読書会で発言した人を集計するための bot です

!reading_vimrc {command}
"start" : 集計の開始、"member" は "reset" される（owner）
"stop" : 集計の終了（owner）
"reset" : "member" をリセット（owner）
"restore" : "member" を1つ前に戻す（owner）
"status" : ステータスの出力
"member" : "start" ～ "stop" の間に発言した人を列挙
"member_with_count" : "member" に発言数も追加して列挙
"help" : 使い方を出力
"chop {raw.github url}" : chop に url の内容をポストします（owner）
"chop_url" : chop page
~~~
メンバー確認できる
: http://lingr-bot-readingvimrc.herokuapp.com/reading_vimrc

ymlの確認できる
: http://lingr-bot-readingvimrc.herokuapp.com/reading_vimrc/yml


~~~
=== 第2回 Vimプラグイン読書会 ===

- 途中参加/途中離脱OK。声をかける必要はありません

- 読む順はとくに決めないので、好きなように読んで好きなように発言しましょう

- 特定の相手に発言/返事する場合は先頭に username: を付けます

- 一通り読み終わったら、読み終わったことを宣言してください。終了の目安にします

- ただの目安なので、宣言してからでも読み返して全然OKです

読むプラグイン: https://github.com/rhysd/clever-f.vim/tree/04d828502a474909440ce0ddaad95ffe738fdbab
~~~

### Chop
[みんなでよってたかってコメントがつけられるコード共有サービス『Chop』 | 100SHIKI](http://www.100shiki.com/archives/2011/05/chop.html)

Example:
~~~
!reading_vimrc chop https://raw.github.com/shiracha/settings/b88d5e36326a0725cfb027ccf4635069fdc216c3/.vimrc
~~~


vimrc読書会
-----
~~~
=== 第13回 vimrc読書会 ===
- 途中参加/途中離脱OK
- 読む順はとくに決めないので、好きなように読んで好きなように発言しましょう
- vimrc 内の特定位置を参照する場合は行番号で L100 のように指定します
- 特定の相手に発言/返事する場合は先頭に username: を付けます
- 一通り読み終わったら、読み終わったことを宣言してください。終了の目安にします
- ただの目安なので、宣言してからでも読み返して全然OKです
本日のvimrc: https://github.com/sorah/config/blob/master/vim/dot.vimrc
DL用リンク: https://raw.github.com/sorah/config/master/vim/dot.vimrc
それでは始めます！
~~~
