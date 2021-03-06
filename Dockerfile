FROM ubuntu:20.04

ENV GOPATH=/root 
ENV PATH=/usr/local/go/bin:$GOPATH/bin:$PATH
# Add SSH keys
ADD id_rsa /home/go/.ssh/id_rsa
ADD id_rsa.pub /home/go/.ssh/id_rsa.pub

RUN mkdir -p /root/.ssh \
&& echo "Host *" >> /root/.ssh/config \
&& echo "    StrictHostKeyChecking no" >> /root/.ssh/config \
&& echo "    GlobalKnownHostsFile  /dev/null" >> /root/.ssh/config \
&& echo "    UserKnownHostsFile    /dev/null" >> /root/.ssh/config \
&& chmod 600 /home/go/.ssh/id_rsa \
&& chmod 644 /home/go/.ssh/id_rsa.pub \
# Configure default git user
&& echo "[user]" >> /home/go/.gitconfig \
&& echo "	email = chauhanx.ritesh@gmail.com" >> /home/go/.gitconfig \
&& echo "	name = Ritesh" >> /home/go/.gitconfig \
# Add repositories 
&& apt-get update && apt -y dist-upgrade \
&& apt-get install -y apt-utils software-properties-common \
&& apt-add-repository universe \
&& apt-add-repository multiverse \
&& apt update \
# Set Locale
&& apt-get install -y language-pack-en-base \
&& locale-gen en_US en_US.UTF-8 \
&& dpkg-reconfigure locales \
&& apt-get install -y \
autoconf \
automake \
autotools-dev \
build-essential \
cmake \
curl \ 
dpkg \
gawk \
gettext \
ghostscript \
git \
htop \
intltool \ 
jq \
llvm \
lsof \
make \
mawk \
zip \
wget \
vim \
# Install go packages 
&& wget --no-check-certificate https://storage.googleapis.com/golang/go1.16.6.linux-amd64.tar.gz \
&& tar xvf go1.16.6.linux-amd64.tar.gz \
&& rm -rf /usr/local/go \
&& mv go /usr/local \
&& mkdir -p /root/bin \
&& mkdir -p /root/pkg \
&& mkdir -p /root/src \
&& echo 'export GOPATH=/root' >> /root/.profile \
&& echo 'export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH' >> /root/.profile \
&& go version \

&& apt-get clean \
&& apt-get autoclean \
&& apt-get -y autoremove

ADD .vimrc /root

# install the pathogen 
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && \ 
    curl -LkSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim 

RUN git config --global http.sslVerify false && \ 
    git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-goi && \
    git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree

RUN mkdir -p ~/.vim/colors && curl -Gk https://raw.githubusercontent.com/lsdr/monokai/master/colors/monokai.vim -o ~/.vim/colors/monokai.vim

RUN rm /go1.16.6.linux-amd64.tar.gz

