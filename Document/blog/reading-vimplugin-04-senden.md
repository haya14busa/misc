Vimプラグイン読書会第4回が3/15(土)21:00から開催されます
=======================================================

第4回Vimプラグイン読書会
------------------------
- 日時: 2014/03/15 Sat 21:00 -
- 場所: [LingrのVim部屋]((http://lingr.com/room/vim)
- 読むプラグイン:
  - [tpope/vim-pathogen](https://github.com/tpope/vim-pathogen)
- 目的: プラグインマネージャの仕組みを理解する


ぜひ気軽に参加してください。


pathogen読みます
----------------

かの有名なtpope先生のプラグインです。first commitが5years agoの(たぶん)一番古株のプラグインマネージャで歴史を感じます。([c9s/Vimana](https://github.com/c9s/Vimana)というのもあったらしいですがperlスクリプトで、かつどっちが先かはよくわかりません)

326行1ファイルなので分量的には気軽に読めそうです。(密度は知らない)


### 読みどころ

Vim触り始めの頃からNeoBundleやVundle,pathogenといったプラグインマネージャが存在して、vimのランタイムパスとかほぼ気にせずプラグインを簡単にインストール、管理できた身としてはそのあたりで何やってるかというのは、しばらく全くわかっていませんでした。(そして今もそこまでわかってないかも...)

と、いうことでruntimepath周りや、「プラグインマネージャって結局何をどうやってるのよ?」みたいなところが１つの読みどころかなぁと思います。

あとは関連して、ファイルやディレクトリのpathの操作などは他の用途でも汎用的に使えそうです。


pathogenの命名
--------------
- [pathogenの意味・用例｜英辞郎 on the WEB：アルク](http://eow.alc.co.jp/search?q=pathogen)
- [infectの意味・用例｜英辞郎 on the WEB：アルク](http://eow.alc.co.jp/search?q=infect)
- [incubateの意味・用例｜英辞郎 on the WEB：アルク](http://eow.alc.co.jp/search?q=incubate)

pathogenってどういう意味かなぁと思って調べると、infectやincubateといった関数が存在することから、
そのまま「病原体」の"pathogen"と"path"を掛けたっぽいですね。[要出典]

「`~/vim/bundle/`のディレクトリをvimのruntimepathという病原体(pathogen)でinfect(感染)させるぜ!」と言ったところでしょうか。

結構カッコイイ命名っぽい。


ということで
------------

明日、3/15(土)21:00から[LingrのVim部屋]((http://lingr.com/room/vim)で開催されるのでぜひワイワイ読みましょう！

初見でも初心者でも歓迎ですよ!

