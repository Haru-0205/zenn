---
title: Lua言語の記法 for NeoVim
---

# NeoVimでLuaを使うメリット

NeoVimでは、原則として設定ファイルとしてinit.luaを使うことが推奨されています。  
というのも、LuaはVimScriptよりも簡潔で汎用的だからです。Lua(La)TeXもLuaが使われています。  
ここでは、NeoVimの設定にLuaを使うメリットを挙げます。
- 設定ファイルを目的ごとに分割できる
...Luaの`require`を使用することで、1つの大きな設定ファイルを目的ごとに分割できます。  
この原稿を書くために書いた設定ファイルは実に21個に分かれています(プラグインマネージャーの仕組みによるものを含む、厳密に設定ファイルと言えるファイルは12個)。
- Vim Scriptよりも細かく処理を書ける
...Luaは**汎用の**プログラミング言語なので、Vim Scriptよりもできることが多いです。  
また、コメントアウトも直感に反さず`--`でできます。(Vim Scriptは`''`)

# Luaの書き方 for NeoVim

## `require`
JavaScript/TypeScriptの`import`のようなもの。  
`require("<ファイル名>")`でファイルをインポートしてその中身をファイルに書かれているように振る舞う。  
なお、このとき、ファイル名には拡張子をつけない。
ファイルを複数に分割する場合、`init.lua`には通常`require`しか記述しない。  
また、`require`で呼び出すファイルは`lua`ディレクトリに配置する。

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/init.lua#L2-L12

これらは以下のように配置されている。

```
nvim
|- lua
|  |- 001_lazy.lua
|  |- 002_plugins.lua
|  |- 003_general.lua
|  |- 004_ui.lua
|  |- 005_telescope.lua
|  |- 006_keymap.lua
|  |- 007_ddc.lua
|  |- 008_telescope.lua
|  |- 009_lsp.lua
|  |- 010_pum.lua
|  |- 011_skk.lua
|- init.lua
```

## `local`
ローカル変数の定義。  
それ以上でもそれ以下でもないが、NeoVimのAPIはたいてい名称が長いので、`local`で変数に代入しておくと楽。

## `function`
関数の定義。  
それ以上でもそれ以下でもないが、終わらせ方が若干特殊。

```lua
function()
  -- 関数の内容
end
```
とする。上記のように関数名はなくても問題はない(もちろんあってもよい)。  
どこぞの`if`を`fi`で終わらせる[謎言語](https://zenn.dev/suiudou/articles/01a6aa5707edda)よりはましだが、普段TSやRustを使ってる身からすると若干違和感がある。まあ、Rubyもそうだと考えれば...?  
ちなみに、`return`とかも使える。

## `vim.opt`
neovimのAPIの1種。  
NeoVimのビルドイン機能の設定等を行う。  
Vim Scriptの`set`にあたる。  
一回一回`vim.opt`と打つのもめんどくさいので、`local opt = vim.opt`と書いておくと楽。
設定できる項目は調べれば大量に出てくるので、ここでは割愛する。

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/003_general.lua

相対行番号表示(relativenumberを直訳しただけ)とかいてあるのは設定しておくと現在行は行番号が、上下の行は現在の行から何行離れているか表示される。

## `vim.keymap.set`
NeoVimのAPIの1種。  
名前の通りキーマップの設定をする。  
挙動としてはVim Scriptの`inoremap``nnoremap`と同じである。  
`vim.opt`と同様、いちいち`vim.keymap.set`と打つのもめんどうなので、`local set = vim.keymap.set`としておくと便利。  
また、`set`はVim Scriptでは`vim.opt`と同じ挙動をするので、キーマップはキーマップで別のファイルに分離した方が良い。

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/006_keymap.lua

プラグインに依存しないキーマップ設定だけだとわずか1行で終わってた...?  
この、`vim.g.mapleader`はVimの特殊キーで`Leader`というのがあり、これと他のキーの組み合わせでより多くのキーに機能を割り当てられるというもの。  
デフォルトは`\`だが、絶妙に押しにくい位置にあるため、ほとんどのVimmerはスペースキーを割り当てている(と思う)。  
拡張機能に依存するが、`vim.keymap.set`を使っているのはこのあたりだろうか。

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/010_pum.lua

`vim.keymap.set`は、モード、アサインするキー、アサインする機能を引数に取り、それぞれ以下のように書く。

```lua
vim.keymap.set('<モード>','<キー>','<機能>')
```

ここで、モードのところは以下の対応表にあわせて入力する。

| 入力する文字 | 対応するモード |
| --- | --- |
| n | ノーマルモード(**N**omal) |
| i | 挿入モード(**I**nsert) |
| v | ビジュアルモード(**V**isual) |

そして、アサインするキーは複数の組み合わせが可能で、`Ctrl`と組み合わせるときは`<C-n>`(Ctrl+n)のように、`Shift`と組み合わせるときは`N`(Shift+n)のように、`Leader`と組み合わせるときは`<Leader>n`(Leader+n)のように、普通のキー同士を組み合わせるときは`fg`(f+g)のように入力する。  

また、機能については割当先のキーを単純に指定できる他、`<cmd>`を使用するとコマンドモードで入力するコマンドを割り当てることができる(最後に`<CR>`を忘れがちなので注意)。

また、`vim.keymap.set`は第4引数としてオプションを受け取ることができ、そこで`{remap=true}`とすると、`imap`や`nmap`のように再帰的にキーマップを割り当てることもできる。

さらに、Luaを使うことで、割当機能の条件分岐もできる(やったことない)。
そのときは`function`を使う。

## `vim.fn`
NeoVimのAPIの1種。  
VimScriptで書かれたfunctionを呼び出す時に使う。  
プラグインの設定以外ではあまり使わないと思う。

このあたりを押さえておけば、今回の記事のレベルの設定は書けると思います。

