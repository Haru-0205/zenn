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
        c4(d e f g a b c) <c e g>2 <c es g>2  
    }
```

