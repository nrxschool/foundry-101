# Aula 3: Forks Locais com Anvil

## 1. Abertura


Olá! Seja bem-vindo à **quarta aula do Módulo 3** do curso **Foundry 101**! Hoje, vamos explorar uma das funcionalidades mais poderosas do **Anvil**: o **Fork de Redes Locais**. Vamos aprender como podemos "copiar" o estado de uma rede real, como a mainnet ou uma testnet, e usar localmente para testar contratos com dados reais.

Os tópicos que vamos cobrir hoje são:

1. O que é um **fork local** e por que usá-lo.
2. Como configurar e rodar um fork de uma rede real no **Anvil**.
3. Executar interações com contratos já existentes em um fork.
4. Testar novas implementações no fork de uma rede.

Essa funcionalidade é uma das mais úteis para desenvolvedores que querem simular o comportamento de seus contratos em uma rede real sem gastar gás. Vamos começar!

---

## 2. O que é um Fork Local e Por que Usá-lo

### O que é um fork?

Um **fork local** é uma cópia exata de uma blockchain real (como a mainnet Ethereum, Goerli, ou Sepolia), com todos os contratos, transações e estados de conta daquela rede. Com o **Anvil**, você pode rodar essa cópia localmente em seu computador e testar contratos ou interações sem a necessidade de pagar taxas de gás.

### Por que usar forks locais?

1. **Simular a Mainnet/Testnet localmente**: Ao fazer um fork da mainnet ou testnet, você tem acesso ao estado atual de todos os contratos da rede. Isso permite simular interações reais, como testar transações complexas ou interagir com contratos populares (por exemplo, Uniswap, Aave).
2. **Testar alterações sem custos**: Ao testar um contrato ou uma interação em um fork, você não paga taxas de gás reais, o que torna o desenvolvimento e depuração muito mais rápido e barato.
3. **Depuração avançada**: O **fork** permite que você pause, volte no tempo e inspecione estados anteriores da blockchain enquanto realiza testes.

---

## 3. Como Configurar e Rodar um Fork no Anvil

### Passo 1: Rodar um Fork de uma Rede Real

Para fazer um fork local de uma rede real, você precisa de um **RPC URL** de um provedor de blockchain (como Infura, Alchemy, ou Ankr). Vamos usar a Mainnet **Ethereum** como exemplo.

1. Suba o Anvil apontando para o RPC da Ethereum com o seguinte comando:

```bash
anvil --fork-url https://eth-mainnet.g.alchemy.com/v2/<API_KEY>
```

Esse comando cria uma cópia exata do estado atual da rede Ethereum e a executa localmente no **Anvil**.

**`--fork-url`**: Define a URL do RPC da rede que será forkeada.

Você pode rodar esse comando para qualquer rede suportada, como **Mainnet**, **Sepolia** ou **Optimism**, mudando o URL do RPC.

### Passo 2: Definir um Bloco Específico (Opcional)

Se você quiser forkar a rede a partir de um bloco específico, pode adicionar a flag `--fork-block-number`:

```bash
anvil --fork-url https://eth-mainnet.g.alchemy.com/v2/<API_KEY> --fork-block-number 1234567
```

Isso é útil se você estiver testando uma transação ou evento que ocorreu em um bloco específico e quer garantir que o estado da rede reflita aquele momento exato.

---

## 4. Interagindo com Contratos Existentes em um Fork

Agora que temos o **fork** rodando, podemos interagir com os contratos que já existem na rede. Isso é uma maneira prática de testar interações com contratos reais.

### Passo 1: Usar Cast para Chamar Funções de Contratos

Suponha que você queira interagir com o contrato do **Uniswap V2** na Ethereum testnet. Você pode usar o **Cast** para chamar funções no contrato diretamente.

1. Identifique o endereço do contrato **Uniswap V2** na rede Ethereum.
2. Use o comando **Cast** para chamar uma função do contrato:

```bash
cast call 0xUniswapV2ContractAddress "getReserves()"
```

Esse comando chama a função `getReserves()` de um par de tokens no contrato Uniswap V2 e retorna o estado das reservas atuais.

### Passo 2: Modificar Estados no Fork com Transações Simuladas

Você também pode simular transações que modificam o estado da blockchain. Vamos supor que você queira testar uma **swap** no contrato Uniswap sem pagar gás real.

1. Use **Cast** para enviar uma transação simulada:

```bash
cast send 0xUniswapV2ContractAddress "swap(uint amount0Out, uint amount1Out, address to, bytes calldata data)" 100 0 0xYourAddress "0x"
```

Aqui, estamos simulando uma troca de tokens no Uniswap.

---

## 5. Testando Novas Implementações no Fork

Uma das funcionalidades mais interessantes de um fork é a capacidade de **implementar novos contratos** ou **testar atualizações** em contratos existentes.

### Passo 1: Deploy de um Novo Contrato em um Fork

Vamos fazer o deploy de um contrato ERC20 simples na rede Ethereum, usando o fork local:

1. Primeiro, suba o **Anvil** com o fork da rede Ethereum.
2. Em seguida, crie um script de deploy para o contrato:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "solmate/tokens/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("My Token", "MTK", 18) {
        _mint(msg.sender, initialSupply);
    }
}
```

3. Execute o deploy usando o **Forge** no ambiente forkeado:

```bash
forge script script/DeployToken.s.sol --fork-url http://127.0.0.1:8545 --broadcast
```

Agora, o contrato está implantado no seu fork local da Ethreum, e você pode interagir com ele como faria normalmente.

---

## 6. Conclusão

Hoje, exploramos como fazer forks locais de redes reais usando o **Anvil**, como interagir com contratos já existentes e testar novas implementações. Essa técnica permite testar interações complexas em um ambiente realista sem pagar taxas de gás, oferecendo um ambiente de desenvolvimento mais eficiente e seguro.

---

## Recapitulação

- **Forks Locais**: Copiamos o estado da rede Goerli para um ambiente local e interagimos com contratos reais.
- **Interação com Contratos**: Usamos o **Cast** para chamar funções e enviar transações simuladas.
- **Deploy de Novos Contratos**: Fizemos o deploy de um contrato ERC20 no fork e testamos suas interações.

---

## Lição de Casa

1. Faça o fork de uma rede real (como Sepolia ou Mainnet) e interaja com um contrato existente.
2. Implante um novo contrato no fork e teste sua interação com outros contratos da rede.

---

## Próxima Aula

Na próxima aula, vamos continuar explorando como interagir com contratos na blockchain, usando **Cast** e tudo o que aprendemos até agora. Até lá, continue praticando e nos vemos na próxima aula! 👋
