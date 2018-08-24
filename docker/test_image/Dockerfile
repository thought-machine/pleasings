FROM thoughtmachine/please_ubuntu:latest
MAINTAINER peter.ebden@gmail.com

# OpenFST / Thrax
WORKDIR /tmp
RUN curl -sSf http://www.openfst.org/twiki/pub/FST/FstDownload/openfst-1.6.3.tar.gz | tar -xz && \
    cd openfst-1.6.3 && \
    ./configure --prefix=/usr --enable-static --enable-shared --enable-lookahead-fsts --enable-grm --enable-compact-fsts --enable-const-fsts --enable-far && \
    make -j4 && \
    make install && \
    rm -rf /tmp/openfst-1.6.3
# Note that Thrax installs some things for root:staff, which fails on CircleCI, so we chown
# them back to root:root again.
RUN curl -sSf http://www.openfst.org/twiki/pub/GRM/ThraxDownload/thrax-1.2.3.tar.gz | tar -xz && \
    cd thrax-1.2.3 && \
    ./configure --prefix=/usr --enable-static --enable-shared && \
    make -j4 && \
    make install && \
    rm -rf /tmp/thrax-1.2.3 && \
    chown -R root:root /usr/share /usr/bin

# Node (for js / yarn)
RUN curl -sSL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

# Android
ENV ANDROID_HOME "/opt/android"
ENV ANDROID_NDK_HOME "/opt/android/ndk-bundle"
ENV PATH "$PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_NDK_HOME}/"
RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1
RUN curl https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -fsSLo /tmp/tools.zip \
    && unzip /tmp/tools.zip -d $ANDROID_HOME && \
    rm /tmp/tools.zip
RUN mkdir $ANDROID_HOME/licenses && echo -n -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > $ANDROID_HOME/licenses/android-sdk-license && \
    echo -e "84831b9409646a918e30573bab4c9c91346d8abd" > $ANDROID_HOME/licenses/android-sdk-preview-license && \
    $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" \
    "tools" \
    "build-tools;25.0.3" \
    "platforms;android-25" \
    "ndk-bundle"
RUN $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-26"

# Python gRPC codegen plugin
# This is a prebuilt version to avoid having to do a full-blown compile of the whole thing.
RUN curl -fsSLo /usr/local/bin/grpc_python_plugin https://get.please.build/third_party/binary/grpc_python_plugin-1.4.0 && \
    chmod +x /usr/local/bin/grpc_python_plugin

# New version of Clang (for ThinLTO)
RUN curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main" > /etc/apt/sources.list.d/llvm.list && \
    apt-get update && \
    apt-get install -y clang-6.0

# pip (python deps)
RUN apt-get install -y python3-pip
