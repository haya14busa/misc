Vim script読書会開催します！または予習としてPlugin作るときに読むとよさそうなhelpのリストメモった
=====

気軽な感じでVim script(plugin)読書会がしたいとつぶやいたら、@osyo-mangaさんが拾ってくれて実際にVim script読書会、開催することになりました。明日開催です！気になった方は参加しましょう！詳細は以下！

[12月14日（土）21時から Vimプラグイン読書会を行います - C++でゲームプログラミング](http://d.hatena.ne.jp/osyo-manga/20131208/1386432636)

Vim script読書会#1@12/14
-----
### 読むプラギン
1. [Shougo/junkfile.vim](https://github.com/Shougo/junkfile.vim)
  - junkfile.vimの紹介記事:[Vim-users.jp - Hack #181: Vimで使い捨てのファイルを作成する](http://vim-users.jp/2010/11/hack181/)
2. [thinca/vim-visualstar](https://github.com/thinca/vim-visualstar)
  - [visualstar.vim 書いた - 永遠に未完成](http://d.hatena.ne.jp/thinca/20091125/1259075486)
  - 時間があればvisualstarよむ(はず)

### 場所
- [vim-users.jp – Lingr](http://lingr.com/room/vim)
  - Lingr知らな人は読むと良さそう。そしてそのノリで参加するといいと思います。->[プログラミング上達したいならチャットサービスLingrをつかおう（つかおう） | かなりすごいブログ](http://blog.supermomonga.com/articles/neta/lingr.html)

### 時間
- 21:00から長くても23:00まで(23:00からvimrc読書会がはじまります)


詳細とか
-----
第一回は**これからVimプラグイン書きたい**って人の勉強になるように短く、基本的なプラグインとして[Shougo/junkfile.vim](https://github.com/Shougo/junkfile.vim)を読むことになりました。

暗黒美夢王として有名なShougoさん作のプラグインですが、junkfile.vimは初心者でも読みやすい分量なので、「Vim script怖い」ってかたでも気軽に参加できます(おそらく)。あとjunkfile.vim使ったことない人(僕がそうでした)もVimでメモれる便利プラグインで面白いので、知らないプラグインだからﾅｰって人でもとっつきやすそうです。

またすでにVim scriptできるって方も、もし継続して行うことになれば時によっていろんなレベルのものを読むことになると思うので、参加するといろいろ便利だと思います。みんなでわいわいできたら楽しそうなので興味があったらぜひよろしくおねがいします。


Vim plugin書くために読んだら便利そうなhelp
-----

初心者向けとは言っても全く知らないから怖い!予習したい!って場合に読むと良さそうなhelpリストしました(よさそうなだけです)。

usr_41.txtとかeval.txtは全部読むと長いので読むとしたら絞って読むといいかもです。[:h write-plugin](http://vim-jp.org/vimdoc-ja/usr_41.html#write-plugin)あたりが目的に適ってる感じだと思います。

### :h usr_41
- [:h usr_41.txt](http://vim-jp.org/vimdoc-ja/usr_41.html#usr_41.txt)
- **[:h write-plugin](http://vim-jp.org/vimdoc-ja/usr_41.html#write-plugin)**
- [:h 'runtimepath'](http://vim-jp.org/vimdoc-ja/options.html#%27runtimepath%27)

### :h eval.txt
- [:h eval.txt](http://vim-jp.org/vimdoc-ja/eval.html#eval.txt)
- [:h autoload](http://vim-jp.org/vimdoc-ja/eval.html#autoload)
- [:h Lists](http://vim-jp.org/vimdoc-ja/eval.html#Lists)
- [:h Dictionaries](http://vim-jp.org/vimdoc-ja/eval.html#Dictionaries)
- [:h s:var](http://vim-jp.org/vimdoc-ja/eval.html#s%3Avar)
- [:h variables](http://vim-jp.org/vimdoc-ja/eval.html#variables)
- [:h functions](http://vim-jp.org/vimdoc-ja/eval.html#functions)

などなど

ブラウザでもVimのヘルプが読みたい!
-----
[haya14busa/vimdoc-marklet](https://github.com/haya14busa/vimdoc-marklet)

ブックマークレットでvimdoc@jaとかがブラウザから手軽に読めるのでおすすめしときます(宣伝)

