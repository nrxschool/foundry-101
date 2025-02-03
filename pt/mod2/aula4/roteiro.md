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

Isso executa do script localmente na EVM. Agora vamos ver a simulação on-chain (lembrando de rodar o `anvil` antes):

```shell
$ forge script \
    script/Token.s.sol:Deploy \
    --rpc-url http://127.0.0.1:8545

[⠊] Compiling...
No files changed, compilation skipped
Script ran successfully.

## Setting up 1 EVM.

==========================

Chain 31337

Estimated gas price: 0.000001255 gwei

Estimated total gas used for script: 673465

Estimated amount required: 0.000000000845198575 ETH

==========================

SIMULATION COMPLETE. To broadcast these transactions, add --broadcast and wallet configuration(s) to the previous command. See forge script --help for more.

Transactions saved to: /Users/olivmath/Documents/dev/foundry-101/mod2/counter/broadcast/Token.s.sol/31337/dry-run/run-latest.json

Sensitive values saved to: /Users/olivmath/Documents/dev/foundry-101/mod2/counter/cache/Token.s.sol/31337/dry-run/run-latest.json
```

Nesse caso ele executa e simula o resultado caso tivesse sido executado on-chain

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

Dessa vez o script foi executado diretamente on-chain e o deploy do contrato `Token` foi feito com sucesso no endereço: `0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512` no bloco `30` com um custo de `0.000010835834665008 ETH`.
Os parâmetros:

- **`--broadcast`**: Envia as transações.
- **`--rpc-url`**: URL RPC da rede onde o deploy será feito.

---

## 4. Executando scripts avançados

Agora que já dominamos os conceitos básicos de deploy com scripts no Foundry, vamos aumentar a complexidade do nosso script e adicionar uma funcionalidade muito prática: o **airdrop** de tokens para várias carteiras logo após o deploy.

### Escrevendo o Script para Deploy e Airdrop

Vamos modificar nosso script para que, após fazer o deploy do contrato **Token**, ele distribua uma quantidade específica de tokens para cinco endereços diferentes.

Isso simula um airdrop automático após o deploy, que é uma funcionalidade comum em projetos blockchain.

Atualize o arquivo **`script/Token.s.sol`** com o seguinte conteúdo:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "forge-std/console2.sol";
import {Script} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract Deploy is Script {
    address[] public clients;
    uint256 public amount = 100 * 1e18;

    function setUp() public {
        clients = [
            0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f,
            0x70997970C51812dc3A010C7d01b50e0d17dc79C8,
            0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC,
            0x90F79bf6EB2c4f870365E785982E1f101E93b906,
            0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65
        ];
    }

    function run() external {
        vm.startBroadcast(
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );

        Token token = new Token(1_000_000 * 1e18);

        token.transfer(clients[0], amount);
        token.transfer(clients[1], amount);
        token.transfer(clients[2], amount);
        token.transfer(clients[3], amount);
        token.transfer(clients[4], amount);

        console2.log("Balance of client 0 is:", token.balanceOf(clients[0]));
        console2.log("Balance of client 1 is:", token.balanceOf(clients[1]));
        console2.log("Balance of client 2 is:", token.balanceOf(clients[2]));
        console2.log("Balance of client 3 is:", token.balanceOf(clients[3]));
        console2.log("Balance of client 4 is:", token.balanceOf(clients[4]));

        vm.stopBroadcast();
    }
}
```

### **Explicação**:

- **`setUp()`**: Aqui estamos configurando os endereços que receberão os tokens no airdrop. Essa função é chamada antes da execução principal.
- **`run()`**: O ponto de entrada principal do script, onde o deploy do contrato **Token** é feito, seguido pela transferência de tokens para cinco carteiras.
- **`vm.startBroadcast()` e `vm.stopBroadcast()`**: Esses comandos são usados para iniciar e finalizar a transmissão das transações.
- **`amount`**: Quantidade de tokens a serem enviados para cada carteira.
- **`clients`**: Lista de clientes.
- **`console2`**: Recurso do Foundry que simula o `console.log` do javascript.

### **Executando o Script**

Agora, para simular e depois enviar as transações para a blockchain, usamos os comandos:

### Simulação local

Primeiro, vamos simular o deploy e o airdrop localmente, para garantir que tudo funcione conforme o esperado.

```bash
$ forge script script/Token.s.sol:Deploy

[⠒] Compiling...
No files changed, compilation skipped
Script ran successfully.
Gas used: 641136

