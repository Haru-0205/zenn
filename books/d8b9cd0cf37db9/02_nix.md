---
title: "Nixについて"
---

# Nix Package Manager

Nixは、純粋関数型言語であるNix言語を用いてパッケージ管理を行うパッケージマネージャーです。このVim駅伝を主催している「Vim-jp」というコミュニティで現在すごく流行っているものでもあります。~~なんでNix日本語コミュニティよりもVim-jpの#tech-nixのほうが活発なんだよ...~~

## 純粋関数型言語

プログラミングにおいて、関数は通常、`function`(JSやTS、など)や`func`(Goなど)、`fn`(Rustなど)や`def`(Pythonなど)などで宣言するひとまとまりの処理のことを指します。C言語とかだと戻り値の型などで宣言します。

```typescript:typescript.ts
function  check_age(age: number): boolean {
    if (age < 18) {
        return false;
    } else {
        return true;
    }
}
```

```go:go.go
func check_age(age int) bool {
    if (age < 18) {
        return false;
    } else {
        return true;
    }
}
```

```rust:rust.rs
fn check_age(age: i8) -> bool {
    if (age < 18) {
        return false;
    } else {
        return true;
    }
}
```

```python:python.py
def check_age(age):
    if age < 18 :
        return 0
    else:
        return 1
```

```cpp:c/cpp.cpp
bool check_age(int age) {
    if (age < 18) {
        return false;
    } else {
        return true;
    }
}
```
    
一方で、「関数」というともうひとつ、数学の関数があります。`y=2x+3`とかですね。このような関数を先述の関数と区別して、「純粋関数」といいます。純粋関数の特徴として、「入力が同じであれば出力も同じ」ということがあります。言い方をかえれば、「入力以外の要素は出力に影響を及ぼすことができない」ということです。以下に例を示します。

```haskell:haskell.hs
fact 0 = 1
fact n = n * fact ( n - 1)
```

これは、haskellという言語で記述した、`y=x!`の関数です。

:::details x!とは

x!は「階乗」といい、1からxまでの自然数(正の整数)をすべてかける、という意味です。
ただし、0!=1となります。

:::

なお、HaskellはNixと同じ、純粋関数型言語です。このような純粋関数の組みあわせで処理を記述する言語を純粋関数型言語といいます。

# Nixにおける純粋(pure)

Nixにおいて、「純粋」(pure)というのは、純粋関数ではなく、再現性が担保された状態をいいます。
Nixはパッケージマネージャーなので、一見同じにみえる入力でも、バージョンなどが異なることで再現性が担保されない可能性もあるものを扱います。そのため、Nixにおいては、ハッシュを用いて再現性を担保します。例えば、ビルトイン関数に`fetchGit`というものがあります。機能は名称の通りです。ここでは、例として、Neovimのgithubにfetchしてみましょう。

```nix:sample.nix
input = builtins.fetchGit {
    url = "https://github.com/neovim/neovim";
    rev = "9b5ee7df4e45ff8abbab349468b45ad39f700c0d";
};
```

このように、GitのURLだけでなく、コミットハッシュを指定することで全く同じsourceをfetchすることができるので、Nixではこのような指定を行います。
また、Gitでないところからfetchしたければ、以下のようにします。

```nix:sample.nix
input = builtins.fetchTarball {
    url = "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz";
    sha256 = "0p1ycb6a72g50xhxmd16x45fyjkigimb0bbfawakdnm0l8arj65y";
};
```
こちらの場合は、sha256hashが一致しなければビルド失敗とすることで再現性を担保しています。
このように、Nixにおける「純粋」(pure)というのは、「inputsが同じときに、必ず同じビルド結果になることが保証される」状態となります。
ちなみにですが、Nixの`--impure`オプションを用いれば、ハッシュを省略できますが、再現性が担保されなくなります。~~個人的には`--impure`使うとNix使う意味がなくなると思っているので、可能な限り使用しないようにしています。~~

# NixOS

そんなNixパッケージマネージャーを用いたディストロに、NixOSというのがあります。筆者の環境が~~不慮の事故により~~これです。はっきりいいますが、Nixをいかなる場合においても使い、日本に限らず諸外国の言語の情報をよみあさって試行錯誤する覚悟がない限りおすすめしません。~~(1敗)~~

# Flake

Flakeというしくみを使って開発者間で共有できる開発環境を作成することができます。これについては別で記事を書きます。
今回はこのFlakeを用いて開発環境を作っていきます。~~正直このレベルなら`nix-shell`でいい~~

