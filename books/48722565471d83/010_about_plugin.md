---
title: プラグインについて
---

# NeoVimのプラグインについて

## プラグインとは

NeoVimのプラグインは、VSCodeにおける拡張機能のようなもので、機能を追加したり、UIを改善したりできるものです。  
今回はジャンル別で紹介しようと思います。

なお、Vim用のプラグインはNeoVimでも(原則)使えますが、逆は無理なことが多いですのでご注意を。  
「~.nvim」という名称のものや名称に「Lua」が入るものはVimでは使えないことが多いです。

## ジャンル別のおすすめプラグイン

### プラグインマネージャー

#### folke/Lazy.nvim

https://github.com/folke/lazy.nvim

現在私が使っているプラグインマネージャーです。  
とにかくインストール画面がかっこいいです!!
インストール自体は上記のリポジトリのREADMEからコピペでできると思いますが、一応以下にも貼っておきます。

```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)
```

私はこのファイルを`lua/001_lazy.lua`に単体で書きました。  
そして、lazy.nvimの最もすごいところが、`lua/plugins`の中身を勝手に読んでそこに書かれているプラグインを自動インストールしてくれるところです。  
しかも、その中においておくファイルは

```lua
require('lazy').setup({
    -- プラグイン
})
```
も書かなくてよく、単に
```lua
return{
    -- プラグイン
}
```
でOKです。  
こんな感じです。

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/plugins/001_fern.lua

(なぜかTabWidthが4になっていることはお許しを...)

#### Shougo/dpp.vim

https://github.com/Shougo/dpp.vim

いつか使いたいプラグインマネージャー...  
(NeoVimのバージョンが足りない...)  
カスタマイズ性はかなり高いです!  
ただ、初心者向けではないな...

> If you don't want to configure plugins, you don't have to use the plugin manager. it does not work with zero configuration. You can use other plugin managers.

となかなか強気に言ってますね  
まあ、こちらはShougoさん本人による記事があるので貼っておきます。

https://zenn.dev/shougo/articles/dpp-vim-beta

### ファイラ

VSCodeのサイドペインのエクスプローラーみたいなやつをだすプラグイン

#### lambdalisue/Fern.vim

https://github.com/lambdalisue/fern.vim

NERDTree(後述)よりもパフォーマンスがいい(らしい)  
加えて、外部依存がないため、導入が簡単で、プラグインも提供されているので、必要なプラグインを取捨選択して導入できます。

#### preservim/NERDTree

https://github.com/preservim/nerdtree

有名すぎてもはや説明不要だと思います...  
ファイラ系プラグインの定番中の定番です。

このあたりの比較はAlisueさんの記事がわかりやすいので貼っておきます。

https://zenn.dev/lambdalisue/articles/3deb92360546d526381f

なお、私はFern.vimに[lambdalisue/nerdfont.vim](https://github.com/lambdalisue/nerdfont.vim)と[lambdalisue/fern-renderer-nerdfont.vim](https://github.com/lambdalisue/fern-renderer-nerdfont.vim)を導入してファイルアイコン表示ができるようにしています。(厳密にはターミナル側でもnerdfontに対応したフォントの設定が必要です。私は「[Firple](https://negset.com/Firple/)」を使用しました。)

### カラースキーム

#### Catppuccin/nvim

https://github.com/catppuccin/nvim

私が現在使っているカラースキームです。  
ちなみにLatte, Flappe, Macchiato, Mochaから選べますが、私はMacchiatoを使用しています。  

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/plugins/002_ui.lua#L2-L13

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/004_ui.lua

ちなみにリポジトリ名はnvimですが、普通にvimでも使えるようです。

#### dracula/vim

https://github.com/dracula/vim

VSCodeでは人気が高い「Dracula」テーマのVim版です。  
私も気分転換に使おうかな...

なんというか、女の子向けというか、比較的かわいらしい配色のテーマを2つ紹介しました。
カラースキームは調べれば調べるほど出てくるのでここではその他の紹介は割愛します。
なお、ここで紹介した2つは他のサイトではあまり紹介されていないように感じます。

### ファジーファインダー

ファジーファインダーは、JetbrainsのIDEに搭載されている「Search Anywhere」のような機能です。
つまり、ファイル名やファイルの中身から特定の文字列を探して、そこにジャンプするということができるものです。Linux上ではfzfが有名だと思います。  
まあ、イメージとしては`grep`コマンドを使いやすくしたようなものだと思ってください。

#### nvim-telescope/telescope.nvim

https://github.com/nvim-telescope/telescope.nvim

定番中の定番です。  
[nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)と[ripgrep](https://github.com/BurntSushi/ripgrep)に依存しています。  
ただし、ripgrepはWindowsでも使えるので、特段困ることはないと思います。  
私は[nvim-telescope/telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)と[Sharkdp/fd](https://github.com/nvim-telescope/telescope-file-browser.nvim)を追加してファイルブラウザ機能も使用しています。  

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/plugins/002_ui.lua#L24-L36

#### junegunn/fzf.vim

https://github.com/junegunn/fzf.vim

ファジーファインダー系プラグインとしては一番有名だと思います。  
ただし、個人的にはNeoVimだったらtelescopeでよくない?とは思ってしまいます...

他にもファジーファインダー系のプラグインはあるので、yutkatさんによる比較記事を貼っておきます。

https://zenn.dev/yutakatay/articles/vim-fuzzy-finder

### ステータスライン

VimmerのVimを見ると十中八九入ってる上下どちらかor両方にある現在のモードとかファイル名とかを示すあれ(語彙力が...)

#### nvim-lualine/lualine.nvim

https://github.com/nvim-lualine/lualine.nvim

カスタマイズがかんたんなステータスラインです。  
テーマもはじめから色々用意されています。  
ちなみに私は`ayu-mirage`を使用しています。  
また、[nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)を使用するとファイル種別とかも表示できます。

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/plugins/002_ui.lua#L14-L23

#### vim-airline/vim-airline

https://github.com/vim-airline/vim-airline

有名なステータスラインのプラグインです。  
検索したときに出てくる日本語情報量はlualineの比ではありません。  
あと、感覚的にはこっちを使ってる人のほうが圧倒的に多い気がします...
情報量は多いので、こっちを使うのもありだと思いますが、私は設定がわかりやすいLualineを使用しています。

### Denops

プラグインを見てると、依存関係でdenopsというのが挙げられていることがよくあります。  
DenopsはNode.jsの後継としてNode.jsの開発者自身によって作成されたjavascript/Typescriptランタイムである「deno」をvimプラグイン開発に使用するためのプラグインです。  

これを使用するためには[vim-denops/denops.vim](https://github.com/vim-denops/denops.vim)をどうにかしてインストールしたうえで(dpp.vimを使わない限り基本的にプラグインマネージャーからインストールできます)、ローカル環境に[deno](https://deno.com/)をインストールする必要があります。

### LilyPond

NeoVim上でLilyPondファイルを編集する場合、[martineausimon/nvim-lilypond-suite](https://github.com/martineausimon/nvim-lilypond-suite)を導入しておくと、シンタックスハイライトなどが使えます。  

https://github.com/Haru-0205/zenn-nvim-dotfiles/blob/master/lua/plugins/007_lilypond.lua

### LaTeX



