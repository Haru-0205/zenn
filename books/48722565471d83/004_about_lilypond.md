---
title: LilyPondについて
---

# LilyPondとは?

[LilyPond](https://lilypond.org)はGPLライセンスで公開されている楽譜作成(浄書)ソフトウェアである。  

## 特徴

### テキストベース

LilyPondはテキストベースで譜面を作成できるため、Gitなどでも管理も容易である。  
また、VimやEmacs、VSCodeなどお気に入りのエディターで使えるし、プログラミングをやったことがある人ならばライブラリやTeXを使う感覚で簡単に扱うことができる。

### 無償・オープンソース

楽譜作成ソフトは有料のものが多いが、これは無償・オープンソースで開発されている。  
そのため、ユーザーは初期投資として投じるのは記法を理解するまでのわずかな時間である。

### CLIベース

楽譜作成ソフトとしては珍しく、GUIを持たない。  
そのため、軽いし、GUIを持たない環境でも利用可能である。
さらに、副次的なメリットとして、細かい部分にこだわらずに済むという点もある。

### 高品質

同じくオープンソースで開発されている「[MuseScore](https://musescore.org)」という楽譜作成ソフトがあるが、それに比べてかなりきれいに楽譜を書ける。

## インストール

### Mac/Linux

各OS・ディストリビューションのパッケージマネージャーから導入できる事が多いため割愛

### Windows

1. [こちら](https://lilypond.org/download.ja.html)からWindows用のバイナリをDL
2. DLしたファイルを展開
3. `lilypond-(バージョン)`フォルダーをユーザーフォルダー直下などわかりやすいところにフォルダーを移動
4. `lilypond-(バーション)/bin`にPATHを通す

:::details WindowsのPathの通し方

1. `Win`+`Q`で検索画面を開く
2. 「環境変数」と入力→「システム環境変数の編集」を開く
3. 表示されるダイアログの「環境変数」を開く
4. **システム環境変数**の「Path」を探して「編集」をクリック
5. 「新規」をクリック
6. パスを通したい場所の絶対パスを入力
7. 表示されているダイアログをOKで閉じる

:::