== Logs ==
  Balance of client 0 is: 100000000000000000000
  Balance of client 1 is: 100000000000000000000
  Balance of client 2 is: 100000000000000000000
  Balance of client 3 is: 100000000000000000000
  Balance of client 4 is: 100000000000000000000

If you wish to simulate on-chain transactions pass a RPC URL.
```

### Deploy e Airdrop on-chain

Se a simulação for bem-sucedida e estivermos prontos para realizar o deploy e o airdrop on-chain, rodamos o seguinte comando com a flag `--broadcast`:

```bash
$ forge script \
    script/TokenAirdrop.s.sol \
    --rpc-url http://127.0.0.1:8545 \
    --broadcast

[⠒] Compiling...
No files changed, compilation skipped
Script ran successfully.

== Logs ==
  Balance of client 0 is: 100000000000000000000
  Balance of client 1 is: 100000000000000000000
  Balance of client 2 is: 100000000000000000000
  Balance of client 3 is: 100000000000000000000
  Balance of client 4 is: 100000000000000000000

## Setting up 1 EVM.

==========================

Chain 31337

Estimated gas price: 0.785391811 gwei

Estimated total gas used for script: 1043537

Estimated amount required: 0.000819585414275507 ETH

==========================

##### anvil-hardhat
✅  [Success]Hash: 0x2d7b7831f8476fab3ce3d840b3372b649f636bdc81173d604f10ba05f04f4d10
Block: 9
Paid: 0.000017582811942978 ETH (51171 gas * 0.343608918 gwei)


##### anvil-hardhat
✅  [Success]Hash: 0x3a5687ddba6baeb2d16f8edb7fc033d52d971c72066319bbcc80215d2f749b02
Block: 9
Paid: 0.000017582811942978 ETH (51171 gas * 0.343608918 gwei)


##### anvil-hardhat
✅  [Success]Hash: 0x5344e3ddc6d6a5ac46dec5ea50ef898fb6a7f47e36090c03c2279d11c725e422
Contract Address: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Block: 9
Paid: 0.00017807188566432 ETH (518240 gas * 0.343608918 gwei)


##### anvil-hardhat
✅  [Success]Hash: 0x68b638ea7b7edf9a363b25129a19443edd9357ba98cf52c74b93851055425277
Block: 9
Paid: 0.000017582811942978 ETH (51171 gas * 0.343608918 gwei)


##### anvil-hardhat
✅  [Success]Hash: 0x95fd89b40240ab67a955b23f590cf6b5fae89fb337ec8858d9e69fbe6292ddc4
Block: 9
Paid: 0.000017578688635962 ETH (51159 gas * 0.343608918 gwei)


##### anvil-hardhat
✅  [Success]Hash: 0x76d39a2c87a7c3fc499837eafc1bb32f201babeabe37acf3ec6404373e65e301
Block: 9
Paid: 0.000017582811942978 ETH (51171 gas * 0.343608918 gwei)

✅ Sequence #1 on anvil-hardhat | Total Paid: 0.000265981822072194 ETH (774083 gas * avg 0.343608918 gwei)


==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.

Transactions saved to: /Users/olivmath/Documents/dev/foundry-101/mod2/counter/broadcast/Token.s.sol/31337/run-latest.json

Sensitive values saved to: /Users/olivmath/Documents/dev/foundry-101/mod2/counter/cache/Token.s.sol/31337/run-latest.json
```

Resultado: O contrato **Token** foi implantado na rede, criando 1 milhão de tokens.
Cada um dos 5 endereços definidos no array `clients` recebeu 100 tokens automaticamente após o deploy, simulando um airdrop.

Esse processo é simples e eficiente, permitindo que você faça o deploy e o airdrop de maneira automatizada com um único script.

---

## Conclusão

Nesta última parte da aula, vimos como implementar um **airdrop automático** após o deploy de um contrato de token. Esse tipo de funcionalidade é muito útil em lançamentos de tokens e campanhas de distribuição.

## Recapitulação

Nessa aula você aprendeu sobre:

- Como fucionam scripts em Foundry
- Como escrever scripts simples para fazer deploys declarativos
- Como simular e executar script on-chain e off-chain
- Fazer um simples airdrop de forma automática com scripts foundry

## Lição de casa

1. Otimize o código dos scripts usando `for`
2. Faça deploy do contrato Token em alguma testnet

## Próxima aula

Na próxima aula, vamos aprender sobre o **debug** outro recurso podereso que faz parte do `forge scripts`. Até lá, continue praticando scripts!
