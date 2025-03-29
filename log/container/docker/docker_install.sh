#!/bin/bash

# スクリプトをroot権限で実行するためのチェック
if [ "$EUID" -ne 0 ]; then
    echo "このスクリプトはrootユーザーで実行する必要があります。"
    return 1
fi

# OSの判別
OS=$(uname -s)

if [ "$OS" = "Linux" ]; then
    # /etc/os-release が存在するか確認
    if [ -f /etc/os-release ]; then
        # /etc/os-release を読み込む
        . /etc/os-release
        OS_ID=$ID
    else
        echo "オペレーティングシステムを判別できません。"
        return 1
    fi

    # 既存のDocker関連パッケージを削除（存在する場合のみ）
    if dpkg -l | grep -q -E 'docker|containerd'; then
        apt-get remove -y docker docker-engine docker.io containerd runc
    fi

    # パッケージリストを更新
    apt-get update

    # 必要なパッケージをインストール
    apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release



    # OS によって処理を分岐
    case "$OS_ID" in
        ubuntu)
            # DockerのGPGキーを保存するディレクトリを作成
            mkdir -p /etc/apt/keyrings

            # Dockerの公式GPGキーをダウンロードして保存
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

            # Dockerのリポジトリを追加
            echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
            ;;
        debian)
            sudo install -m 0755 -d /etc/apt/keyrings
            sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
            sudo chmod a+r /etc/apt/keyrings/docker.asc

            echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
                $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            ;;
        *)
            echo "サポートされていないOS: $OS_ID"
            return 1
            ;;
    esac

    # パッケージリストを再度更新
    apt-get update

    # Dockerエンジンと関連パッケージをインストール
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    usermod -aG docker $(id -u)
    # Dockerのバージョンを表示
    docker -v

elif [ "$OS" = "Darwin" ]; then
    # macOSのDockerインストール
    if ! command -v brew &> /dev/null; then
        echo "Homebrewが見つかりません。インストールします。"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "Homebrewを使用してDockerをインストールします。"
    brew install --cask docker

    echo "Dockerをインストールしました。アプリケーションフォルダからDockerを起動してください。"
    open -a Docker

else
    echo "サポートされていないOS: $OS"
    exit 1
fi
