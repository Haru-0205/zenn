---
title: TeXについて
---

# TeX/LaTeXとは

$\TeX$や$\LaTeX$は、現在最も主流な組版エンジンであり数式エンジンです。
純粋な$\LaTeX$だけでなく、このようなMarkdown上で

$$
e^{i\pi} + 1 = 0 
$$
$$
x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
$$

のようにするのにも使われています。
ちなみに上の式は以下のようなコードになっています。
```latex
$$
e^{i\pi} + 1 = 0 
$$
$$
x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
$$
```

# TeXディストリビューション

TeXには、純粋なTeXだけでなく、様々な派生があります。有名なものでは「pLaTeX」や「LuaLaTeX」などでしょう。これらのTeXを一括導入して管理するパッケージをTeXディストリビューションといいます。主なものには、TexLiveやMikTexなどが挙げられるでしょう。
今回はTeXLiveを使用します。

# 日本語TeX環境

CJK(Chinese/Japanese/Korean)の処理というのはいつも面倒なものです。
もちろんFullスキームで入れた場合は問題ありませんが、それ以外のスキームで入れた場合、日本語対応用のパッケージを追加導入する必要があります。
ちなみに、TeXLive Fullスキームは数GBあるので、そんな大きなパッケージ入れる余裕などないわけです。ましてはNix環境でそんなことをしようものなら......考えたくもないですね。

:::details 分からない人向けの説明

Nixのシステムでは、導入したパッケージはすべて`/nix/store/(hash)-(name)-(version)`というディレクトリに保存され、必要なところにシンボリックリンクを貼ります。
このディレクトリ名を見ればわかるとおり、同じパッケージ、同じバージョンのパッケージがいくつも存在できるというわけです。そして、この重複するパッケージや古いバージョンのパッケージは実質的には不要ですが、自動では削除されないのです。
これを削除するには、ユーザー側が`nix store gc`などを実行する必要があります。
もし、これがパッケージ1つあたり数GBあるパッケージだとすると......

:::

結論からいうと、任意のスキームの上に以下のパッケージを導入すればよいです。

- LuaTeXja
- Haranoaji Font

ということで、以下のshell.nixファイルを使用します。

```nix:shell.nix
{ pkgs ? import <nixpkgs> {
	inherit system;
    }, system ? builtins.currentSystem}:
let
    texlive-custom = pkgs.texlive.combine{
        inherit (pkgs.texlive) scheme-small luatexja haranoaji;
    };
in
pkgs.mkShell {
    pure = true;
    buildInputs = with pkgs; [
        git
        texlive-custom
    ];
    shellHook = ''
        echo "TeX Develop Environment is Activated"
    '';
}
```

今回は、smallスキームをベースにしました。

# テスト

ちゃんと日本語のファイルが作成できるかテストします。

まず、以下のファイルを先述したshell.nixと同じディレクトリに作成します。

```latex:test.tex
\documentclass{ltjsarticle}
\begin{document}
This is Test File \\
日本語表示できてますか？
\end{document}
```

次に、`nix-shell`を引数・オプションなしで実行します。
次に、`lualatex test.tex`を実行します。
そのディレクトリの配下に`test.pdf`が生成されるはずです。
最後に、その`test.pdf`を適当なpdfビューワーで開いて確認してください。日本語もちゃんと表示されていれば成功です。

# 参考文献

このページの記述にあたり、以下のページを参考にしました。

https://ryantm.github.io/nixpkgs/languages-frameworks/texlive/
