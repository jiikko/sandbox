FROM debian:sid

RUN apt-get update && apt-get install git build-essential wget libssl-dev libreadline-dev zlib1g-dev vim curl -y
RUN git clone https://github.com/rbenv/ruby-build
RUN git clone https://github.com/rbenv/rbenv
RUN git clone --depth 1 https://github.com/rbenv/rbenv.git ~/.rbenv && \
      echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN mkdir -p ~/.rbenv/plugins && \
      git clone --depth 1 https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

CMD bash
