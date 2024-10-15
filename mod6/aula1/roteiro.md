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
it("Should emit an event on withdrawals", async function () {
    const { lock, unlockTime, lockedAmount } = await loadFixture(deployOneYearLockFixture);

    await time.increaseTo(unlockTime);

    await expect(lock.withdraw())
      .to.emit(lock, "Withdrawal")
      .withArgs(lockedAmount, anyValue);
});
```

### Migrando o Teste para Foundry (Solidity):

No Foundry, os testes são escritos diretamente em Solidity, o que melhora a integração com os contratos. Abaixo está a versão migrada do teste em Solidity:

```javascript
function testEmitWithdrawalEvent() public {
    vm.warp(unlockTime + 1);
    vm.prank(alice);
    vm.expectEmit(address(lock));
    emit Lock.Withdrawal(1 ether, block.timestamp);
    lock.withdraw();
}
```

### Diferenças Chave:

**Verificação do Evento:**
- Hardhat: Usa .to.emit() para capturar o evento diretamente na função de teste.
- Foundry: Usa vm.expectEmit() para definir as expectativas de um evento antes de chamar a função que deve emitir o evento.

**Captura de Argumentos:**
- Hardhat: O método .withArgs() permite verificar os valores dos argumentos do evento. No caso de anyValue, ele aceita qualquer valor para aquele argumento específico.
- Foundry: Não tem a função equivalente a anyValue. O evento esperado deve ser declarado explicitamente, com os argumentos exatos que você espera, como emit Lock.Withdrawal(1 ether, block.timestamp).

**Contexto de Tempo:**
- Hardhat: Usa time.increaseTo(unlockTime) para avançar o tempo até o unlockTime.
- Foundry: Usa vm.warp(JAN_1ST_2030 + 1) para definir o tempo diretamente.

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

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../../contracts/Lock.sol";

contract Deploy is Script {
    function run() external {
        uint256 ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
        uint256 unlockTime = block.timestamp + ONE_YEAR_IN_SECS;

        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);
        new Lock(unlockTime);
        vm.stopBroadcast();
    }
}
```

### Execução de Scripts:

- **Hardhat**:

```bash
 npx hardhat ignition deploy ignition/modules/Lock.js --network localhost
```

- **Foundry**:

```bash
forge script ignition/modules/Lock.s.sol:Deploy --broadcast --rpc-url http://localhost:8545
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

Na próxima aula, vamos explorar como **Guardando chaves com cast wallet** para não passar mais a chave via `vm.startBroadcast`. Até lá!