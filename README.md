# work_env

## 概要
北大Bioinfo研究会での解析用レポジトリです。

## 準備
### (Macユーザーのみ) Homebrewのダウンロード
[Homebrew](https://brew.sh/ja/)とは，適当に言えばプログラマー用のApp Storeです．

欲しいアプリやフォントなどを，黒い画面に文字を打ち込むことでダウンロードすることができます．

1. ターミナルアプリを開き，以下のコマンドを実行し,Homebrewを自分のPCで使えるようにしてしまえ
    ```zsh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

### Git
Gitとは**ファイルやプロジェクトの過去の状態を記録しておくツール**です．

例えば，何かの作業をして途中でミスをしてしまったり，別のアイディアを試してみたくなった場合，Gitを使っておけばいつでも好きな時点の状態に戻ることができます．

Gitを使って小説や論文を書いている人もいるらしい．

![](https://github.com/user-attachments/assets/cc9265c3-f4ce-479d-b268-3b2bb68e95b3)
1. gitを使わない例 何が完成品かわからない
![gitを使用した例　スッキリ]()

他にもいろんな機能があるけど，追々．

Mac userの場合，デフォルトでGitがダウンロードされています．

### Github
GitHubはGitを使って管理しているプロジェクトをインターネット上に保存して，他の人と共有・協力できる場所です.そしてお前が今見ているサイトのことでもあります．

アカウント作るついでに，今後使うであろう機能も知っておきましょう．
GitHubにおける **Access Token（アクセストークン）** は， **GitHubへの安全なアクセスを許可するための「鍵」** のようなものです．これは，パスワードの代わりに使われるもので，特にセキュリティを強化するために使われます．

1. GitHubのアカウントを作成する。
2. GitHub Personal Access Tokenを作成する。
    - [GitHubの設定](https://github.com/settings/tokens)から「Generate new token」をクリック
    - Repository access : All repositories
    - Permissions : Repository permissions -> Contents -> Read and Writeを選択
    - 「Generate token」をクリック
    - 表示されたトークンをコピーしてどこかに保存する (大事な物なので誰にも見せてはいけない)

### Docker
Dockerは、アプリケーションの実行環境をコンテナという形でパッケージ化し、どこでも同じ環境で動かせるようにするためのツールです．

大雑把に訳すと，チームで一緒に作業する時、みんなのパソコンが違うと動かないことがありますよね．Dockerを使えば，みんなが同じ環境で作業できるので，「このパソコンでは動くのに、あのパソコンでは動かない！」という問題を防げます．
どこでも同じように動かせて，軽くて速くて，効率がよくて，どこにでも持ち運べるのがDockerのいいところです．

やっぱり，他にもいろんな機能があるけど，追々．

1. [Docker](https://www.docker.com/products/docker-desktop)をHomebrewを使ってインストールする。
    ```zsh
    brew install --cask docker
    ```
2. アプリケーションからDockerを開き，アカウント設定を完了する．
3. インストール確認
    ```zsh
    docker --version
    ```
4. 動作確認
    ```zsh
    docker run hello-world
    ```
5. 使用するdockerイメージをダウンロードする
    ```zsh
    docker pull kokeh/hu_bioinfo:latest
    ```

dockerコマンドを使用するときはDockerアプリを立ち上げておく必要があるので注意．
使用した後はDockerアプリを終了するのを忘れずに．
細かい話は次回以降で．


### Editor
プログラミングにおける「エディタ」とは，**コードを書くためのテキスト編集ソフトウェアのこと**です．プログラミングのエディタは、普通のメモ帳のようなテキストエディタと似ていますが，**プログラムを書くのに便利な機能**が色々と付いています．

有名どころに[VSCode](https://code.visualstudio.com/)とかいろいろあります．


1. [VSCode](https://code.visualstudio.com/) または [Cursor](https://cursor.sh/)をHomebrewを使ってインストールする。
    ```zsh
    brew install --cask visual-studio-code
    ```
    or
    ```zsh
    brew install --cask cursor
    ```

2. 拡張機能「[Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)」「[Remote Explorer](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer)」「[Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)」をインストールする。

### 解析用レポジトリのセットアップ
1. リポジトリをローカルにクローンする。
    ```bash
    git clone https://github.com/kohta-hatanaka/work_env.git
    ```
2. .envのGITHUB_PATに先ほど取得したGithub Personal Access Tokenを設定する。


## 使い方
下記のコマンドを実行して、docker contaierを起動する。  
`docker run -it -v (work_env/wdのパス):/home/user kokeh/dev_slim:0.1.2`

基本的にprojフォルダ内でプロジェクトを作って動かす。  
各プロジェクトフォルダ内で  
・Pythonの初期化：`uv init`  
・Rの初期化：Rを2回実行する。(1回目はSave workspace image? [y/n/c]:→n、2回目はそのまま使える。)  
をすると使えるようになるので初期化して使用する事。  

jupyterの起動などは今後追加していく予定。  

注：メモリの消費が激しくなるため、vscodeを利用する際はホスト側(WSLを使っているときはwindows側)からのみ接続する事を推奨。
将来的にはdocker内でjupyter起動→ホスト側からサーバーに接続する形で実行する事を目標。


## セットアップ手順
1. VScode上でwork_env/containerを開く。
10. Ctrl+Shift+Pでコマンドパレットを開き、「Remote-Containers: Open Folder in Container」を選択する。
11. projectsフォルダの任意のプロジェクトフォルダ(まずはsample_projectを試すと良い)に移動する。
    ```bash
    cd projects/sample_project/
    ```
12. Rを起動する。
    ```bash
    R
    ```
13. R内で依存関係をインストールする。(初回はかなり時間がかかる)
    ```R
    renv::restore()
    ```
14. (RStudio-serverを使用する場合は、[http://localhost:8787](http://localhost:8787)にアクセスする。)


## 新しいプロジェクトを立ち上げる場合

1. コマンドパレットを開いて(Ctrl + Shift + P)「Tasks: Run Task」を実行
2. 「Create New Project」を実行
3. projectsフォルダに「new_project」というフォルダが作成される。
4. new_projectフォルダに移動する。
    ```bash
    cd projects/new_project/
    ```
5. Rを起動する。
    ```bash
    R
    ```
6. 依存関係をインストールする。
    ```R
    renv::restore()
    ```
7. フォルダ名を好きなプロジェクト名に変更する。（変更しないと次のnew_projectを作成できない）

## 新しいRパッケージのインストール

1. renv::install()を使う。
    ```R
    renv::install("パッケージ名")
    ```
2. src/libraries.Rに追記する。
    ```R
    library(パッケージ名)
    ```
3. 依存関係をrenv.lockに反映させる。
    ```R
    renv::snapshot()
    ```
