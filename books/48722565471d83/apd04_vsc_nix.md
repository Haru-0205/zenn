---
title: 付録D_VSCodeとNix
---

# configuration.nixによるソフトウェアの設定

configuration.nixは、システム設定のみを提供するわけではなく、ソフトウェアの設定もできます。

まあ、設定できるソフトウェアは限られてきますが。  
(Home-Managerを使えば少し増やせる)

ですが、VSCodeはconfiguration.nixでも拡張機能をある程度設定できます。

# configuration.nixによるVSCodeの設定

https://nixos.wiki/wiki/Visual_Studio_Code

Home-managerを使うと簡単ですが、configuration.nixの場合は少しめんどくさいです。

```nix configuration.nix
environment.systemPackage = with pkgs: [
    (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
            james-yu.latex-workshop
        ];
    })
];
```

例えば、これはlatex-workshopが導入されたVSCode環境をインストールするNix式です。

もちろん、Nixはパッケージマネージャーなので、VSCodeそのものの設定はできません(多分)。  
そのため、細かい設定はsettings.jsonを使うことになります。  
まあ、dotfileリポジトリをきっと作成しているであろう皆さんのことですから問題はないと思います。  
しかし、VSCodeのsettings.jsonにはかけないほぼ唯一の設定項目、拡張機能をNixに任せることで、環境の移行はしやすくなるのではないでしょうか？

:::message alert

ここで紹介した方法では、Nix Storeに存在するものしかインストールできません。  
Nixのリポジトリ検索は[こちら](https://search.nixos.org/packages)から行うことができます。  
また、NixのWikiによると、Nix Storeにない拡張もSHA256とURLを指定するとインストールできるようですが...

:::

# 付録D-2_devcontainer

~~さすがにスペースが余り過ぎて見栄えが悪いので~~  
はじめにやろうとしていたことをすこしだけ紹介します。

VSCodeにはDevContainerという機能があり、これを使うことでDockerによるリモート開発ができます。  
しかも、これのすごいところとして、Dockerfileがそのまま使え、導入する拡張機能を明示的に指定するだけで勝手に導入してくれる上に、VSCodeでワンクリックでDockerのコンテナ内に入れ、なおかつファイルはローカルのものを使い、コンテナから出ても保存したファイルはローカルに残るという、至れり尽くせりなものという点が挙げられます。

https://code.visualstudio.com/docs/devcontainers/containers

これについてはまた後日記事を書きます。
