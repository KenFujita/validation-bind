FROM ubuntu:22.10

# RUN はイメージをビルドするときに実行される
# ミドルウェアのインストールやファイル読み込みはこの段階で済ます？
RUN apt update
RUN apt install bind9
RUN cp /etc/bind/named.conf.options /etc/bind/named.conf.options.bk

COPY named.conf.internal-zones /etc/bind/
COPY named.conf.options /etc/bind/
COPY example.fuji.lan /etc/bind/
COPY 29.172.db /etc/bind/

RUN named-checkconf -z

# DNSポートをあける
EXPOSE 53/tcp
EXPOSE 53/udp

# 基本的にDockerコンテナ内ではsystemctlは呼び出せないらしい
# アプリケーションプログラムを直接実行する
# 下記コマンドはsystemctl等のサービス起動コマンドを使ったときに確認できる
CMD ["/usr/sbin/named","-c","/etc/bind/named.conf","-g","-u","named"]