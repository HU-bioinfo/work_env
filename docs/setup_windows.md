## 準備
### (windowsユーザーのみ) WSLの有効化
1. 管理者としてPowerShellを起動し、コマンドを実行する。
    ```PowerShell
    wsl --install
    ```
以下(WSLと書いてある場合、windowsユーザーはWSL内で実行する事)

### git
1. 以下のコマンドでgitをインストールする。(WSL内)
    ```bash
    sudo apt-get update
    sudo apt-get install git gh
    ```

### Github
1. GitHubのアカウントを作成する。
2. GitHub Personal Access Tokenを作成する。
    - [GitHubの設定](https://github.com/settings/tokens)から「Generate new token」をクリック
    - Repository access : All repositories
    - Permissions : Repository permissions -> Contents -> Read and Writeを選択
    - 「Generate token」をクリック
    - 表示されたトークンをコピーしてどこかに保存する(公開してはいけない)

### Editor
1. VSCode または Cursorをインストールする。
    - [VScodeの公式サイト](https://code.visualstudio.com/download)からOSに対応したインストーラーをダウンロードしてインストール
    - [Cursorの公式サイト](https://cursor.sh/)からインストーラーをダウンロードしてインストール
2. 拡張機能「Dev Containers」「Remote Explorer」「Docker」をインストールする。

### 解析用レポジトリのセットアップ
1. リポジトリをローカルにクローンする。
    ```bash
    git clone https://github.com/HU-bioinfo/work_env.git
    ```
2. .envのGITHUB_PATに先ほど取得したGithub Personal Access Tokenを設定する。

### docker
1. クローンしたレポジトリに移動。(WSL内)
2. rootでプログラムを実行して、dockerをインストールする。(WSL内)
    ```bash
    sudo -s
    source docker_init.sh
    exit
    ```
3. インストール確認
    ```bash
    docker --version
   ```
4. ユーザーの有効化
    ```bash
    cat /etc/group | grep docker
    sudo gpasswd -a (user name) docker
    exit(一回ログアウト)
    ```
5. 動作確認
    ```bash
    docker run hello-world
    ```
3. 使用するdockerイメージをダウンロードする
    ```bash
    docker pull kokeh/hu_bioinfo:latest
    ```
