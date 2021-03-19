# 🚀  Automação Infraestrutura WordPress na Vultr com Terraform e Ansible

![alt text](https://github.com/alejunio/Terraform-Ansible-Vultr-WordPress/blob/main/img/automacao-wordpress-vultr.jpg)

**Infraestrutura como código (IaC)** é uma realidade atualmente, e vem para ajudar a acelerar os processos na criação e configuração de ambientes de infraestrutura. Quando unimos o Terraform(automacao infra) com Ansible(automacao configuracões), temos uma solução perfeita! Podemos criar ambientes de hospedagem de forma rápida e fácil. 


## Objetivo do Projeto

O objetivo do projeto é automatizar tudo, desde a criação do servidor, configuração do servidor e também configuração do DNS na plataforma da Vultr.


# Arquitetura do Projeto

A imagem abaixo representa como organizamos o projeto.

![alt text]()


## Pré Requisitos

A Stack está funcional seguindo os requisitos abaixo:
* Chave API Vultr : https://my.vultr.com/settings/#settingsapi
* Domínio apontado para o DNS da Vultr
* Terraform na máquina local

ns1.vultr.com \ ns2.vultr.com 


## Preparando o Ambiente (Seu Computador)

Para executar a Stack você vai precisar executar os passos abaixo. "Desconsidere caso já tenha feito algum passo".
#### 1) Download do pacote Terraform
Faça o download do pacote referente ao sistema operacional que você utiliza.
* Vídeo Instalação Windows/Linux: https://www.youtube.com/watch?v=bSrV1Dr8py8
* Download: https://www.terraform.io/downloads.html


#### 2) Download do Projeto
Você pode realizar o download da Stack através do link:

* https://github.com/alejunio/terraform-ansible-wordpress-digitalocean/archive/main.zip


## Configurações na Stack

Após realizar o download do repositório, recomendo utilizar algum editor como o Notepad++, VSCode ou algum de sua preferência para configurar a Stack.

### Arquivos de Configuração Terraform

Você deve realizar configuracoes nos arquivos abaixo:

- main.tf

No campo de chave SSH, insira o conteúdo em texto da sua chave pública.


- variable.tf

No arquivo variable.tf você vai configurar a chave de API da Vultr, e o domínio do site que você quer configurar.


### Arquivos de Configuração Ansible

Você não pode esquecer de configurar também o Ansible. Ainda não encontrei uma maneira de integrar as variáveis do terraform ao ansible, então vocês devem
configurar também as variáveis do Ansible. Caso contrário terá problemas!

No diretorio do Ansible temos todas as roles responsáveis pela configuração interna do servidor. 
- /ansible/mysql
- /ansible/nginx
- /ansible/php
- /ansible/ssl-certbot
- /ansible/wordpress

O playbook "chama" todas essas roles para que tudo seja configurado (PHP,MySQL,Nginx,SSL, etc). No entanto, você precisa ajustar variáveis importantes, veja abaixo as principais.

Edite o arquivo de variaveis:
- /ansible/vars/vars.yaml 

```shell
 db_user:  
 db_user_password:
 db_name: 
 dominio_site: 
 email: 
```

## Deploy da Stack

Após ter ajustado todas as configurações necessárias para o funcionamento da stack e ter configurado o DNS do seu domínio apontando para a Vultr, você poderá executar a stack para criar o ambiente.

Para executar a stack, abra o terminal (cmd, shell, etc) e navegue até a pasta do projeto que você fez o download. Exemplo abaixo:
![alt text]()

O comando abaixo irá inicializar o terraform realizando o download de todos os módulos necessários para o deploy da stack.
```shell
 terraform init 
```

O comando abaixo realiza todo o "mapeamento" do que será implementado, e caso tenha algum bug ou alguma configuração errada, você verá vários alertas em vermelho.
```shell
 terraform plan
```

O comando abaixo irá realizar o deploy da infraestrutura, eu estimo que demore cerca de 5/9 minutos.
```shell
 terraform apply -auto-approve
```

Após finalizar o deploy, você verá uma mensagem similar/igual a essa abaixo:
![alt text]()



## Atenção
A Stack está funcional, mas ainda está em desenvolvimento. Ideias e planos para a Stack:

* Ansible
 - [x] Nginx [ 1.14 ]
 - [x] PHP [ 7.2 ]
 - [x] MySQL [ 5.76 ]
 - [x] SSL Certbot Let's Encrypt
 - [ ] Ioncube
 - [ ] Composer
 - [ ] Secrets Ansible Vault

* Terraform
 - [ ] Variaveis compartilhaveis com Ansible e vice versa
