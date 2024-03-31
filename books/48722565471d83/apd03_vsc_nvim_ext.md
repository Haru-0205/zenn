---
title: 付録C_VSCode上のVim/NeoVim
---

# VSCodeのVim/NeoVim拡張機能

VSCodeにはVim/NeoVimの拡張機能が存在します。

それぞれ、

https://marketplace.visualstudio.com/items?itemName=vscodevim.vim

https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim

です。

両者の違いですが、VimかNeoVimかの違いは当然として、Vimのほうはどうやらエミュレートしているようですが、NeoVimは実際にNeoVimを動かしているようです。  
なので、NeoVimの拡張を使うためにはNeoVim本体もインストールしておく必要があります。  

これって一見デメリットに見えますが、見方を変えると、キーマップ設定とかをそのままVSCodeにもってこれる、ということです。  
これってすごくないですか?

まあ、VSCodeのキーマップと衝突することももちろんありますが...  
かくいう私は、NeoVimのほうをたまに利用しています。  
そして、これのすごいところとして、/による検索はご丁寧にポップアップを表示してそこに入力する形になります。  
...別に下の方に少し出しといてくれればそれでいいのに...

# VSCodeのマルチプロファイル機能

先ほどちらっと言いましたが、

> かくいう私は、NeoVimのほうを**たまに**利用しています

と書きましたが、これはVSCodeのマルチプロファイル機能を利用して、この拡張機能が入っているプロファイルと書いていないプロファイルで切り替えられるようにしている、ということです。

このマルチプロファイル機能、じみにすごいんですよ！

使い方は簡単で、左下の設定アイコンをクリック→profiles→create profileでプロファイルを作れば、あとはprofileのところに表示されるので選ぶだけです。
しかも、このプロファイル機能、コピー元として任意のプロファイルを指定でき、「settings」「keyboard Shortcuts」「User Snippets」「User tasks」「Extensions」のそれぞれについてプロファイルで設定するかしないか選べます！  
しかも名前が設定できることは当然として、アイコンまで設定できる上、テンプレートまで用意されているという至れり尽くせりな仕様、さすがMicrosoftだな、と思いました！

# VSCodeのWorkspace settings

これは有名な話ですが、Workspaceごとにsettingsを変えることができるんですよね、VSCodeって。  
これをNeoVimでやろうとすると、init.luaを複数用意して、direnvでNVIM_APPNAMEを変更して...となると思います...  
しかも、これはWorkspace設定で定義されていないところはUser設定が適用されるという仕様になっています。  
便利といえば便利ですが、複数人で開発するための機能なはずなんですけどね...`editor.tabWidth`とか定義し忘れたら...考えたくもないですね...  
さらにこれが起こったとしてVSCodeにindent-rainbowなんて導入してたらさらに悲惨なことに...  
...という事にならないように気をつけないといけないですが、裏を返せば、`editor.formatOnSave: true``editor.defaultFormatter: Prettier`としてあげれば保存時に強制的にPrettierを走らせることも可能です。

# VSCodeのRecommended Extensions

これはあまり言われてない気はしますが、拡張機能を右クリックして「Add to Workspace Recommendation」とすると、「extensions.json」というファイルが.vscodeディレクトリに生成されて、これを設定したリポジトリでは、VSCodeではじめに開いた時に「Workspaceの推奨事項」として拡張機能の一括インストールができる、という機能があります。
先ほど例に挙げたPrettierも、extensions.jsonに書いておけばワンクリックでインストールできるようになります。  
もちろん、jsonファイルの配列として書くので、複数の拡張機能を推奨事項に追加できます。  
ちなみに推奨拡張機能は拡張機能のペインで`@Recommended`と打つと一覧表示できます。  
さらに、非推奨の拡張機能も列挙できるという至れり尽くせりな仕様になっています。

詳しくは後日記事にします。