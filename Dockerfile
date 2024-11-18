# 使用 CentOS 7 作为基础镜像
FROM centos:7

# 设置维护者信息
LABEL maintainer="email@example.com"

# 更新系统并安装必要的依赖
RUN yum -y update && yum -y install \
    wget \
    curl \
    unzip \
    tar \
    gcc \
    make \
    java-1.8.0-openjdk-devel && \
    yum clean all

# 安装 JDK 1.8
RUN alternatives --config java && \
    alternatives --config javac

# 下载并安装 Miniconda
RUN wget -qO /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm -f /tmp/miniconda.sh

# 更新 conda 到最新版本
RUN /opt/miniconda/bin/conda update -n base -c defaults conda -y

# 配置环境变量
ENV PATH="/opt/miniconda/bin:${PATH}"
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk

# 设置默认工作目录
WORKDIR /workspace

# 创建一个默认命令，进入容器时打开一个 shell
CMD ["/bin/bash"]
