# Typst 文書テンプレート

このリポジトリは、Typstを手軽に始めるための文書テンプレートです。学術論文、レポート、文書作成に最適な `template_doc.typ` を中心に構成されています。

## セットアップ

### 1. 初期設定（重要）

このテンプレートを使用する前に、プロジェクト名に合わせてファイル名を変更してください：

#### 変更が必要なファイル：

```bash
# .devcontainer/docker-compose.yml
container_name: typst-template-dev  # → あなたのプロジェクト名-dev

# .devcontainer/devcontainer.json  
"name": "typst-template"  # → "あなたのプロジェクト名"
```

#### パッケージ名の変更：

```bash
# package.json
"name": "typst-template"  # → "あなたのプロジェクト名"
```

### 2. 必要な環境

以下のいずれかの方法で環境を構築できます：

#### 方法A: Dev Container（推奨）
- [Docker](https://www.docker.com/)
- [VS Code](https://code.visualstudio.com/) + [Dev Containers拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

#### 方法B: ローカル環境
- [Typst](https://typst.app/) 
- Node.js（オプション：依存関係管理用）

### 3. Dev Container での環境構築（推奨）

1. このリポジトリをクローンします
```bash
git clone <repository-url>
cd typst-template
```

2. **重要**: 上記の初期設定でファイル名を変更してください

3. VS Codeでフォルダを開き、Dev Containerで開く
   - コマンドパレット（Ctrl+Shift+P）→ "Dev Containers: Reopen in Container"
   - または右下の通知から「Reopen in Container」をクリック

4. 初回起動時に自動でセットアップが実行されます
   - Typst、日本語フォント、Node.js依存関係が自動インストール
   - VS Code拡張機能も自動でインストール

### 4. ローカル環境での構築

1. [Typst](https://typst.app/)をインストール
2. 日本語フォントをインストール（Harano Aji フォントなど）
3. このリポジトリをクローン
4. ファイル名を変更（上記の初期設定を参照）

## メインテンプレート：`template_doc.typ`

`template_doc.typ` は最も使いやすく実用的なテンプレートです。以下の特徴があります：

- **表紙付き文書**: タイトル、著者名、日付を美しく配置した表紙
- **自動目次生成**: 目次、図目次、表目次を自動生成
- **定理環境**: 定理、定義、証明などの数学的環境をサポート
- **図表管理**: 章ごとの図表番号付けと相互参照
- **日英対応**: 日本語・英語の両方に対応
- **要約とキーワード**: 学術文書に必要な要約とキーワード欄

## 使い方

### 1. 基本的な使用方法

環境構築が完了したら、以下の手順で文書を作成できます：

```bash
# 文書をコンパイル
typst compile main.typ

# ファイル変更を監視して自動コンパイル（推奨）
typst watch main.typ

# PDFを出力
typst compile main.typ output.pdf
```

### 2. main.typの設定

`main.typ`ファイルを以下のように編集してください：

```typst
#import "template/template_doc.typ": *

#show: project.with(
  title: [あなたの文書タイトル],
  title-header: "短いタイトル",
  datetime: "2024年12月",
  authors: (
    (
      name-ja: "著者名",
      presenting: false,  // 発表者の場合はtrue
    ),
  ),
  abstract: [
    ここに要約を記述します。研究の目的、手法、結果、結論を簡潔に述べてください。
  ],
  keywords: "キーワード1, キーワード2, キーワード3",
  lang: "jp",  // 日本語の場合は"jp"、英語の場合は"en"
  font-size: 12pt,
  body-font: ("Harano Aji Mincho", "Noto Serif", "FreeSerif"),
  sans-font: ("Harano Aji Gothic", "Noto Sans", "FreeSans"),
  math-font: ("STIX Math", "Latin Modern Math", "TeX Gyre Termes Math"),
  leading: 1.2em,
  margin: (left:1in, top:1in, right:1in, bottom:1in),
)

// ここに本文を記述
= はじめに
本文をここに記述します。

= 方法
実験や調査の方法について記述します。

= 結果
結果について記述します。

= 考察
結果の考察を記述します。

= 結論
結論を記述します。

// 参考文献
#bibliography(
  "bibliography.bib",
  title: [参考文献],
  style: "ieee",
)
```

### 3. カスタマイズ可能なパラメータ

- `title`: 文書のメインタイトル
- `title-header`: ページヘッダーに表示される短いタイトル
- `datetime`: 文書の作成日時
- `authors`: 著者情報（複数可能）
- `abstract`: 要約文
- `keywords`: キーワード（カンマ区切り）
- `lang`: 言語設定（"jp" または "en"）
- `font-size`: 本文のフォントサイズ
- `body-font`: 本文フォント
- `sans-font`: 見出しフォント
- `math-font`: 数式フォント
- `leading`: 行間
- `margin`: ページ余白

### 4. 図表の追加

画像は`images/`ディレクトリに配置し、以下のように参照します：

```typst
#figure(
  image("images/example.png", width: 80%),
  caption: [図のキャプション]
) <fig:example>

// 図の参照
@fig:example に示すように...
```

表は以下のように作成します：

```typst
#figure(
  table(
    columns: 3,
    [項目], [値1], [値2],
    [A], [1], [2],
    [B], [3], [4],
  ),
  caption: [表のキャプション]
) <tab:example>

// 表の参照
@tab:example を参照してください。
```

### 5. 数式と定理環境

数式は以下のように記述できます：

```typst
$ x = (-b ± sqrt(b^2 - 4a c)) / (2a) $ <eq:quadratic>

// 数式の参照
@eq:quadratic は二次方程式の解の公式です。
```

定理環境も利用できます：

```typst
#figure(
  [定理の内容をここに記述],
  kind: "theorem",
  caption: [ピタゴラスの定理]
) <thm:pythagoras>
```

### 6. 章の追加（長い文書の場合）

長い文書を書く場合は、`chaps/`ディレクトリに章ごとのファイルを作成し、`main.typ`でインクルードできます：

```typst
// main.typの本文部分
#include "chaps/chapter1.typ"
#include "chaps/chapter2.typ"
#include "chaps/chapter3.typ"
```

### 7. 参考文献

`bibliography.bib`ファイルにBibTeX形式で参考文献を記述し、文書内で引用します：

```bibtex
@article{example2023,
  author = {著者名},
  title = {論文タイトル},
  journal = {学術誌名},
  year = {2023},
  volume = {1},
  pages = {1--10}
}
```

```typst
// 引用
文献によると@example2023...

// 参考文献の表示（main.typの最後に記述）
#bibliography(
  "bibliography.bib",
  title: [参考文献],
  style: "ieee",
)
```

## ファイル構成

```
├── main.typ              # メインファイル
├── template/             # テンプレートディレクトリ
│   ├── template_doc.typ  # メイン文書テンプレート
│   ├── useful_functions.typ # 便利な関数群
│   ├── my_short_hand.typ # ショートハンド定義
│   ├── translation.typ   # 翻訳機能
│   └── ja_en.typ        # 日英対応機能
├── chaps/               # 章ごとのファイル格納用（オプション）
├── images/              # 画像ファイル格納用
└── bibliography.bib     # 参考文献ファイル
```

## その他のテンプレート

必要に応じて以下の専用テンプレートも利用できます：

- `template_thesis.typ`: 修士論文用（表紙、目次、謝辞などを含む本格的な論文）
- `template_two_columns.typ`: 二段組みレイアウト（学会発表用）
- `template.typ`: シンプルな基本テンプレート

## トラブルシューティング

### フォントが見つからない場合
日本語フォントが正しくインストールされていることを確認してください。Windowsでは游明朝・游ゴシック、macOSではヒラギノフォント、LinuxではNoto CJKフォントの使用を推奨します。

### コンパイルエラーが発生する場合
- Typstのバージョンが最新であることを確認してください
- テンプレートファイルのパスが正しいことを確認してください
- 使用している外部パッケージが正しくインストールされていることを確認してください

## ライセンス

このテンプレート集は自由にご利用いただけます。学術研究、論文執筆等にお役立てください。