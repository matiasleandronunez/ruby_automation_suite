# Use the official Playwright Docker image as base
FROM mcr.microsoft.com/playwright

###### Install Ruby and dependencies
# Install required dependencies
RUN apt-get update && apt-get install -y \
        ruby \
        ruby-dev \
        ruby-json \
        build-essential \
        libc-dev \
        libffi-dev

# Install bundler
RUN gem install bundler

# Install required gems using your Gemfile
COPY ./cucumber/Gemfile* ./
RUN bundle install

###### Install K6
COPY --from=loadimpact/k6:latest /usr/bin/k6 /usr/bin/k6

# Confirm the installation
RUN k6 --version

###### Install GIT to be able to pull gems from GitHub
RUN apt-get update && \
    apt-get install -y git

###### Install dependency for ffi gem in Alpine
RUN apt-get update && \
    apt-get install -y build-essential

###### ENABLE SSHing
# create user SSH configuration
RUN mkdir -p /root/.ssh \
    # only this user should be able to read this folder (it may contain private keys)
    && chmod 0700 /root/.ssh

RUN apt-get update && \
    apt-get install -y openssh-server \
    && ssh-keygen -A \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config

RUN service ssh start
######


# create a folder to copy code
RUN mkdir /automation

# project scope
WORKDIR /automation

# copy code
COPY ./ ./

# keep alive
CMD ["tail", "-f", "/dev/null"]