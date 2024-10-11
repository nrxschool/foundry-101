# Aula 1: Migração de Hardhat para Foundry

## Abertura

Bem-vindo à primeira aula do módulo avançado. Hoje, vamos abordar como migrar um projeto existente de **Hardhat** para **Foundry**. Hardhat é amplamente usado no desenvolvimento de contratos inteligentes, mas o Foundry traz novas abordagens e benefícios, como a execução nativa de testes em Solidity e scripts mais simples e eficientes. Nosso objetivo nesta aula será guiar você pelos principais passos dessa transição.

### Programa da aula:

1. Criando um projeto em Hardhat.
2. Comparando com a estrutura do Foundry.
3. Migrando Testes.
4. Migrando Scripts.

---

## 1. Criando um Projeto em Hardhat

Vamos começar criando um projeto simples em Hardhat para entendermos sua estrutura antes de compará-lo com Foundry.

### Requisitos

- [node](https://nodejs.org/pt)

### Passos para criar o projeto:

1. Inicialize o Hardhat:

```bash
npx hardhat
```

2. Selecione **Create a basic sample project** e siga os passos indicados.

3. A estrutura básica do projeto criado em Hardhat será:

```
├── contracts/
│   └── Greeter.sol
├── scripts/
│   └── sample-script.js
├── test/
│   └── sample-test.js
├── hardhat.config.js
└── package.json
```

### O que temos:

- **contracts/**: Diretório com os contratos Solidity.
- **scripts/**: Scripts de deploy escritos em JavaScript/TypeScript.
- **test/**: Testes escritos em Mocha/Chai (JavaScript/TypeScript).
- **hardhat.config.js**: Configurações de rede, paths, e plugins.

---

## 2. Comparando com a Estrutura do Foundry

Agora que temos um projeto Hardhat, vamos criar um projeto Foundry para comparação.

### Criando um Projeto Foundry:

1. Inicialize o Foundry:

   ```bash
   forge init my-foundry-project
   ```

2. A estrutura do Foundry será:

   ```
   ├── src/
   │   └── Greeter.sol
   ├── script/
   │   └── Deploy.s.sol
   ├── test/
   │   └── GreeterTest.t.sol
   ├── foundry.toml
   ```

### Diferenças entre Hardhat e Foundry:

- **contracts/** vs **src/**: Foundry usa o diretório **src** para contratos.
- **scripts/** vs **script/**: Scripts de deploy no Foundry são escritos em **Solidity**, enquanto no Hardhat são geralmente em JavaScript.
- **hardhat.config.js** vs **foundry.toml**: Foundry usa o **foundry.toml** para configurar o projeto, substituindo o arquivo JavaScript de configuração do Hardhat.
- **test/**: Os testes no Foundry são escritos em Solidity, enquanto no Hardhat usam Mocha/Chai com JavaScript ou TypeScript.

---

## 3. Migrando Testes

### Exemplo de Teste em Hardhat (JavaScript):

```javascript
const { expect } = require("chai");

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
```

### Migrando o Teste para Foundry (Solidity):

No Foundry, os testes são escritos em **Solidity**. Vamos migrar o teste acima:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Greeter.sol";

contract GreeterTest is Test {
    Greeter greeter;

    function setUp() public {
        greeter = new Greeter("Hello, world!");
    }

    function testGreet() public {
        assertEq(greeter.greet(), "Hello, world!");
    }

    function testSetGreeting() public {
        greeter.setGreeting("Hola, mundo!");
        assertEq(greeter.greet(), "Hola, mundo!");
    }
}
```

### Diferenças Chave:

- **Mocha/Chai** vs **Solidity**: Foundry utiliza funções como `assertEq` e `vm` em vez de `expect` ou `assert` do Mocha/Chai.
- **Execução nativa**: O teste é escrito na mesma linguagem que os contratos, resultando em melhor integração e performance.

---

## 4. Migrando Scripts

Scripts no Hardhat são usados para deploys e interações. No Foundry, esses scripts são escritos diretamente em Solidity.

### Exemplo de Script de Deploy em Hardhat:

```javascript
async function main() {
  const Greeter = await ethers.getContractFactory("Greeter");
  const greeter = await Greeter.deploy("Hello, world!");
  await greeter.deployed();

  console.log("Greeter deployed to:", greeter.address);
}

main();
```

### Migrando o Script para Foundry (Solidity):

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Greeter.sol";

contract DeployScript is Script {
    function run() external {
        vm.startBroadcast();
        new Greeter("Hello, world!");
        vm.stopBroadcast();
    }
}
```

### Execução de Scripts:

- **Hardhat**:

  ```bash
  npx hardhat run scripts/sample-script.js --network localhost
  ```

- **Foundry**:

  ```bash
  forge script script/Deploy.s.sol --broadcast --rpc-url http://localhost:8545
  ```

---

## Conclusão

Nesta aula, migramos um projeto de **Hardhat** para **Foundry**, comparando suas estruturas e funcionalidades. Vimos como converter testes e scripts para Solidity e como configurar o **foundry.toml** para refletir as necessidades do projeto.

---

## Lição de casa

- Crie um projeto Hardhat simples e migre-o completamente para Foundry.
- Converta ao menos um teste e um script de deploy de JavaScript para Solidity.

---

## Próxima Aula

Na próxima aula, vamos explorar como integrar o **ScaffoldETH2** com o **Forge** para criar um ambiente de front-end interativo com seus contratos Solidity. Até lá!
