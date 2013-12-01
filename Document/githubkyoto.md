Graphs, Hashes, and Compression, Oh My!
=====
- [@matthewmccull](https://twitter.com/matthewmccull)
- \#GITHUBJP

GitHubは主にRubyで開発されてる。

GitHubではなくGitの話

Git Readmeはあんまり使えない

Architecture
-----

HASH

centralized VSCs use **sequential** revision numbers(SVNは連番)

Git uses a SHA-1 hash
-----
hashからいろいろな情報を引き出せる

読みにくいけどfingerprintとしてめっちゃよい

**40** hex characters (20 bytes)

```
git log
printf "blob 12\000Hello World\n" | shasum
```

### Hashが衝突した!?
repository becams locked!

可能性は世界中の砂粒のうち1つを探すくらい低い

Hashed Content
-----
Git commits without Git

```
$ git init project1
$ cd project1
$ tree .git
```

config
: urlなど

description
: 　web上でホストしている時の説明

index
: storage of staging area

info
: configのいとこ、レポジトリに保存されたくないもの

objects
: storage of the commits and files that we add to the versions control

refs
: brances and tag pointer

```
$ echo "Hello World" > hello.txt
```
ここまでではかわらない
```
$ git add hello.txt
$ tree .git
```
ファイルができた！
ここまでのハッシュ番号は予想できる！
```
$ git ci -m 'First Commit'
```
このハッシュ番号は予想できない!
時間やauthorの情報で変わる。

```
printf "blob 12\000Hello World\n" | shasum
```

普段のcommitはhighlightしか表示してない

first two characters を使ってdirectoryを作る(under objects directory)

16 * 16 = 256


git はhigh level とlow levelのfunctionを提供している

### Low Level Funciton
```
# Write file's hash to stdout
$ git hash-object hello.txt
557db03de997c86a4a028e1ebd3a1ceb225be238
# Write the pipe's hash to stdout
$ echo 'Hello World' | git hash-object --stdin
557db03de997c86a4a028e1ebd3a1ceb225be238
```

- **git help**
- **git help --all**
  - hash-objectもある

```
cat .git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238
```
\> 読めない！<

### Decompress the object
- zlibつかってる

Hash Shortcuts
----

```
# expand the commit ref
> git rev-parse 557d
557db03de997c86a4a028e1ebd3a1ceb225be238
> git rev-parse HEAD
cd3e5944547f10f9c2732bb689878d4d9e1a044a
> git rev-parse master
cd3e5944547f10f9c2732bb689878d4d9e1a044a
```

Storage
-----
Typical SCMs use **delta** storage

- CSV
- Subversion
- darcs
- Mercurial

delta
: 差分

Delta storage gets **slower** as the history of a file gets **longer**

### Gitは別の方法を考えた

**D**irected **A**cyclic **G**raph
: 無閉路有向グラフ

Acyclic
: グラフの中にloopがない

```
cp -r strfolder srcfolder.prev
```

Why?

**hard link** to existing **identical** blobs

**zlib deflates** each blob at commit

**zlib deflates** the entire repo

```
git gc
```
Groovyで 2100MB became 205MB


Relationship
-----
Gitが保存できるのは4種類だけ
- Blob
  - text or binary
- Tree
- Commit
- Tag

BlobとTreeの関係性

Blobの中にDirectoryの情報はない？




