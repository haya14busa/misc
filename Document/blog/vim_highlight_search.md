Vimの検索ハイライト,hlsearch,:nohlsearch,v:hlsearchがややこしい
=====

この記事は [Vim Advent Calendar 2013](http://atnd.org/events/45072) 73日目の記事になります。

普段何気なくvimrcに書いている`set hlsearch`や`:nohlsearch`。実はこれ、結構ややこしいです。

まずはhelp!
-----
- [:h 'hlsearch'](http://vim-jp.org/vimdoc-ja/options.html#%27hlsearch%27) <- オプション
- [:h :nohlsearch](http://vim-jp.org/vimdoc-ja/pattern.html#:nohlsearch) <- コマンド
- [:h v:hlsearch](http://vim-jp.org/vimdoc-ja/eval.html#v:hlsearch) <- 新たなる変数(最近入った)

そして他に注意すべきものとして

- `set nohlsearch` <- `set hlsearch`の逆。**`:nohlsearch`とは違う**
- `&hlsearch` <- オプションhlsearchの値の変数。`set hlsearch`なら1,`set nohlsearchなら0`

ややこしいですね。

v:hlsearchを解説しながら全体的に説明するよ
-----
最近縁があったのでv:hlsearchの日本語訳を書かせて頂きましたが、ぶっちゃけ元の英語の説明もわかりづらいのでここで解説します。

```
                                        *v:hlsearch* *hlsearch-variable*
v:hlsearch      検索による強調表示がオンになっているかどうかを決定する変数。
                |+extra_search| 機能が必要な 'hlsearch' が有効になっている
                時のみ意味をなす。この変数を0に設定することは、 |:nohlsearch|
                コマンドを実行することと同様に働き、1に設定することは以下と
                同様に働く
                        let &hlsearch = &hlsearch
```

まず仕様ですが、この変数は**実際に現在**検索によるハイライトが行われているかどうかを判定、決定できます。

### 判定
```
echo v:hlsearch
```
- ハイライトが行われている -> 1
- ハイライトが行われていない -> 0

### 決定(ハイライトをON or OFFにする)

> この変数を0に設定することは、 |:nohlsearch| コマンドを実行することと同様に働き、
  1に設定することは以下と同様に働く
        let &hlsearch = &hlsearch

わかりずらい!!!

#### let v:hlsearch = 0
これは、helpによると`:nohlsearch`コマンドを実行することと同様に働きます。

- [:h :nohlsearch](http://vim-jp.org/vimdoc-ja/pattern.html#:nohlsearch)

> |:nohlsearch| コマンドを使うと、**一時的に**強調表示をやめさせることができます。

**一時的に** というのがミソです。この`:nohlsearch`コマンドは`hlsearch`オプションの変数である、`&hlsearch`を変更しないのです。つまり`set hlsearch`している場合`&hlsearch`変数の値は1ですが、`:nohlsearch`を実行しても`&hlsearch`の値は1のままでハイライトを一時的にオフにします。

#### let v:hlsearch = 1
helpによると1に設定することは

```
let &hlsearch = &hlsearch
```

をすることと同様に働くようです。ここがかなりわかりずらい。

前提として、

1. 基本的に`v:hlsearch`は実際にハイライトを行っているかどうかを決定するのですが`set nohlsearch`が設定されていた場合は`set nohlsearch`が優先されます。
2. コマンド`:nohlsearch`によって一時的にハイライトをオフにした場合、再び検索するなどしたときにハイライトが有効になるのですが、`set hlsearch`,つまりは**`let &hlsearch = 1`**を設定した場合も同様にトリガーとなってハイライトが有効になります(実装は見ていないので予測含む。動作確認はしています)

よって、もし`set nohlsearch`が設定されていれば`&hlsearch`の値は0なので`let &hlsearch = 0`と同様の動作となり何も起こりません。

反対に、`set hlsearch`が設定されていれば`&hlsearch`の値は1で、`let &hlsearch = 1`と同様になり、前提の2からこの動作がトリガーとなって再びハイライトがONになります。

はぁ、ややこしかった。わからなかった方は直接@haya14busaまで質問とかしてください。また間違ってたらご指摘よろしくおねがいします。

ここから`v:hlsearch`から得られたTipsを2つ紹介します

Reloadableなvimrcの設定
-----
一般的には下記のような設定をしている方が多いと思います
```
set hlsearch
nnoremap <silent><Esc><Esc> :<C-u>nohlsearch<CR>
```

が、リローダブルなvimrcを目指している方はこの問題に少なからず気づいているかもしれません。

つまり、`set hlsearch`を記述しているとリロード時に問答無用でハイライトされてしまうのです。(ｳｻﾞｲ

これを改善しましょう

### 1. 簡単かつv:hlsearchがなくてもOK

```
" hlsearchは使うがvimrcを読み込んだ時にハイライトしないようにする
set hlsearch | nohlsearch
```

上記のようにすると`&hlsearch`の値は1で検索のハイライトは有効になっていますが、`:nohlsearch`コマンドによりそれを一時的にOFFにします。

欠点: ハイライトしている状態でリロードするとハイライトが消えてしまう。

### 2. v:hlsearchを使って1の欠点をなくす
```
if exists('v:hlsearch')
  let v_hl_save = v:hlsearch
endif
set hlsearch
execute exists('v:hlsearch') ? 'let v:hlsearch = v_hl_save' : 'nohlsearch'
```

欠点: 書き方が悪いということを除いてもわざわざそこまでしたくない...

スクリプトから扱う
-----
### ハイライトを確認する
`v:hlsearch`が登場する以前では`&hlsearch`の値を見ることしかできず、ハイライトの設定がされているかどうかは分かるけれども、実際にハイライトされているかどうかがわかりませんでした。(`:nohlsearch`で一時的にハイライトしていなくても`set hlsearch`していれば一貫して`&hlsearch`の値は1です)

`v:hlsearch`の登場によって改善されたのはほぼこの一点といってもいいでしょう。

### 実際に関数からハイライトさせる
- [Vim の関数内で set hlsearch しても反映されない場合の対処方法 - C++でゲームプログラミング](http://d.hatena.ne.jp/osyo-manga/20131021/1382346459)

上記の記事の問題は`v:hlsearch`でも同じなようで、関数内で`let v:hlsearch = 1`にしても実行が終わると勝手に元の値に戻されてしまいます。これを回避するには記事にあるように[:h feedkeys()](http://vim-jp.org/vimdoc-ja/eval.html#feedkeys%28%29)を使うしかないようです。残念...

#### ちょっと改善
上記の記事の関数だと`set nohlsearch`のオプションを無視してしまうので下記のように`:let &hlsearch=&hlsearch\<CR>`を使うとよりお行儀よくハイライトさせることができます。

[gist id=8937102]

最後に
-----
最新への追従 #84: [https://github.com/vim-jp/vimdoc-ja/issues/84](https://github.com/vim-jp/vimdoc-ja/issues/84)

Vimの日本語訳がオリジナルのヘルプに追従しきれていないようです。実際`v:hlsearch`を訳して、レビューしてもらったりしましたが、結構新鮮で面白かったしこれからも暇があれば、僕も日本語訳に参加して貢献できればいいなと思います。人手は足りていないようなので、気になった方は簡単な/分かるところからでもいいから訳して、vim-jpに投げてみるといいのではないでしょうか。きっとみんな優しくしてくれると思います。

Vimの検索ハイライト,hlsearch,:nohlsearch,v:hlsearchがややこしい
=====

この記事は [Vim Advent Calendar 2013](http://atnd.org/events/45072) 73日目の記事になります。

普段何気なくvimrcに書いている`set hlsearch`や`:nohlsearch`。実はこれ、結構ややこしいです。

まずはhelp!
-----
- [:h 'hlsearch'](http://vim-jp.org/vimdoc-ja/options.html#%27hlsearch%27) <- オプション
- [:h :nohlsearch](http://vim-jp.org/vimdoc-ja/pattern.html#:nohlsearch) <- コマンド
- [:h v:hlsearch](http://vim-jp.org/vimdoc-ja/eval.html#v:hlsearch) <- 新たなる変数(最近入った)

そして他に注意すべきものとして

- `set nohlsearch` <- `set hlsearch`の逆。**`:nohlsearch`とは違う**
- `&hlsearch` <- オプションhlsearchの値の変数。`set hlsearch`なら1,`set nohlsearchなら0`

ややこしいですね。

v:hlsearchを解説しながら全体的に説明するよ
-----
最近縁があったのでv:hlsearchの日本語訳を書かせて頂きましたが、ぶっちゃけ元の英語の説明もわかりづらいのでここで解説します。

```
                                        *v:hlsearch* *hlsearch-variable*
v:hlsearch      検索による強調表示がオンになっているかどうかを決定する変数。
                |+extra_search| 機能が必要な 'hlsearch' が有効になっている
                時のみ意味をなす。この変数を0に設定することは、 |:nohlsearch|
                コマンドを実行することと同様に働き、1に設定することは以下と
                同様に働く
                        let &hlsearch = &hlsearch
```

まず仕様ですが、この変数は**実際に現在**検索によるハイライトが行われているかどうかを判定、決定できます。

### 判定
```
echo v:hlsearch
```
- ハイライトが行われている -> 1
- ハイライトが行われていない -> 0

### 決定(ハイライトをON or OFFにする)

> この変数を0に設定することは、 |:nohlsearch| コマンドを実行することと同様に働き、
  1に設定することは以下と同様に働く
        let &hlsearch = &hlsearch

わかりずらい!!!

#### let v:hlsearch = 0
これは、helpによると`:nohlsearch`コマンドを実行することと同様に働きます。

- [:h :nohlsearch](http://vim-jp.org/vimdoc-ja/pattern.html#:nohlsearch)

> |:nohlsearch| コマンドを使うと、**一時的に**強調表示をやめさせることができます。

**一時的に** というのがミソです。この`:nohlsearch`コマンドは`hlsearch`オプションの変数である、`&hlsearch`を変更しないのです。つまり`set hlsearch`している場合`&hlsearch`変数の値は1ですが、`:nohlsearch`を実行しても`&hlsearch`の値は1のままでハイライトを一時的にオフにします。

#### let v:hlsearch = 1
helpによると1に設定することは

```
let &hlsearch = &hlsearch
```

をすることと同様に働くようです。ここがかなりわかりずらい。

前提として、

1. 基本的に`v:hlsearch`は実際にハイライトを行っているかどうかを決定するのですが`set nohlsearch`が設定されていた場合は`set nohlsearch`が優先されます。
2. コマンド`:nohlsearch`によって一時的にハイライトをオフにした場合、再び検索するなどしたときにハイライトが有効になるのですが、`set hlsearch`,つまりは**`let &hlsearch = 1`**を設定した場合も同様にトリガーとなってハイライトが有効になります(実装は見ていないので予測含む。動作確認はしています)

よって、もし`set nohlsearch`が設定されていれば`&hlsearch`の値は0なので`let &hlsearch = 0`と同様の動作となり何も起こりません。

反対に、`set hlsearch`が設定されていれば`&hlsearch`の値は1で、`let &hlsearch = 1`と同様になり、前提の2からこの動作がトリガーとなって再びハイライトがONになります。

はぁ、ややこしかった。わからなかった方は直接@haya14busaまで質問とかしてください。また間違ってたらご指摘よろしくおねがいします。

ここから`v:hlsearch`から得られたTipsを2つ紹介します

Reloadableなvimrcの設定
-----
一般的には下記のような設定をしている方が多いと思います
```
set hlsearch
nnoremap <silent><Esc><Esc> :<C-u>nohlsearch<CR>
```

が、リローダブルなvimrcを目指している方はこの問題に少なからず気づいているかもしれません。

つまり、`set hlsearch`を記述しているとリロード時に問答無用でハイライトされてしまうのです。(ｳｻﾞｲ

これを改善しましょう

### 1. 簡単かつv:hlsearchがなくてもOK

```
" hlsearchは使うがvimrcを読み込んだ時にハイライトしないようにする
set hlsearch | nohlsearch
```

上記のようにすると`&hlsearch`の値は1で検索のハイライトは有効になっていますが、`:nohlsearch`コマンドによりそれを一時的にOFFにします。

欠点: ハイライトしている状態でリロードするとハイライトが消えてしまう。

### 2. v:hlsearchを使って1の欠点をなくす
```
if exists('v:hlsearch')
  let v_hl_save = v:hlsearch
endif
set hlsearch
execute exists('v:hlsearch') ? 'let v:hlsearch = v_hl_save' : 'nohlsearch'
```

欠点: 書き方が悪いということを除いてもわざわざそこまでしたくない...

スクリプトから扱う
-----
### ハイライトを確認する
`v:hlsearch`が登場する以前では`&hlsearch`の値を見ることしかできず、ハイライトの設定がされているかどうかは分かるけれども、実際にハイライトされているかどうかがわかりませんでした。(`:nohlsearch`で一時的にハイライトしていなくても`set hlsearch`していれば一貫して`&hlsearch`の値は1です)

`v:hlsearch`の登場によって改善されたのはほぼこの一点といってもいいでしょう。

### 実際に関数からハイライトさせる
- [Vim の関数内で set hlsearch しても反映されない場合の対処方法 - C++でゲームプログラミング](http://d.hatena.ne.jp/osyo-manga/20131021/1382346459)

上記の記事の問題は`v:hlsearch`でも同じなようで、関数内で`let v:hlsearch = 1`にしても実行が終わると勝手に元の値に戻されてしまいます。これを回避するには記事にあるように[:h feedkeys()](http://vim-jp.org/vimdoc-ja/eval.html#feedkeys%28%29)を使うしかないようです。残念...

#### ちょっと改善
上記の記事の関数だと`set nohlsearch`のオプションを無視してしまうので下記のように`:let &hlsearch=&hlsearch\<CR>`を使うとよりお行儀よくハイライトさせることができます。

[gist id=8937102]

最後に
-----
最新への追従 #84: [https://github.com/vim-jp/vimdoc-ja/issues/84](https://github.com/vim-jp/vimdoc-ja/issues/84)

Vimの日本語訳がオリジナルのヘルプに追従しきれていないようです。実際`v:hlsearch`を訳して、レビューしてもらったりしましたが、結構新鮮で面白かったしこれからも暇があれば、僕も日本語訳に参加して貢献できればいいなと思います。人手は足りていないようなので、気になった方は簡単な/分かるところからでもいいから訳して、vim-jpに投げてみるといいのではないでしょうか。きっとみんな優しくしてくれると思います。
