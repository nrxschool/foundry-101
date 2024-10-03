# Aula 4: Deploy usando Scripts

## 1. Abertura

Olá, seja bem-vindo à nossa quarta aula do curso **Foundry 101**! Hoje vamos explorar um dos tópicos mais poderosos do Foundry: o **deploy de contratos usando scripts em Solidity**.

Utilizar scripts é uma maneira eficiente e programática de fazer o deploy e a interação com contratos, além de permitir automações poderosas.

1. Como funcionam os scripts em Foundry
2. Scripts de Deploy simples
3. Deploy de contratos On-chain
4. Scripts On-chain avançados

Essa aula será bem prática, então vamos direto ao ponto!

---

## 2. Como funcionam os scripts no Foundry

No Foundry, os scripts ficam em **`script/`** são escritos em arquivos **`.s.sol`** e funcionam como contratos Solidity.

Eles tem o objetivo de ser uma forma mais declarativa para fazer deploy de contratos ao contrário do `forge create` que é menos amigavel.

Aqui a gente tem um grande vantagem sobre o Hardhat pois os scripts são escritos em Solidity e executam na EVM o que permite simular as execução antes de enviar para a blockchain.

Os scripts podem ser executados das seguintes formas:

- **Local**: O script executa localmente na EVM.
- **Simulação**: O script simula o resultado que teria on-chain mas ainda sem anviar as transações. (usando a flag --rpc-url)
- **On-chain**: O script executa as transações direto na rede. (usando a flag `--broadcast`)

## 3. Scripts de Deploy Simples

### Escrevendo script

Vamos criar um script básico de deploy para entender como funciona. Crie o arquivo **`script/TokenDeploy.s.sol`**:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);

        Token token = new Token(1_000_000);

        vm.stopBroadcast();
    }
}
```

### Explicação:

- **`Script`**: O contrato herda de **Script.sol** para acessar ferramentas de script do Foundry.
- **`run()`**: Essa função é o ponto de entrada do script.
- **`vm.startBroadcast()`**: Aqui carregamos a chave privada para assinar e gravar as transações.
- **`Token token = ...`**: Fazemos o deploy do contrato **Token** com uma oferta inicial de 1 milhão de tokens.

### Execução local (simulação)

Para rodar esse script localmente sem transmitir as transações, você pode usar o comando:

```shell
$ forge script script/Token.s.sol:Deploy

[⠊] Compiling...
No files changed, compilation skipped
Script ran successfully.
Gas used: 487532

If you wish to simulate on-chain transactions pass a RPC URL.
```

Isso executa do script localmente na EVM. Agora vamos ver a simulação on-chain

---

## 3. Deploy de contratos On-chain

Agora que vimos como um script básico funciona, vamos explorar como fazer isso on-chain usando a flag `--broadcast`.

O **broadcast** é o flag que envia as transações criadas pelo script para a rede. Após a simulação local, as transações são coletadas e transmitidas para a rede especificada.

Para fazer o **deploy on-chain**, podemos rodar o seguinte comando (lembrando de rodar o `anvil` antes):

```shell
$ forge script \
    script/Token.s.sol:Deploy \
    --rpc-url http://127.0.0.1:8545 \
    --broadcast

[⠊] Compiling...
No files changed, compilation skipped
Script ran successfully.

## Setting up 1 EVM.

==========================

Chain 31337

Estimated gas price: 0.047796225 gwei

Estimated total gas used for script: 673465

Estimated amount required: 0.000032189084669625 ETH

==========================

##### anvil-hardhat
✅  [Success]Hash: 0xdb610490db54c45d8745caa26fbfc8b7f01e432208be7964beb12e730ab0e17e
Contract Address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
Block: 30
Paid: 0.000010835834665008 ETH (518192 gas * 0.020910849 gwei)

✅ Sequence #1 on anvil-hardhat | Total Paid: 0.000010835834665008 ETH (518192 gas * avg 0.020910849 gwei)


==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.

Transactions saved to: /Users/olivmath/Documents/dev/foundry-101/mod2/counter/broadcast/Token.s.sol/31337/run-latest.json

Sensitive values saved to: /Users/olivmath/Documents/dev/foundry-101/mod2/counter/cache/Token.s.sol/31337/run-latest.json
```

Os parâmetros:

- **`--broadcast`**: Envia as transações.
- **`--rpc-url`**: URL RPC da rede onde o deploy será feito.

---

## 4. Executando scripts avançados
