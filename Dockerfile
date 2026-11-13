
FROM ubuntu:24.04

# Evitar preguntas durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar SSH, sudo y Python
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Crear usuario ansible con contraseña ansible
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd

# Dar permisos sudo sin contraseña
RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible && \
    chmod 0440 /etc/sudoers.d/ansible

# Habilitar autenticación por contraseña en SSH
RUN mkdir -p /run/sshd && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Puerto SSH
EXPOSE 22

# Iniciar el servidor SSH
CMD ["/usr/sbin/sshd", "-D"]
