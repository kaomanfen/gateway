FROM centos:latest

# 安装 openresty
RUN yum install -y pcre-devel openssl-devel gcc curl wget unzip yum-utils make && \
    yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo && \
    yum install -y openresty openresty-resty && \
    yum clean all &&  rm -rf /var/cache/yum/*

ENV PATH=$PATH:/usr/local/openresty/luajit/bin/:/usr/local/openresty/nginx/sbin/:/usr/local/openresty/bin/

# 安装 luarocks
WORKDIR /tmp
RUN wget https://luarocks.org/releases/luarocks-3.0.4.tar.gz && \
    tar zxpf luarocks-3.0.4.tar.gz 

WORKDIR /tmp/luarocks-3.0.4
RUN  ./configure && \
    make build && make install 

WORKDIR /root
# 安装依赖包
RUN USER=root luarocks install penlight && \ 
    USER=root luarocks install luacrypto && \
    USER=root  luarocks install lua-resty-jwt


RUN mkdir -p /tmp/cache && mkdir -p /var/log/openresty


WORKDIR /srv/app/api-gateway

ADD . .

CMD ["/usr/local/openresty/nginx/sbin/nginx","-c","/srv/app/api-gateway/deploy/nginx/conf/nginx.conf","-g", "daemon off;"]