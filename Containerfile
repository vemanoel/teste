FROM docker.io/library/debian:trixie-slim@sha256:a72b4433de1cf7d6bae0c4cee74d0547f58601a643b3375f070c51600d63b6b2

ARG TEMURIN_IMAGE=docker.io/library/eclipse-temurin:21-jdk@sha256:ebfbb18d11ff163ee83b21258acf12248af48d22a0fdfdc68fa1a1516c05976a
ENV JAVA_HOME=/opt/java/openjdk
COPY --from=$TEMURIN_IMAGE $JAVA_HOME $JAVA_HOME
ENV PATH=$JAVA_HOME/bin:$PATH

ARG NODE_IMAGE=docker.io/library/node:26.13.0-trixie-slim@sha256:e4db4c914bf8ad241bd24804fc25d272d89bad97e68cdc8a1414862790a02c39
COPY --from=$NODE_IMAGE /usr/local/bin /usr/local/bin
COPY --from=$NODE_IMAGE /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=$NODE_IMAGE /usr/lib/x86_64-linux-gnu/libatomic.so.1 /usr/lib/x86_64-linux-gnu

ENV ANDROID_HOME=/opt/android-sdk
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$ANDROID_HOME/platform-tools:$PATH
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH

RUN apt-get update -qq --yes && \
    apt-get install -qq --yes --no-install-recommends ca-certificates curl unzip && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSLO --retry 10 --retry-all-errors https://dl.google.com/android/repository/platform-tools_r37.0.1-linux.zip && \
    unzip -q platform-tools_r37.0.1-linux.zip && \
    rm platform-tools_r37.0.1-linux.zip && \
    mv platform-tools $ANDROID_HOME

RUN mkdir -p $ANDROID_HOME/cmdline-tools && \
    curl -fsSLO --retry 10 --retry-all-errors https://dl.google.com/android/repository/commandlinetools-linux-15859902_latest.zip && \
    unzip -q commandlinetools-linux-15859902_latest.zip && \
    rm commandlinetools-linux-15859902_latest.zip && \
    mv cmdline-tools $ANDROID_HOME/cmdline-tools/latest && \
    yes | sdkmanager --licenses > /dev/null

RUN apt-get purge --yes ca-certificates curl unzip && \
    apt-get autoremove --yes
