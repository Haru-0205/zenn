---
title: 付録B_VSCode上でのTeX
---

# VSCodeでTeXを扱う上で便利な拡張機能

## LaTeX Workshop

TeXについては、定番の拡張機能があります。  
それが、「LaTeX Workshop」です。

https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop

ちなみに、この拡張機能のアドオンもあります。

https://marketplace.visualstudio.com/items?itemName=tecosaur.latex-utilities

拡張機能のアドオン、とは...?

これは、インストールしたらほぼ設定無しで使えます。

...とはいえ、インストールしたままだと保存するたびにコンパイルが回って普通にうざいので、一部settings.jsonをいじります。

```json settings.json
{
  "latex-workshop.latex.autoBuild.run": "never"
}
```

ちなみにですが、これはインストールするだけで補完もちゃんと効きます。

## VSCode-PDF

VSCode上でPDFを表示できる拡張です。

https://marketplace.visualstudio.com/items?itemName=tomoki1207.pdf

まあ、定番ですが。

VSCodeって、拡張機能をインストールしただけで使えるって、結構便利ですよね。

...この章ちょっと短くなりすぎた...?