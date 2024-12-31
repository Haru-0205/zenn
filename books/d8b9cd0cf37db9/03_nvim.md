---
title: "Neovimについて"
---

# Neovimの特徴

さて、みなさんご存知のNeovimです。もはや説明不要かと思いますが、一応説明します。
Neovimは、Vimの派生エディタで、そのVimもまた、viというエディタの派生エディタです。
設定ファイルは`VimScript`か`Lua`で書くことができ、Neovimにおいては`Lua`が推奨されています。
エディタとしての機能としてはシンプルかつ強力といった印象がありますが、かなり独特の操作性なので、慣れるまでは苦戦しますが、慣れてしまえばかなり効率良く編集をすることができます。

# プラグイン

Neovimには、非常に多くのプラグインが存在します。これは、もちろんNeovim専用に開発されたもの(telescope.nvimなど)もありますが、基本的にVimプラグインを流用することもできます。例えば、私が使用しているファイラプラグインはAlisueさんの「vim-fern」ですが、これはVimプラグインです。設定例等はVimScriptで書かれているので、必要に応じてLuaに読み換える必要もありますが、比較的簡単に読み換えることができます。

# Nixによるプラグイン管理

また、[Nixpkgs](https://search.nixos.org/packages?channel=unstable&from=0&size=50&buckets=%7B%22package_attr_set%22%3A%5B%22vimPlugins%22%5D%2C%22package_license_set%22%3A%5B%5D%2C%22package_maintainers_set%22%3A%5B%5D%2C%22package_platforms%22%3A%5B%5D%7D&sort=relevance&type=packages&query=vimplugins)には様々なVimプラグインがあります。これらを以下のように設定することでプラグインが導入された状態のVimを立ちあげることができます。
```nix:configuration.nix
programs.neovim = {
    enable = true;
    configure = {
        packages.myVimPackage = with pkgs.vimPlugins; {
            start = [ nvim-treesitter ];
        };
    };
};
```
Home Managerを用いると以下のようになります。
```nix:home.nix
programs.neovim = {
    enable = true;
    plugin = with pkgs.vimPlugin; [
        nvim-treesitter
    ];
}
```
この書き方をした場合は起動時に読みこまれます。
しかし、遅延読み込みしたいですよね......?
そういう場合には以下のように書きます。
```diff nix:configuration.nix
programs.neovim = {
    enable = true;
    configure = {
        packages.myVimPackage = with pkgs.vimPlugins; {
            start = [ nvim-treesitter ];
+           opt = [ vim-fern ];
        };
    };
};
```
```diff nix:home.nix
programs.neovim = {
    enable = true;
    plugin = with pkgs.vimPlugin; [
        nvim-treesitter
+       { plugin = vim-fern; optional = true; }
    ];
}
```

また、これはVim標準のパッケージマネージャーを用いているので、読み込みたいタイミングで`:packadd`を実行してあげるような`autocmd`を組めばそれでOKです。

例えば、この`vim-fern`をNeovimの起動処理がすべて終わったあと(VimEnter)で読みこみたいとすると、このようなautocmdを組めばいいでしょう。

```lua:init.lua
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.cmd.packadd("vim-fern")
        vim.keymap.set("n","<C-a>","<cmd>:Fern . -drawer -toggle<CR>")
        vim.keymap.set("i","<C-a>","<cmd>:Fern . -drawer -toggle<CR>")
    end
}
```
```vim:init.vim
au VimEnter * {
    packadd vim-fern
    nnoremap <C-a> <Cmd>:Fern . -drawer -toggle<CR>
    inoremap <C-a> <Cmd>:Fern . -drawer -toggle<CR>
}
```

ここでは、私が使っているkeymapも一緒に定義しているので、ノーマルモードとインサートモードにおいて、Ctrl+AでFernを開くようになっています。~~Ctrl+Aっていうのは結構珍しい気が...?~~
ちなみに本来<C-a>に割りあてられている機能は<C-A>に割りあてています。(まあ私はあまり使わないですけどね)

ちなみに、nixpkgsにないパッケージもインストールできます。例えば、vim-fernをnerdfontに対応させてファイルマークで表示できるようにするプラグインである「vim-fern-renderer-nerdont」とその依存パッケージである「vim-nerdfont」を導入するときは以下のようにします。


```diff nix:configuration.nix
{ config, pkgs, ...}:
+let
+   fern-renderer-nerdfont = pkgs.vimUtils.buildVimPlugin {
+       name = "vim-fern-renderer-nerdfont";
+       src = builtins.fetchGit {
+           url = "https://github.com/lambdalisue/vim-fern-renderer-nerdfont";
+           rev = "325629c68eb543229715b68920fbcb92b206beb6";
+       };
+   };
+   vim-nerdfont = pkgs.vimUtils.buildVimPlugin {
+       name = "vim-nerdfont";
+       src = builtins.fetchGit {
+           url = "https://github.com/lambdalisue/vim-nerdfont";
+           rev = "e054fd135ee73db37cd5bf545e0ff9948ffec7bc";
+       };
+   };
+in
{
    programs.neovim = {
        enable = true;
        configure = {
            packages.myVimPackage = with pkgs.vimPlugins; {
                start = [ nvim-treesitter ];
                opt = [ 
                    vim-fern
+                   fern-renderer-nerdfont
+                   vim-nerdfont
                ];
            };
        };
    };
}
```
```diff nix:home.nix
{ config, pkgs, ...}:
+let
+   fern-renderer-nerdfont = pkgs.vimUtils.buildVimPlugin {
+       name = "vim-fern-renderer-nerdfont";
+       src = builtins.fetchGit {
+           url = "https://github.com/lambdalisue/vim-fern-renderer-nerdfont";
+           rev = "325629c68eb543229715b68920fbcb92b206beb6";
+       };
+   };
+   vim-nerdfont = pkgs.vimUtils.buildVimPlugin {
+       name = "vim-nerdfont";
+       src = builtins.fetchGit {
+           url = "https://github.com/lambdalisue/vim-nerdfont";
+           rev = "e054fd135ee73db37cd5bf545e0ff9948ffec7bc";
+       };
+   };
+in
{
    programs.neovim = {
        enable = true;
        plugin = with pkgs.vimPlugin; [
            nvim-treesitter
            { plugin = vim-fern; optional = true; }
+           { plugin = fern-renderer-nerdfont; optional = true; }
+           { plugin = vim-nerdfont; optional = true; }
        ];
    }
}
```
autocmdは以下のようになります。

```diff lua:init.lua
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.cmd.packadd("vim-fern")
+       vim.cmd.packadd("vimplugin-vim-nerdfont")
+       vim.cmd.packadd("vimplugin-vim-fern-renderer-nerdfont")
        vim.keymap.set("n","<C-a>","<cmd>:Fern . -drawer -toggle<CR>")
        vim.keymap.set("i","<C-a>","<cmd>:Fern . -drawer -toggle<CR>")
+       vim.g["fern#renderer"] = "nerdfont"
    end
}
```
```diff vim:init.vim
au VimEnter * {
    packadd vim-fern
+   packadd vimplugin-vim-nerdfont
+   packadd vimplugin-vim-fern-renderer-nerdfont
    nnoremap <C-a> <Cmd>:Fern . -drawer -toggle<CR>
    inoremap <C-a> <Cmd>:Fern . -drawer -toggle<CR>
+   let g:fern#renderer = nerdfont
}
```
`vim-plugin`というprefixがつくことに注意してください。

# 参考文献

このページの記述にあたり、以下のページを参考にしました。

https://nixos.wiki/wiki/Neovim

https://github.com/nix-community/home-manager/blob/master/modules/programs/neovim.nix

https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md
