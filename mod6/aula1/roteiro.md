# Aula 1: Migração de Hardhat para Foundry

## Abertura

Bem-vindo à primeira aula do módulo avançado! Hoje, vamos abordar como migrar um projeto existente de **Hardhat** para **Foundry**. O Hardhat é amplamente utilizado no desenvolvimento de contratos inteligentes, mas o Foundry oferece novas abordagens e benefícios, como a execução nativa de testes em Solidity e scripts mais simples e eficientes. Nosso objetivo nesta aula será guiar você pelos principais passos dessa transição.

### Programa da aula:

1. Criando um projeto em Hardhat.
2. Comparando com a estrutura do Foundry.
3. Migrando Testes.
4. Migrando Scripts.

---

## 1. Criando um Projeto em Hardhat

Vamos começar criando um projeto simples em Hardhat para entendermos sua estrutura antes de compará-lo com Foundry.

### Requisitos

- [Node.js](https://nodejs.org/pt)

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
- **hardhat.config.js**: Configurações de rede, paths e plugins.

---

## 2. Configurando o Foundry

Para adicionar o Foundry ao nosso projeto Hardhat, siga os seguintes passos:

### Instalando dependências

```bash
npm install --save-dev @nomicfoundation/hardhat-foundry
```

### Configurando `hardhat-foundry`

**Adicione em `hardhat.config.js`:**

```javascript
require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-foundry");

module.exports = {
  solidity: "0.8.27",
};
```

**No terminal, execute:**

```bash
npx hardhat init-foundry
```

---

## 3. Migrando Testes

Agora, vamos ver como migrar um teste escrito em JavaScript no Hardhat para Solidity no Foundry.

### Exemplo de Teste em Hardhat (JavaScript):

```javascript
const { expect } = require("chai");

describe("Lock", function () {
  it("Should set the right unlockTime", async function () {
    const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
    const unlockTime = (await time.latest()) + ONE_YEAR_IN_SECS;

    const Lock = await ethers.getContractFactory("Lock");
    const lock = await Lock.deploy(unlockTime);

    expect(await lock.unlockTime()).to.equal(unlockTime);
  });
});
```

### Migrando o Teste para Foundry (Solidity):

No Foundry, os testes são escritos diretamente em Solidity, o que melhora a integração com os contratos. Abaixo está a versão migrada do teste em Solidity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Lock.sol";

contract LockTest is Test {
    Lock lock;
    uint256 unlockTime;

    function setUp() public {
        uint256 ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
        unlockTime = block.timestamp + ONE_YEAR_IN_SECS;
        lock = new Lock(unlockTime);
    }

    function testUnlockTimeIsCorrect() public {
        assertEq(lock.unlockTime(), unlockTime);
    }
}
```

### Diferenças Chave:

- **JavaScript** vs **Solidity**: No Foundry, os testes são escritos na mesma linguagem dos contratos, o que facilita o processo de desenvolvimento e execução de testes.
- **Hardhat**: Usa Mocha e Chai para fazer asserções.
- **Foundry**: Usa funções nativas como `assertEq` para comparações.

---

## 4. Migrando Scripts

Scripts no Hardhat geralmente são escritos em JavaScript, enquanto no Foundry, eles são escritos diretamente em Solidity, utilizando a biblioteca `forge-std` para interagir com a EVM.

### Exemplo de Script de Deploy em Hardhat (JavaScript):

```javascript
async function main() {
  const Lock = await ethers.getContractFactory("Lock");
  const lock = await Lock.deploy(unlockTime);

  console.log("Lock deployed to:", lock.address);
}

main();
```

### Migrando o Script para Foundry (Solidity):

No Foundry, os scripts de deploy podem ser escritos como scripts Solidity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Lock.sol";

contract DeployScript is Script {
    function run() external {
        uint256 ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
        uint256 unlockTime = block.timestamp + ONE_YEAR_IN_SECS;

        vm.startBroadcast();
        new Lock(unlockTime);
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