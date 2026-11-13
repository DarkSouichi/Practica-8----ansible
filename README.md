# Práctica de automatización con Ansible y Docker

## Descripción

Este proyecto consiste en automatizar la configuración de cinco servidores Ubuntu utilizando Ansible. Como entorno de prueba, se utilizaron contenedores Docker para simular cinco servidores independientes.

El objetivo es administrar los servidores desde un equipo principal y ejecutar tareas de configuración de manera automática.

## Tecnologías utilizadas

- Docker y Docker Compose.
- Ubuntu 24.04.
- Ansible.
- SSH.
- WSL Ubuntu.

## Estructura del proyecto

```text
practica-ansible/
├── Dockerfile
├── docker-compose.yml
├── README.md
├── .gitignore
└── ansible/
    ├── ansible.cfg
    ├── inventario.example.ini
    └── playbook.yml
```

## Servidores creados

Se crearon cinco contenedores Ubuntu:

| Servidor | Puerto SSH |
|---|---:|
| servidor1 | 2221 |
| servidor2 | 2222 |
| servidor3 | 2223 |
| servidor4 | 2224 |
| servidor5 | 2225 |

## Automatizaciones realizadas

Mediante un playbook de Ansible se ejecutaron las siguientes tareas en los cinco servidores:

1. Actualizar la caché de paquetes APT.
2. Crear el usuario `itla`.
3. Crear el directorio `/home/itla/app`.
4. Crear el archivo `hola.txt` dentro del directorio.
5. Instalar los programas `cowsay` y `htop`.

## Requisitos

- Docker Desktop con integración WSL habilitada.
- Ubuntu en WSL.
- Ansible.
- OpenSSH Client.
- sshpass.

## Cómo ejecutar el proyecto

### 1. Iniciar los contenedores

Desde la carpeta principal del proyecto:

```bash
docker compose up --build -d
```

### 2. Verificar los servidores

```bash
docker compose ps
```

### 3. Comprobar la conexión con Ansible

```bash
ansible servidores -m ping
```

### 4. Ejecutar el playbook

```bash
ansible-playbook ansible/playbook.yml
```

### 5. Verificar los resultados

Comprobar que el usuario fue creado:

```bash
ansible servidores -m command -a "id itla"
```

Comprobar el archivo creado:

```bash
ansible servidores -m shell -a "cat /home/itla/app/hola.txt"
```

Comprobar la instalación de cowsay:

```bash
ansible servidores -m shell -a "/usr/games/cowsay Hola ITLA"
```

Comprobar la instalación de htop:

```bash
ansible servidores -m command -a "htop --version"
```

## Resultado

La automatización se ejecutó correctamente en los cinco servidores Ubuntu. También se volvió a ejecutar el playbook para comprobar que las tareas fueran idempotentes: en la segunda ejecución no se realizaron cambios adicionales.

## Autor
Welinton Corporan 2025-1073
Práctica académica de la semana 8 sobre automatización con Ansible y Docker.
