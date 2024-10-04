# Roteiro da Aula 1: CLI e Executando Blockchain com Anvil

## 1. Abertura

Olá, seja bem-vindo à **primeira aula do Módulo 3** do nosso curso **Foundry 101**! Hoje, vamos aprender sobre o **Anvil**, a ferramenta de blockchain local do Foundry. O **Anvil** é essencial para simular ambientes de teste e para o desenvolvimento de contratos inteligentes em um ambiente controlado. Vamos abordar como rodar o Anvil, seu CLI, como conectar com **MetaMask**, e outras configurações úteis.

Os tópicos que vamos cobrir são:

1. O básico sobre como o **Anvil** funciona.
2. Mostrando o **CLI** e seus principais comandos.
3. Como configurar o **MetaMask** para se conectar ao **Anvil**.
4. Outras configurações úteis que facilitam o desenvolvimento.

Vamos começar!

---

## O básico sobre o Anvil e como rodar

O **Anvil** é um nó local que simula uma blockchain completa no seu computador. Ele vem junto com o **Foundry** e é extremamente útil para testar contratos inteligentes de maneira rápida, sem a necessidade de se conectar a uma rede pública. O **Anvil** permite:

- Criar várias contas para desenvolvimento.
- Rodar contratos localmente.
- Testar deploys e interações de contratos.

### Como rodar o Anvil

Para rodar o Anvil, é muito simples. Basta rodar o comando:

```bash
anvil
```

Quando você executa esse comando, o **Anvil** gera automaticamente 10 contas com chaves privadas e ETH disponível para cada uma delas. Essas contas podem ser usadas para deploys e testes.

```bash
Available Accounts
==================
(0) 0xF39Fd6e51aad88F6F4ce6aB8827279cffFb92266 (10000 ETH)
(1) 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC (10000 ETH)
(2) 0x90F79bf6EB2c4f870365E785982E1f101E93b906 (10000 ETH)
...
```

O **Anvil** começa a rodar por padrão no **localhost:8545**, o que significa que você pode interagir com ele usando ferramentas como **MetaMask** ou **Remix**.

---

## 3. Mostrando o CLI do Anvil

Agora que o **Anvil** está rodando, vamos explorar o **CLI**. O CLI permite customizar a execução do Anvil com várias opções.

### Comandos Úteis no CLI

- **Contas**: Você pode especificar quantas contas deseja gerar usando a flag `--accounts`:

```bash
# Isso criará 15 contas em vez das 10 padrão.
anvil --accounts 15
```

- **Balance inicial**: Pode também configurar o saldo inicial das contas:

```bash
# Aqui, cada conta será criada com 500 ETH.
anvil --balance 500
```

- **Mining personalizado**: O **Anvil** gera um novo bloco assim que uma transação é enviada. Mas, você pode mudar isso para intervalos fixos de mineração usando:

```bash
# Isso gerará um novo bloco a cada 10 segundos.
anvil --block-time 10
```

---

## Conectando o MetaMask ao Anvil

Agora, vamos conectar o **MetaMask** ao **Anvil** para que possamos interagir com a blockchain local.

### Passos para conectar o MetaMask ao Anvil\*

1. **Abrir o MetaMask** e clicar na opção para adicionar uma rede.
2. No campo de **Nova Rede**, adicione os seguintes valores:
   - **Nome da Rede**: Anvil Local
   - **Nova URL RPC**: `http://127.0.0.1:8545`
   - **ID da Rede**: `31337` (padrão do Anvil)
   - **Moeda**: ETH
3. Clique em **Salvar**.

Agora o **MetaMask** está conectado à sua blockchain local rodando no Anvil.

### Importando Contas do Anvil para o MetaMask

O Anvil gera automaticamente chaves privadas para suas contas de desenvolvimento. Para importar uma dessas contas no MetaMask, basta:

1. Copiar a chave privada de uma das contas geradas pelo Anvil.
2. No MetaMask, clicar em **Importar Conta** e colar a chave privada.
3. Pronto! Agora você pode usar essa conta para testar deploys e interações diretamente com contratos no Anvil.

---

## Outras Configurações Úteis

### Forking de uma Rede Real

Uma das funcionalidades mais poderosas do **Anvil** é a capacidade de fazer **fork** de uma rede real. Isso significa que você pode pegar o estado atual de uma rede como Ethereum, testnet Sepolia, etc., e simular localmente. Para isso, basta rodar o comando:

```bash
anvil --fork-url <RPC_URL>
```

### Configurar o Mining Manual

Se você quiser ter mais controle sobre quando os blocos são minerados, pode usar o modo "manual" de mineração. Isso é útil para testar contratos onde o timing das transações importa.

```bash
anvil --no-mining
```

Nesse caso, você precisaria rodar o comando `anvil_mine` manualmente para gerar novos blocos.

```bash
RPC="http://127.0.0.1:8545"
cast rpc anvil_mine --rpc-url $RPC
```

Você pode personalizar o limite de gas dos blocos e o Chain ID:

```bash
anvil --gas-limit 12000000 --chain-id 1337
```

Esses parâmetros são úteis ao testar contratos que exigem mais gas ou quando você precisa usar um **chain ID** específico.

---

## 6. Conclusão

Hoje aprendemos o básico sobre o **Anvil** e como ele pode ser usado para rodar uma blockchain local para testes. Exploramos o **CLI**, aprendemos a conectar o **MetaMask** ao **Anvil** e vimos algumas das configurações mais úteis, como **forking** de redes reais e ajuste de mineração. Esse conhecimento será essencial nas próximas aulas, onde iremos avançar para deploys e interações mais complexas com contratos.

---

## Recapitulação

- **Rodando o Anvil**: Como iniciar o nó local e configurar o ambiente de desenvolvimento.
- **CLI do Anvil**: Exploramos opções para gerar contas, modificar o tempo de mineração, e ajustar balances.
- **Conectar MetaMask**: Conectamos o MetaMask à rede local do Anvil.
- **Configurações avançadas**: Vimos como forkar redes reais e ajustar parâmetros como o gas limit e chain ID.

---

## Lição de casa

1. Rodar o **Anvil** no seu ambiente de desenvolvimento e gerar contas.
2. Conectar o **MetaMask** ao **Anvil** e importar uma conta gerada.
3. Explore o CLI do **Anvil** e altere alguns parâmetros, como o balance inicial e o número de contas geradas.

---

## Próxima aula

Na próxima aula, vamos configurar mais detalhadamente o **Anvil**, incluindo forking de redes e ajustes de mineração manual. Até lá, continue praticando, e nos vemos na próxima aula! 👋
