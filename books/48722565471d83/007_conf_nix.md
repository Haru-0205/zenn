---
title: Nixの設定
---

# Nixの設定(Flake.nix)

## 今回使用するパッケージ

今回は以下のパッケージを導入した環境を構築する。

- neovim
- git
- lilypond
- Okular
- texliveMedium
以下NeoVimプラグインの依存関係
- ripgrep
- fd
- deno
- mpv
- timidity
- soundfont-fluid
- fluidsynth
- ffmpeg

## flake.nix

```nix
{
    description = "";
    inputs = {
        nixpkgs = { url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };
        flake-utils = { url = "github:numtide/flake-utils" };
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                inherit (nixpkgs.lib) optional;
                pkgs = import nixpkgs { inherit system; };
            in 
            {
                devShell = pkgs.mkshell {
                    buildInputs = [
                        pkgs.neovim
                        pkgs.git
                        pkgs.lilypond
                        pkgs.okular
                        pkgs.texliveMedium
                        pkgs.ripgrep
                        pkgs.fd
                        pkgs.deno
                        pkgs.mpv
                        pkgs.timidity
                        pkgs.soundfont-fluid
                        pkgs.fluidsynth
                        pkgs.ffmpeg
                    ];
                };
            });
}
```
先述の通り、flakeのinputにないものはbuildに影響を及ぼせないので、必要なnixpkgsとflake-utilsをinputに指定  
outputのほうはボクはまだわかってないですが、`buildInputs`の中身が`nix develop`したときに中に入っているパッケージです。

                
