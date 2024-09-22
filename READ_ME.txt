初期設定
1: dockerをインストールする。
2: "docker pull kokeh/dev:0.2"を実行する。
3: gitをインストールする。
4: "git clone git@github.com:kohta-hatanaka/work_env.git"を好きな場所(ホームディレクトリとか)で実行する。
5: .devcontainer/devcontainer.jsonを修正する。
  場所:mountsのsourceを自分のwdのpathに変える。
6: work_envをvscodeで開く。windowsユーザーはwslの中で開くこと。
7: reopen in containerという通知が出てくるので実行。開き逃した/出てこない場合などは左下の><ボタンから選択できる。

プロジェクトを作る場合
/home/projフォルダで"proj_init.sh"を実行。

