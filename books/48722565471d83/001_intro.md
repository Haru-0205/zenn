---
title: "はじめに"
---

:::message
この記事は、Vim駅伝 4月1日の記事です。
:::
みなさん、こんにちは。  
ついに本日、4月1日をもって2024年度となりました。  
昨年度はどんな年でしたか?  
みなさん、昨年度はVim/NeoVimをどれくらい触ってましたか?  
ちなみに私は高専に入って学友会執行部の活動でVSCodeを触っていましたが、3月からは積極的にNeoVimを使っています。  
そして、みなさん、今年度では、昨年度挑戦していなかったようなことに挑戦したくないですか?  
...と毎年思ってそこまで余裕がない人が大半なわけですが、今回はそんなみなさんに「楽譜作成」を提案しようと思います！  
というのも私は、本年度は「Klef Project」という中高生向けの音楽関係のプロジェクトを発足させるので、その環境構築をしようと思ったわけです。  
音楽に携わる学生の9割は[MuseScore](https://musescore.org)でも導入してそれで満足してMuseScoreで楽譜を書いているとは思いますが、今回は少しばかり事情が違います。  
というのも、そもそもこの記事は[Vim駅伝](https://vim-jp.org/ekiden/)の記事なわけですからVim/NeoVimに関わっていなければ意味もないですし、先述のプロジェクトについてもGitHub Organizationを作った以上、GitHubで管理したいと考えた結果、あるプログラムにたどり着きました。  
それがNeoVim+[LilyPond](https://lilypond.org)というわけですが。  
まあ、それでもよくある流れでは、おそらくNeoVimにCoc.nvimでも導入してVSCodeの拡張でも使うところだと思いますが、今回はCoc.nvimは使いません！  
というのも、VSCodeのどの拡張よりもNeoVim向けのLilyPondプラグインのほうが高機能だからです。  
そして、その依存パッケージがWindowsで使えないものが多いので、~~Docker~~Nixを使おうとしているわけです。  
なお、この記事では、この内容には直接関係のないVSCodeおよびWindowsローカル環境におけるLilyPondについても触れるので、Vimはまだ怖いという人もVSCodeで挑戦してみてください。  
4/1、新年1発目の記事としてふさわしいものとなるように、頑張って執筆します！
それなりなボリュームですが、まあ、必要そうなところだけ読んでください(笑)！

※この記事を書こうとしたときにはDockerを使うつもりでしたが、筆者の環境がWindowsなので、DockerだとWSLを一回挟む分使い物にならない、とまでは言いませんがとても遅かったため、今はやっているNixを使うことにしました。
