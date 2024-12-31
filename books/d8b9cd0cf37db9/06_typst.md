---
title: Typstについて
---

# Typstとは

Typstは、Rust製のとても新しい組版システムです。
version 0.1.0のリリースが2023年4月、最新リリースはversion 0.12.0です。
その特徴はなんといってもその速度でしょう。TeXやSATySFiの比ではないほどに早いです。簡単な文書だとms単位でビルドが終わります。
また、typstには`typst watch`というコマンドが用意されています。これは、対象ファイルの変更を検知して、直ちに差分をコンパイルするものです。これを利用することで、差分のコンパイルに至ってはus単位の更新が実現されています。

# 環境構築

Typstは、`cargo install`で入れるのが一番早いでしょう。
しかし、nix環境下ではうまく動かないので、大人しく`shell.nix`を作成します。

typstもnixpkgsにあるので、これを導入すればよいです。
よって、`shell.nix`はこのようになります。

```nix
{ 
	pkgs ? import <nixpkgs> {
		inherit system;
	}, system ? builtins.currentSystem}:
pkgs.mkShell {
	pure = true;
	buildInputs = with pkgs; [
		git
		typst
	];
	shellHook = ''
		echo "Typst Develop Environment is Activated"
	'';
}
```

# テスト

例によってテストをします。

例によって以下のファイルを`shell.nix`と同じところにおきます。

```typst:test.typ
This is Test Page. \
日本語表示はできていますか？
```

例によって`nix-shell`を実行します。
次に、`typst compile test.typ`を実行します。
pdfファイルが出力されたら成功です。例によって開いて確認しましょう。

# 参考文献

このチャプターの作成にあたり、以下のページを参考にしました。

https://typst.app/
