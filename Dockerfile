#Dockerfileからコンテナを作る方法
# Dockerfileという名前のファイルを作成する

# ベースになるコンテナのイメージを指定する(何も入っていないOSのコンテナを指定することが多い)
# USERでコンテナ側のユーザーを変更できる　USER<username>

FROM ubuntu:20.04
USER root
# APTとは、Linuxでソフトウェアの導入や管理、削除に用いられるパッケージ管理システムの一つ。 pipみたいな感じで使うやつ
# また、それを操作するコマンド（apt）。Debian系ディストリビューションで標準的に使われている。
RUN apt update
RUN apt install -y python3.9
RUN apt install -y python3-pip

# requirements.txtをコンテナ側に渡さないとインスコ出来ないのでそのコマンド　COPY　ローカルファイルのパス　コンテナ側のパス( .)
COPY requirements.txt .
RUN python3.9 -m pip install -r requirements.txt 

# ENVで環境変数を設定できる　<環境変数名>=<設定する値>
ENV SITE_DOMAIN=max.com

# WORKDIR コンテナ側の作業ディレクトリを変更できる
WORKDIR /var
# ADD リモート上のファイルもコンテナ側へコピペできる
ADD https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data .

# ENTRYPOINT コンテナ実行 docker run したときに動かしたいシェルコマンドを指定できる 
#COPY script.py .
#ENTRYPOINT ["python3.9", "script.py"]
