# Curso Defi - Lift Learning - Aula 04

Exercícios da Aula 04 usando o framework de smart contracts
[Foundry](https://github.com/gakonst/foundry)!

- [Iniciando](#iniciando)
  - [Requisitos](#requisitos)
  - [Baixando repositório da aula](#baixando-repositório-da-aula)
- [Teste de smart contracts](#teste-de-smart-contracts)
- [Dando deploy nos contratos](#dando-deploy-nos-contratos)
  - [Setup](#setup)
  - [Deploy](#deploy)
- [Contribuindo](#contribuindo)
- [Recursos](#recursos)

# Iniciando

## Requisitos

Por favor instale o seguinte:

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - Você saberá que está pronto quando der `git --version` e aparecer por
    exemplo `git version 2.34.1`
- Instalação manual do Foundry
  - Clique [aqui](https://github.com/foundry-rs/foundry/releases), vá em Assets,
    baixe `foundry_nightly_win32_amd64.zip` para Windows ou outro caso seja
    Linux/Mac
  - Crie uma pasta por exemplo em `C:\Users\Usuário\foundry\` e extraia os
    arquivos baixados para essa pasta
  - Adicione essa pasta no PATH das Variáveis de Ambiente
    - Win + R `sysdm.cpl` -> Avançado -> Variáveis de Ambiente
    - Selecione Path (da área de cima, não embaixo), clique em Editar...
    - Clique em Novo, cole o caminho de onde estão os executáveis do Foundry,
      por exemplo `C:\Users\Usuário\foundry\`
    - Dê OK em todas as janelas

## Baixando repositório da aula

- Baixe o repositório:

```sh
git clone https://github.com/pietro-lopes/foundry-lift-aula04
cd foundry-lift-aula04
git submodule update --init --recursive
```

- Abra a pasta da aula no seu editor, por exemplo, VSCode.

# Teste de smart contract

Abra o terminal do VSCode e digite o seguinte comando para testar todos os
contratos:

```
forge test
```

# Dando deploy nos contratos

## Setup

Abra o arquivo `.env.example`. Você precisará atualizar as seguintes variáveis
no arquivo `.env`:

- `PRIVATE_KEY`: Uma chave privada da sua carteira.
- `POLYGONSCAN_API_KEY`: Se você for verificar o contrato no polygonscan.

Renomeie pra `.env.example` para `.env`

## Deploy

### Carregando variáveis de ambiente

Para dar deploy e precisamos carregas as variáveis que atualizamos no `.env`:

- No Linux use `source .env`
- No Windows
  - cmd
    - `for /F "tokens=*" %i in (.env) do set %i`
  - PowerShell
    - `foreach ($line in Get-Content .env) { $array = $line.Split("="); New-Item -Force -Path Env:$($array[0]) -Value $($array[1].Trim('"').Trim("'")) }`

Para dar deploy e verificar na testnet da **Polygon Mumbai** por exemplo, use o
seguinte comando: **Não esqueça de carregar as variáveis que estão em** `.env`
_Sempre que você fechar o terminal, você terá que recarregar as variáveis
novamente._

- No terminal do Linux use `$NOME_DA_VARIAVEL`

  `forge create --verify --gas-price 60gwei --chain polygon-mumbai --rpc-url $MUMBAI_RPC --private-key $PRIVATE_KEY --etherscan-api-key $POLYGONSCAN_API_KEY src/T03TokenOwner.sol:T03TokenOwner`
- No PowerShell use `$Env:NOME_DA_VARIAVEL`

  `forge create --verify --gas-price 60gwei --chain polygon-mumbai --rpc-url $Env:MUMBAI_RPC --private-key $Env:PRIVATE_KEY --etherscan-api-key $Env:POLYGONSCAN_API_KEY src/T03TokenOwner.sol:T03TokenOwner`
- No CMD do Windows use `%NOME_DA_VARIAVEL%`

  `forge create --verify --gas-price 60gwei --chain polygon-mumbai --rpc-url %MUMBAI_RPC% --private-key %PRIVATE_KEY% --etherscan-api-key %POLYGONSCAN_API_KEY% src/T03TokenOwner.sol:T03TokenOwner`

Edite onde for necessário, por exemplo o `--gas-price` e o contrato
`src/<contrato>.sol:<contrato>` e adicione
`--constructor-args <arg1> <arg2> <arg3>` caso seu contrato tenha construtor que
precise de argumentos para inicialização

# Contribuindo

Contribuições são sempre bem-vindas! Abra um PR or um issue!

## Recursos

- [Documentação do Foundry](https://book.getfoundry.sh/)
