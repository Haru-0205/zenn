---
title: NeoVimの設定
---

# NeoVimの設定方法

## 設定ファイル

NeoVimは、自分で「init.lua」あるいは「init.vim」というファイルを書くことで設定を行います。VSCodeでいうsettings.jsonのようなものです。  
ちなみに両者の違いは記述する言語です。  
「init.lua」はLua言語、「init.vim」はVim Scriptで記述します。
:::message
現在、NeoVim側は「init.lua」を推奨していますが、Vimと設定を共通化させたいときには「init.vim」を使うのが無難でしょう。  
本稿では、「init.lua」を使用します。
:::

## 設定ファイルの場所

設定ファイルの置き場所はOSによって異なります。

| OS | パス |
| --- | --- |
| Mac/Linux | ~/.config/nvim/init.lua(vim) |
| Windows | ~/AppData/Local/nvim/init.lua(vim) |

なお、Windowsの場合、エクスプローラーのアドレス部分に`%LOCALAPPDATA%/nvim`と打つと`~/AppData/Local/nvim`に移動できるので使ってみてください。

:::message alert
WindowsのAppDataフォルダは隠しフォルダです。  
隠しファイルの表示を有効化するか、アドレスバーに直打ちするか、`%LOCALAPPDATA%/nvim`を使ってください。
:::
:::message
Mac/Linuxの.configディレクトリももちろん.から始まっているので隠しディレクトリです。
:::
Windows、隠しファイルは頭に.の規則を守ってくれ...

## `NVIM_APPNAME`環境変数

:::message alert
このセクションでは環境変数の話をします。  
環境変数に苦手意識がある方は無視して結構です。  
このセクションははじめてNeoVimを設定する場合は読まなくても何ら影響はありません。  
どちらかというと、すでに「自分のNeoVim」を構築している玄人向けの内容ですが、そんな方々ならば環境変数なんて敵でもなんでもないと思うので環境変数についての説明は省略します。
:::

NeoVimには、VSCodeのようなマルチプロファイル機能が実装されています。そのプロファイルの切替に使うのが「`NVIM_APPNAME`」環境変数です。  
環境変数の設定については知っているものとして(知らなくても調べれば大量にヒットします。)、この環境変数を変更することで、簡単に設定をまるっと変えられます。  
なお、この環境変数のデフォルト値は`nvim`です。  
この環境変数を変更すると、変更された名称のディレクトリ内の`init.lua(vim)`からNeoVimを構成します。  
なので、すでに「自分のNeoVim」を作ってる人は、その環境を破壊せずに、別のdotfileを使えるわけです。
...と言葉だけで説明してもわかりにくいので、例をあげます。  
OSをLinux、現在のカレントディレクトリを`~/.config/`とします。  
このとき、普通は`./nvim/init.lua(vim)`が読み出されるわけですが、`$NVIM_APPNAME`を`nvim-test`にしたときは`./nvim-test/init.lua(vim)`が読み出されます。  
...といった感じです。

init.luaの書き方は次章から説明します。

