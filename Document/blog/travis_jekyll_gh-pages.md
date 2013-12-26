Travis CIでJekyll on GitHub Pages(gh-pages branch)のテストをするときにハマった
=====


なんどpushしてもTravisが動いてくれなくて非常につらかった
-----

何度も設定見なおして、何度も更新して、何度も何度もpushしました。

しかし何も起こらなかった。。。

解決
-----

ふと、masterじゃないとダメなのかなとmasterにプッシュしたら動いたので、さらにドキュメントを調べてみると...

> Note that the gh-pages branch will not be built unless you add it to the whitelist (branches.only).

> -- <cite>[Travis CI: Configuring your build](http://about.travis-ci.org/docs/user/build-configuration/)</cite>


書いてあった！！！

`gh-pages`ブランチはデフォルトではテストしてくれなくて、whitelistで明示的に指定しないとダメなようです。


.travis.yml

```
language: ruby
rvm:
  - 2.0.0
before_script: "bundle show"
script: "bundle exec jekyll build"
after_script: "find _site -type f"
branches:
  only:
    - gh-pages
```

よく考えたら、gh-pagesってプロジェクトと全く別の物が置かれているわけだから、デフォルトで無視してくれるっていうのは気が効いてていいかもしれないですね。
`gh-pages`のテストとか別にローカルで書くときにビルドしてればわかるのでそもそもあんまりテストする必要性がないのかもしれないというのはある。


ちなみに上記のようにwhitelistでgh-pages onlyの設定にしていてもPull Requestにはちゃんと反応してくれるっぽいです。Travisさんさすがです。

