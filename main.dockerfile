FROM ubuntu:22.10

# RUN はイメージをビルドするときに実行される
# ミドルウェアのインストールやファイル読み込みはこの段階で済ます？
RUN apt update
RUN apt install bind9


