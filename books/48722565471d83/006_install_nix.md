---
title: Nixのインストール
---

# Nixのインストール

## Linux/WSL
以下のコマンドを実行(Fishでは**実行不可**)

```bash
sudo sh <(curl -L https://nixos.org/nix/install) --daemon
```
(または)

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

## MacOS
以下のコマンドを実行

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

## Windows

### WSLにNixOSを導入

1. [こちら](https://github.com/nix-community/NixOS-WSL/releases/)から最新のバイナリをDL
2. 以下のコマンドを実行
```
wsl --import NixOS $env:USERPROFILE\NixOS\ nixos-wsl.tar.gz
```
3. NixOS立ち上げ
```
wsl -d NixOS
```
4. NixOS上で以下を実行
```
sudo nix-channel --add https://nixos.org/channels/nixos-23.11 nixos
sudo nix-channel --update
sudo nixos-rebuild switch
```

# Flakesの有効化

## NixOS(NixOS-WSLを含む)

`/etc/nixos/configuration.nix`に以下を追記

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

## NixOS以外

`/etc/nix/nix.conf`または`~/.config/nix/nix.conf`に以下を追記

```conf
experimental-features = nix-command flakes
```

