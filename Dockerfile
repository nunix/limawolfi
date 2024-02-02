# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/wolfi-base:latest

# Install extra packages
COPY wsl-files/extra-packages /
RUN apk update && \
    apk upgrade && \
    grep -v '^#' /extra-packages | xargs apk add
RUN rm /extra-packages

# Add systemd symlink to init
RUN ln -s /usr/lib/systemd/systemd /sbin/init

# Add wsl.conf file
COPY wsl-files/wsl.conf /etc/wsl.conf

# # Create user
# ARG USERNAME=${username:-lima}
# ARG PASSWORD=${password:-lima}
# ARG USER_ID=1000
# ARG GROUP_ID=1000

# RUN addgroup -g $GROUP_ID $USERNAME && \
#     adduser -D -u $USER_ID -G $USERNAME $USERNAME && \
#     echo "$USERNAME:$PASSWORD" | chpasswd && \
#     echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# # Update wsl.conf file
# RUN sed -i "s/root/$USERNAME/g" /etc/wsl.conf

# # Fix su-exec permissions
# RUN chmod u+s /sbin/su-exec
