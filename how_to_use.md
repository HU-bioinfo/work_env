# How to use
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
