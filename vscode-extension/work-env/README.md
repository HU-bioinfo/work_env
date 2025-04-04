# work-env

`work-env` は、統一された R および Python 開発環境を提供する解析用の VSCode 拡張機能です。コマンドを実行するだけで、簡単に解析環境をセットアップし、使用することができます。

## Features
- **統一された開発環境**: R と Python の統一環境を提供
- **簡単なセットアップ**: 少ない手順で環境構築が可能

## Requirements
- **サポートされているOS**: Linux, macOS
- **Windows対応**: WSL（Windows Subsystem for Linux）経由で使用可能

## Usage
- **Start work-env**: 開発環境を起動します。※初期セットアップが完了していない場合、自動で開始します。
- **Reset work-env config**: 設定をリセットして再度設定を行いたい場合に実行します。

- 設定項目：それぞれ設定ダイアログが表示されます。
  1. **プロジェクトフォルダ**: プロジェクトが格納されているフォルダのパスを指定します。
  2. **キャッシュディレクトリ**: 解析時に利用するキャッシュやライブラリを格納するフォルダのパスを指定します。
  3. **GitHub Personal Access Token (PAT)**: GitHubへのアクセスに必要なトークンです。GitHubアクセス時に使用します。

## License
MIT License
