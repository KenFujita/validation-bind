## やりたいこと
- ローカル環境でDNSサーバの動きを確認してみる
## 進捗
### 2023/01/05
- コンテナにすることはできた
- 疎通ができていないので、NWの設定を見直す
## 2023/01/20
- winホストからコンテナへのpingは不可能
- ipの設定が悪いのか`nslookup`もできなかった
- windowsの`Desktop on Docker`を使うこと自体がいけてないかもなので`WSL2`上で試してみる
## 2023/05/09
- 動いた
- `named.conf`にて独自ドメインのゾーン情報を読み込んでなかったのが原因だった
- `Desktop on Docker`が原因ではなさそう
- 基本的な問い合わせはできているので、水責め・SSL/TLSなども検証できるか調査する
## 2023/07/09
- `dig`で設定したドメインのテストを行う
- バッチモードで自動化できそうなのでやってみる
- シェルスクリプトで問い合わせ結果のみ見れるようにする
## 2024/06/23
- ゾーンファイルの構文チェックは `named-checkzone` で行う
    - ちなみに正引きにダブったレコードを、逆引きのアドレスの順序を無法地帯にしても何も言われなかった
- `named-checkconf` はその名の通りconfigファイルのチェックを行う
- コンテナのubuntuバージョンを `23.10` に変更
    - 以前使っていた `22.10` がバージョンリストから削除されていたため
