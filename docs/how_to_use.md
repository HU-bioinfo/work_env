# How to use
## 使い方
### 初期設定
1. 環境変数としてPREM_DIR、PROJ_DIRを設定する。好きな場所を設定してよい。
   PREM_DIR:ライブラリやキャッシュファイルが入る。基本的に触らない。
   PROJ_DIR:実際に動かすプロジェクトが入る。
   以下のコードを実行することで設定できる。
   ```bash
   echo "export PREM_DIR='決めたパス' >> ~/.bashrc
   echo "export PROJ_DIR='決めたパス' >> ~/.bashrc
   ```

### VScode/Cursorの場合
1. VScode/Cursorで/work_env/containerを開く。
2. /.devcontainer/.envtempを.envに名前を変更し、GITHUB_PATを自分のGitHubアクセストークンに設定する。
3. Ctrl+Shift+pでコマンドパレットに移動し、reopen in containerを実行。

### Terminalでの場合
下記のコマンドを実行して、docker contaierを起動する。  
`docker run -it -e PREM_DIR=/home/user/prem -v $PREM_DIR:/home/user/prem -e PROJ_DIR=/home/user/proj -v $PROJ_DIR:/home/user/proj -e GITHUB_PAT='自分のGitHubアクセストークン' kokeh/hu_bioinfo:stable`

基本的にprojフォルダ内でプロジェクトを作って動かす。  

## 機能
基本的にR、Pythonは不自由なく使えるようになっているかと思います。もし不具合などあれば教えてください。
プロジェクトの環境管理はprem(Python-R Environment Manager)というコマンドで制御しています。
`prem`と実行すれば、使い方が見られるはずです。

Python:`python`
R:`R`
と打てば実行できます。
