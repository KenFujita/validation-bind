# update version
FROM ubuntu:23.10

# RUN はイメージをビルドするときに実行される
# ミドルウェアのインストールやファイル読み込みはこの段階で済ます？
# インストール時には必ずyオプションをつける（プロンプト入力でabortになるため）
RUN apt update
RUN apt install -y bind9
RUN cp /etc/bind/named.conf.options /etc/bind/named.conf.options.bk

COPY config/named.conf.internal-zones /etc/bind/
COPY config/named.conf.options /etc/bind/
COPY config/example.fuji.lan /etc/bind/
COPY config/29.172.db /etc/bind/

# named.confに独自ドメインのゾーン情報を読み込ませる
RUN echo 'include "/etc/bind/named.conf.internal-zones";' >> /etc/bind/named.conf

RUN named-checkconf -z
# ゾーンファイルのチェックは下記で行う
RUN named-checkzone example.fuji /etc/bind/example.fuji.lan
RUN named-checkzone 29.172.in-addr.arpa /etc/bind/29.172.db

# DNSポートをあける
EXPOSE 53/tcp
EXPOSE 53/udp

# 基本的にDockerコンテナ内ではsystemctlは呼び出せないらしい
# アプリケーションプログラムを直接実行する
# 下記コマンドはsystemctl等のサービス起動コマンドを使ったときに確認できる
CMD ["/usr/sbin/named","-c","/etc/bind/named.conf","-g","-u","bind"]
