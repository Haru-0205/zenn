---
title: LilyPondファイルの作成
---

# LilyPondのフロー

LilyPondは以下のフローで楽譜を作成します。

1. LilyPondファイルを作成する
2. `LilyPond`コマンドでLaTeXのようにビルドする
3. PDFファイルが出力される

# LilyPondを使ってみよう

## LilyPondファイル(\*.ly)の作成

Fernを導入している場合、Fern上で`Shift`+`N`でファイル名を入力するとファイルが作成できます。  
また、`Shift`+`R`でファイル名を変更でき、変更したら`:w`で保存すると自動でファイル名を変更するために開かれたバッファが閉じられます。  
ここではファイル名を`sample.ly`とします。

## 簡単な楽譜のLilyPondコードを記述→コンパイル

以下をコピー&ペーストしてください。  
```lilypond
{
    \time 4/4
    \clef treble
    relative {
        c'4 d e f g a b c
    }
}
```
できたら、`:w`で保存してください。  
その後、(ノーマルモードで)<F5>キーを押すことで勝手にコンパイルしてくれます！
コンパイル後には`sample.pdf`というファイルが生成されるので、これをokularなどで表示します。  
なお、okularはファイルの自動リロード対応です。  
WSL上で動かしている場合は`okular sample.pdf`で見れます。  
また、NeoVim上では`:term`でターミナルを表示することもできますが、少々使い勝手が悪いので、一回一回NeoVimを閉じるか、[akinsho/toggleterm](https://github.com/akinsho/toggleterm.nvim)などの使用も検討してください。  
正常に出力できていればC-durの音階(ハ長調の音階)が出力されているはずです。  

## 少し複雑な譜面の作成

以下をコピー&ペーストしてください。
```lilypond
<<
    \relative c' {
        c4 d e f g a b c <c e g>2 <c es g>2  
    }
    \addlyrics {
        c d e f g a b c C Cm
    }
>>
```

かけたらノーマルモードで<F5>キーを押下→PDFビューワーで見てください。  
和音と歌詞がつけれたと思います。

LilyPond記法について、詳しくは公式ドキュメントを参照してください。  

https://lilypond.org/text-input.ja.html

https://lilypond.org/doc/v2.24/Documentation/learning/index.ja.html

とりあえずこれを読めばしばらくは困ることはないと思います。

そして、「学習」マニュアルに掲載されている内容以外でやりたいことがあればこちらを参照してください。

https://lilypond.org/doc/v2.24/Documentation/notation/index.ja.html

これは記譜法のリファレンスですので、すべて読む必要はないと思います。必要なところだけ読みましょう。

https://lilypond.org/doc/v2.24/Documentation/music-glossary/index#top

さらに、音楽用語に疎い人はこの資料を参照してもよいでしょう。様々な言語(英語・イタリア語・ドイツ語...)で書かれた音楽用語の説明です。  
これこそすべて読むのは不可能なので、必要なところだけ読みましょう。
