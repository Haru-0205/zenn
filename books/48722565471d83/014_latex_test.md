---
title: LaTeX 超・入門編
---

:::message alert
LaTeXを**少しでも触ったことがある人**はこの章は無視してください。  
読むだけ時間の無駄です。
:::

# LaTeXのフロー

1. .texファイルを書く
2. コマンドでコンパイル
3. PDFが出力される

LilyPondと何ら変わりありません

# 実際に文書を作ってみよう

TeXが使える環境(Nix developなど)で、test.texを作成し、下記のコードをコピー&ペーストしてください。  

```tex
\documentclass{ltjsarticle}

\begin{document}

\title{LilyPondとLaTeX}
\author{haru}
\date{2024年4月1日}
\maketitle

\tableofcontents
\clearpage

\section{LilyPond}

LilyPondは、テキストベースの楽譜作成・浄書ソフトウェアである。\\
テキストベースであるため、gitで管理しやすく、LaTeXと同じ感覚で記述できる。\\
また、出力される楽譜は有償のものに引けを取らないほど高品位である。

\section{LaTeX}

LaTeX(\LaTeX2e)は、主に理工学系のレポートや論文で使われている組版ソフトである。\\
この文書のように、それほど考えずに書いたとしても、体裁が整ったファイルを出力してくれる。\\
また、このように数式もきれいに表示できる。

$$
x = \frac{ -b \pm \sqrt { b^2 - 4ac }{ 2a }
$$

なお、この数式機能のみを抽出した「KaTeX」というものもあり、これはよくMarkdownでも使われている。

\section{LilyPond-Book}

そして、先述した2つのソフトウェアは連携させることができる。\\
その機能が「LilyPond-Book」である。\\
これを使うと、LaTeX文書内に直接LilyPondによる楽譜を書くことができる。\\
拡張子が.lytexになる点だけ注意したい。\\
これを使うことで、音楽の理論書とも引けを取らないような、高品位な楽譜入りドキュメントをお気に入りのテキストエディターで作成することができる。

\end{document}
```

貼り付けたら保存して、コマンドラインで`lualatex test.tex`を**2回**実行してください。  
`\tableofcontents`は表紙を作るコマンドで、このようなものを入れるときはlatexを2回実行する必要があります。逆に入れなければ1回で問題ないです。  

それぞれのコマンドの意味は、推測できると思いますが、また調べてみてください。

