---
title: LilyPond-Book
---

# LilyPondとLaTeX

先ほど、LaTeXのサンプルファイル上で触れましたが、LaTeXとLilyPondを融合させることができるんです。  
それが「LilyPond-Book」です。  
拡張子が.lytexになるせいで補完とかシンタックスハイライトとかが一切効かなくなってしまいますが、これについては後日解決策を探るか、プラグインを作るか、なんとかします。

:::message
このあとの数十行が、この15ページものページを費やしてやりたかったことのすべてです。
:::

# LilyPond-Bookによる楽譜入りドキュメント作成

## LilyPond-Book(.lytex)記法

lytexファイルは、LaTeXの中にLilyPondが入る、入れ子構造になります。  
具体的には、LaTeX上に`lilypond`環境としてLilyPondの楽譜のコードを入力するだけです。  
たったそれだけで、LaTeX上でLilyPondが使えます！  

試してみましょう。  

nix developでLaTeXとLilyPond両方が使える環境を立ち上げ、その中で`test2.lytex`という名前でファイルを作成、以下のコードをコピー&ペーストしてください。

```lytex
\documentclass{ltjsarticle}
\begin{document}

\title{LilyPond-Bookによる楽譜入りドキュメント作成}
\author{haru}
\date{2024年4月1日}
\maketitle

\tableofcontents

\section{調}
\subsection{調とは}

調は、音楽を形作る重要な要素の1つで、楽曲の雰囲気などを司る。

主に長調と短調に分けられ、それぞれ12種類ずつある。  

\subsection{長調}

長調は比較的明るい印象を抱きやすい。

\begin{lilypond}
\relative {
    {
        \clef treble
        \key c \major

        c'8 d e f g a b c
    }
}
\end{lilypond}

上記の調は最もスタンダードな「ハ長調」(C-dur, C Major)である。この他にも、

\begin {lilypond}
\relative {
    {
        \clef treble
        \key f \major
        
        f'8 g a bes c d e f
    }
}
\end{lilypond}

のような「ヘ長調」(F-dur, F Major)などがあるが、構成音の感覚は変化しない。これは短調についても言える。

\subsection{短調}

長調は1種類×12音=12種類であったが、短調は厳密には3種類あり、厳密に言うと3種類×12音=36種類存在することになる。  

\subsubsection{自然的短音階}

\begin{lilypond}
\relative {
    {
        \clef treble
        \key a \minor

        a'8 b c d e f g a
    }
}
\end{lilypond}

これはイ短調(A-moll, A minor)である。  
ハ長調とスタートとする音こそ異なるものの構成音が同じである。  
これらの調の関係を「平行調」という。  

\subsubsection{和声的短音階}

自然的短音階だと最後の音に上がる時に違和感が生じるが、それを改善した短音階。

\begin{lilypond}
\relative {
    {
        \clef treble
        \key a \minor

        a'8 b c d e f gis a
    }
}
\end{lilypond}

\subsubsection{旋律的短音階}
和声的短音階の中東感を解決した短音階。\\
上行系と下行系が異なる。

\begin{lilypond}
\relative{
    {
        \clef treble
        \key a \minor

        a'8 b c d e fis gis a a g f e d c b a
    }
}
\end{lilypond}

\end{document}
```
[^1]

## LilyPond-Bookのコンパイル

LilyPond-Bookは、
1. `lilypond-book`でコンパイル(→.texが生成される)
2. LaTeXで必要回数コンパイル(→.pdfが生成される)

という2段階のコンパイルをする必要があります。  
また、LaTeXのエンジンとしてLuaLaTeXを使うときはそれをオプションで明示的に指定する必要があります。  

なので、上記のファイルのコンパイルコマンドは
```
lilypond-book --pdf --latex-program=lualatex test2.lytex
lualatex test2.tex
lualatex test2.tex
```
となります。

[^1]: 厳密に言うと短**調**そのものは12種類ですが、短**音階**になると「自然的短音階」「和声的短音階」「旋律的短音階」の3種類に分かれます。これに苦しめられた人も多いのでは...?