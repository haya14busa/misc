Vimでmigemoを使って日本語でもローマ字のまま検索がしたい
=====

この記事は [Vim Advent Calendar 2013](http://atnd.org/events/45072) 75日目の記事になります。

Migemoとは
-----
- [Migemo: ローマ字のまま日本語をインクリメンタル検索](http://0xcc.net/migemo/)
- [横着プログラミング 第2回: Migemo: 日本語のインクリメンタル検索](http://0xcc.net/unimag/2/)

「Migemoとはローマ字のまま日本語を検索できるものです」みたいな紹介をしようと思ったら思ったよりも『インクリメンタル』が重要なファクターっぽいですね。今回はインクリメンタル基本的にしない/できないmigemoの紹介です。

vimでも使いたいですよね。

+kaoriyaのVimならデフォルトでmigemoが使えるけど
-----
+kaoriya以外のVimでmigemo使うのは(昔は)結構面倒くさかったように思えます。

-kaoriyaでmigemoを使う方法としては

1. [C/Migemo](http://www.kaoriya.net/software/cmigemo/)を端末にインストール
2. cmigemoと連携する Vim プラグインをインストール

なのですが、1は

```
apt-get install cmigemo
brew install cmigemo
```

などなどで割と簡単だったのですが、[koron/cmigemo](https://github.com/koron/cmigemo)のVimプラグインの部分がかなり昔から書かれていたこともありその後の2でパス通すのがつらい、プラグインのみで配布されていないのでプラグインマネージャで簡単にインストールできないなどなどちょっとつらい仕様だったので、[Vimプラグイン読書会](http://haya14busa.github.io/reading-vimplugin/)がはじまった初期の右も左もわからない時にPull Requestしてkaoriyaさんにレビューしてもらったり、プラグイン部分を独立してGitHubに上げる権限をもらったりしました。

[haya14busa/vim-migemo](https://github.com/haya14busa/vim-migemo)

ということで、昔の他の人の記事とかを見るとちょっと面倒くさいようにみえるcmigemoのVimへの導入も、

```
NeoBundle 'haya14busa/vim-migemo'
```

このように割と簡単にできるようになりました。あとvimprocが使えたら使うなどちょっとした改善もしたような記憶があります。

使い方は以前と同じで `:Migemo` コマンドまたはデフォルトで `<Leader>mi` にマッピングされています。(`<Plug>`の提供とかプロンプトの文字列の変更とかの追加はそういえばやっていないけれどしたほうがよいかな...)

別のプラグインでちょっと便利に(?)つかう
-----

基本的にどのプラグインも+kaoriyaでmigemoがデフォルトで使えればそれを、cmigemoがインストールされていればcmigemoを、どれも無理なら使えないという仕様になっていたはずです。

### [rhysd/migemo-search.vim](https://github.com/rhysd/migemo-search.vim)
つい先日、[vim日本語検索をちょっと便利にするmigemo検索 | TechRacho](http://techracho.bpsinc.jp/yamasita-taisuke/2014_02_06/15331)で紹介されていましたがLindanさん ware の[rhysd/migemo-search.vim](https://github.com/rhysd/migemo-search.vim)というプラグインがあります。

```
NeoBundle 'rhysd/migemo-search.vim'
if executable('cmigemo')
    cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
endif
```

これは`<CR>`にマッピングすることで、Vimデフォルトの検索をするときに、検索文字列がローマ字っぽかったらmigemoをよしなに読んでくれるというものです。こちらの仕様のほうが好きな人はオススメです。個人的にはちょっと試した程度でほぼ使っていないので実は使用感はお伝え出来ません。

### Uniteのmatcherにmigemoを使う
[Shougo/unite.vim](https://github.com/Shougo/unite.vim)

:h unite-filter-matcher_migemo

```
NeoBundle 'Shougo/unite.vim'
nnoremap <silent> g/ :<C-u>Unite -buffer-name=search line -start-insert<CR>
call unite#custom#source('line', 'matchers', 'matcher_migemo')
```

実はUniteのmatcherの１つにmigemo機能があります。なので、Vimデフォルトの検索とは
操作法が異なりますが、lineソースにmigemoのmatchersを充ててmigemo検索をUniteですることができます。

### EasyMotionのmigemo機能
[Lokaltog/vim-easymotion](https://github.com/Lokaltog/vim-easymotion)

2012年のVAC記事([Vim-Easymotionを拡張してカーソルを縦横無尽に楽々移動する « haya14busa](http://haya14busa.com/vim-lazymotion-on-speed/))でEasyMotionで1文字migemoを使えるようにしたと紹介したのですが、最近 n-key motionとして任意の数のキーでEasyMotionできるVimデフォルトの検索の拡張を実装したので、cmigemoがインストールかつ、migemoオプションがオンなら同様にEasyMotionでもmigemo検索できるようになりました。

```
NeoBundle 'Lokaltog/vim-easymotion'
map g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn) " opeartor-pending時にVimデフォルトの検索の仕様に合わせる
```

このあたりは全く別の記事でまた紹介したいのですが、このEasyMotionの検索機能の拡張とも言うべき機能は、インクリメンタルにハイライトしたり、普通のEasyMotionの機能と違って画面外まで飛んだり、`<Tab>`キーでスクロールできたり、勿論検索履歴やテキストオブジェクト`gn`とも連携させたりしているので、完璧とは言わない間でもデフォルトの検索をこれに置き換えてもよいかなぁというレベルになっています。

#### 仕様
もともとEasyMotionが**スクリーン内**の移動を拡張するというコンセプトなので、仕様としてはmigemo機能がONになっていてもスクリーン上にマルチバイト文字が無ければmigemoを使わないようになっています。なので、普段コードを書くときにmigemoによって遅くならないようになっているともいえるし、画面外に日本語があるとはわかっているんだけど画面内に日本語が無ければ発動しないという残念仕様でもあるとは言えますね...

またインクリメンタルハイライトにmigemoを対応させていないので、実はMigemoに関してはインクリメンタルハイライトの一貫性がなくなってしまっている状態(インクリメンタルにハイライトはされていなくても`<CR>`で実行するとマッチする)なのでmigemo機能として使うには実はあんまりオススメはできません()。現状での仕様をわかった上で使ってくれたらいいかなぁと思います。

というのも、システムのcmigemoを呼ぶという性質上、毎回のinputでインクリメンタルにcmigemoを呼ぶと、とてもじゃないけど耐えらたものじゃない速度になってしまい、実装してみましたが敢え無く断念しました。このためにProcessManagerも使ってみたんですがやっぱりダメでした...無念。

そのうち要望 or 気が向いたら、インクリメンタル検索中のキーマッピングとしてmigemo使って一時的にハイライトさせるみたいな機能を実装するかもしれません。(それでも不便感は拭えないですが...)


### まとめ

migemoで日本語の検索も出来てよいです。ただ+kaoriyaコンパイル以外でのインクリメンタル検索は基本つらいのでまだ改善の余地はあるかもしれないですね。

それでは [Vim Advent Calendar 2013](http://atnd.org/events/45072) 75日目の記事でした。

