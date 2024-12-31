---
title: SATySFiについて
---

# SATySFiとは

SATySFiは、関数型言語が組み込まれている組版ソフトです。
v0.0.1が2018年に公開され、最新はv0.0.11となります。比較的新しい組版ソフトです。
2017年にはIPA未踏事業として支援を受けていたようです。
このSATySFi最大の特徴は国産であることでしょう。TeXのときに苦労した日本語対応はデフォルトで備わっています。
標準拡張子は`*.saty`です。

# 環境構築

この前Archに入れようとして依存関係でエラー吐かれまくって失敗しましたが、Nixにおいては「入力以外の要素はビルドに影響を及ぼすことはできない」ので失敗しません。
...とはいえ、nixpkgsにあるのでそれを導入しましょう。
ということで、`shell.nix`は以下のようになります。

```nix:shell.nix
{ 
	pkgs ? import <nixpkgs> {
		inherit system;
	}, system ? builtins.currentSystem}:
pkgs.mkShell {
	pure = true;
	buildInputs = with pkgs; [
		git
		satysfi
	];
	shellHook = ''
		echo "SATySFi Develop Environment is Activated"
	'';
}
```

# テスト

例によってテストを行います。
まず、以下の`test.saty`を先述の`shell.nix`と同じディレクトリに作成します。

```satysfi:test.saty
@require: stdja

StdJa.document(|
	title = {\SATySFi; Test};
	author = {name};
	show-title = false;
	show-toc = false;
|) '<
	+p {
		This is Test Page. + 
		日本語表示できていますか？
	}
>
```

次に、`nix-shell`を実行します。
次に、`satysfi test.saty`を実行します。
test.pdfが出力されれば成功です。ドキュメントビューワーできちんと出力できているか確認しましょう。

# 参考文献

本チャプターを作成するのにあたり、以下のページを参考にしました。

https://github.com/gfngfn/SATySFi/blob/master/README-ja.md

https://github.com/gfngfn/SATySFi/wiki/The-SATySFi%E2%80%8Bbook-Web%E5%85%AC%E9%96%8B%E7%89%88-%E7%AC%AC1%E7%89%88



