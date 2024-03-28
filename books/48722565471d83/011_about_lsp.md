---
title: LSPと自動補完
---

# NeoVimにおける自動補完

NeoVimでVSCodeのような自動補完をするには、「LSP」などの補完ソースと補完プラグインが必要です。  

# LSP

## LSPとは

vim-jpさんの記事を参照してください。

https://zenn.dev/vim_jp/articles/40b2c348386f88

## Built-in LSP

NeoVimには、Built-in LSPというものがあり、これも普通に使えます。Coc.nvim(後述)に頼らずにbuilt-in LSPで完結させるのが昨今のトレンドのようです。  
私もBuilt-in LSPを利用しています。  

### Built-in LSPを便利にするプラグイン

#### williamboman/mason.nvim

https://github.com/williamboman/mason.nvim

LSPの管理を楽にしてくれるプラグインです。  
`:Mason`で管理画面を呼び出して、そこで新規インストールや更新、アンインストールなどができます。

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/plugins/005_lsp.lua#L5-L8

#### neovim/nvim-lspconfig

https://github.com/neovim/nvim-lspconfig

Built-in LSPの標準設定集のようなものです。  
これを使用することで、この標準設定から変更したいところだけ変更する、というやり方ができるようになります。  
私は、自分がどのように使うか読めなかったので、とりあえず標準設定からなにも変更していません。  

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/plugins/005_lsp.lua#L2-L4

#### williamboman/mason-lspconfig.nvim

https://github.com/williamboman/mason-lspconfig.nvim

Masonとlspconfigを便利につなげるプラグインです。  
williamboman/mason.nvimとneovim/nvim-lspconfigに依存しています(当然)。  
https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/plugins/005_lsp.lua#L9-L11

#### LSPの設定

上記3つのプラグインを導入している場合、以下のように書けば設定できます。

```lua
require("mason").setup()
require("mason-lspconfig").setup()
require("lspconfig").lua_ls.setup {} -- Lua Language Server (lua_ls)を設定する場合
```

これに加えてキーマップを設定すれば、とりあえずLSPは使えるようになります。

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/009_lsp.lua

なお、ここでキーマップを割り当てている機能について、詳しくは説明しませんが、`:h lsp`でここに書いていないものを含め詳しく書いてあるので、そちらを参照してください。

## coc.nvim

coc.nvimはneovimをまるごとVSCode化するAll-in-Oneのプラグインです。手っ取り早くIDEのような環境を構築したい人には適しているでしょう。  
ただ、私はこれを使うならおとなしくVSCodeにVimかNeoVimの拡張を入れたほうがいいと思っています。  
というのも、Vimの魅力の一つとして、「ユーザーがソフトウェア側に合わせる」のではなく「ソフトウェア側がオーナー側に合わせる」、すなわちどこまでも「自分好みに」「細かく」制御できることが挙げられると私は思っています。そうなると、coc.nvimのようなAll-in-Oneのプラグインは便利である反面、カスタマイズ性を犠牲にしているように思えます。  
なお、この議論については私よりもShougoさんのほうが説得力があるので、Shougoさんの記事を読んでみてください...

それでもcoc.nvimを使用する場合はyuucuさんの以下の記事を参照してみてください。(coc.nvimの記事はかなり少ないです。)

https://zenn.dev/yuucu/articles/vimrc-rust-yuucu

# 補完

NeoVim上で補完を行うには、補完プラグインを導入すればよいですが、ここでよく名前があがるプラグインが2つあります。

## hrsh7th/nvim-cmp

https://github.com/hrsh7th/nvim-cmp

nvim-cmpは現在体感上最もシェアが高い補完プラグインです。

私は次に紹介するddc.vimを使用しているので、nvim-cmpについてはnazo6さんの記事を貼っておくのでこちらを参考にしてください。  

https://zenn.dev/nazo6/articles/c2f16b07798bab

## Shougo/ddc.vim

https://github.com/Shougo/ddc.vim

Shougoさんによるプラグインです。  

相変わらず
> If you don't want to configure plugins, you don't have to use the plugin. It does not work with zero configuration. You can use other plugins.

って書いてありますね...  
...というのはおいておいて、このプラグインは
- デフォルトキーマップ
- デフォルトソース
- 補完ウィンドウ
を提供しません。  
これらはすべて、ユーザーの好きなものを選ぶ、あるいは作ることができます!  

### source

sourceにも様々なのもがありますが、私は以下を導入しています。

| ソース名 | 補完元 |
| --- | --- |
| Shougo/ddc-source-lsp | Built-in LSP |
| Shougo/ddc-source-file | ファイルパス |
| Shougo/ddc-source-around | 周辺(ファイル内)の単語 |
| Shougo/neco-vim | Vim Script |
| Shougo/ddc-source-cmdline-history | コマンドライン履歴 |

### matcher

matcherにも様々な～  
私はShougo/matcher_head(前方一致)を使用しています。

### sorter

sorterにも～
私はShougo/sorter_rank(一致順位順)を使用しています。

### 補完ウィンドウ

私はShougo/pum.vimを使用しています。  

https://github.com/Shougo/pum.vim

pum.vimもデフォルトキーマップを提供していません。  
なので、キーマップを設定すれば使用できます。

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/010_pum.lua

ちなみにpum.vimはfolke/noice.nvimに依存しています。

### ddc.vimの設定

luaで設定する場合、`vim.fn`で呼び出して設定します。  
あとは設定ファイルを読めばなんとなく意味がわかると思います。

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/007_ddc.lua

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/plugins/004_ddc.lua

各プラグインの拡張をめんどくさいのでdependenciesに書いていますが...

matcherやsorter、source、uiを列挙するときは、`ddc-source-`や`ddc-filter-`や`ddc-ui-`などは書かなくていいです。


