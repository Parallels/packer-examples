#cloud-config
autoinstall:
  version: 1
  identity:
    hostname: ${hostname}
    username: ${username}
    password: '${password}'
  early-commands:
    # otherwise packer tries to connect and exceed max attempts:
    - systemctl stop ssh.service
    - systemctl stop ssh.socket
  apt:
    primary:
      - arches: [default]
        uri: http://us.archive.ubuntu.com/ubuntu/
    security:
      - arches: [default]
        uri: http://archive.ubuntu.com/ubuntu/
  ssh:
    install-server: yes
    allow-pw: yes
  late-commands:
    - echo '${username} ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/${username}