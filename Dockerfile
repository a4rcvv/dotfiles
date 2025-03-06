FROM ubuntu:latest

RUN apt update
RUN apt install -y zsh curl openssh-client

# make user
RUN useradd -m -s /bin/zsh user

# make bind mount dir
RUN mkdir /home/user/dotfiles
RUN chown user:user /home/user/dotfiles
WORKDIR /home/user/dotfiles

USER user
ENTRYPOINT ["/bin/zsh"]