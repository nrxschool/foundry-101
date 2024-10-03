### **Roteiro da Aula 3: Testes e Coverage no Foundry**

---

## **1. Abertura**

(👋 Olhando para a câmera)

Olá! Bem-vindo à nossa terceira aula do curso **Blockchain Focado em Foundry**. Hoje vamos nos aprofundar em um dos aspectos mais importantes do desenvolvimento de contratos inteligentes: os **testes**. Sem testes, o risco de introduzirmos falhas críticas em contratos que não podem ser modificados é muito alto. O Foundry nos oferece uma série de ferramentas para garantir que nossos contratos estão funcionando como esperado.

Nesta aula, vamos explorar:

1. **Como funcionam os testes no Foundry**, explicando como usar o `.t.sol` e as principais bibliotecas como **Test**, **Vm** e **StdAssertions**.
2. **Herança de `Test.sol`**, onde veremos como configurar os testes com **`setUp()`** e as principais funções de asserção (`eq`, `lt`, `gt`, etc.).
3. **Escrever testes para nosso contrato Token**, começando com casos simples e progredindo em complexidade.
4. **Cobertura de testes**, onde explicaremos como garantir que todas as partes do contrato foram testadas e como aumentar a cobertura.

Vamos começar com o básico sobre como os testes funcionam no Foundry.

---

## **2. Tópico 1: Como funcionam os testes no Foundry**

(📋 Explicativo + exemplo simples)

No Foundry, os testes são escritos em arquivos **`.t.sol`**, que são contratos Solidity, mas focados exclusivamente em testar outros contratos. Isso é uma grande vantagem, pois podemos escrever testes no mesmo ambiente que os contratos são desenvolvidos, utilizando o poder do Solidity.

Os arquivos `.t.sol` ficam na pasta **`test/`** do seu projeto e são automaticamente detectados quando você roda o comando `forge test`. O Foundry também oferece uma biblioteca chamada **forge-std**, que fornece ferramentas essenciais para facilitar a criação de testes.

Vamos falar de três bibliotecas principais:

### **Test**:
Essa biblioteca é o coração dos testes no Foundry. Ela oferece diversas funções para facilitar a criação de testes. O contrato `Test.sol` é a base para todos os testes, e nele podemos definir variáveis, usar funções de manipulação da EVM e várias ferramentas úteis.

```solidity
import {Test} from "forge-std/Test.sol";
```

### **Vm**:
O `Vm` permite que você interaja diretamente com a **máquina virtual Ethereum (EVM)** nos testes. Isso significa que você pode manipular o tempo, as contas, os saldos e até controlar a execução de transações durante os testes.

```solidity
import {Vm} from "forge-std/Vm.sol";
```

### **StdAssertions**:
A biblioteca `StdAssertions` oferece funções de asserção que permitem verificar se os valores nos testes estão corretos. Funções como **`assertEq()`**, **`assertGt()`** e **`assertLt()`** são usadas para comparar valores e garantir que o comportamento do contrato é o esperado.

```solidity
import {StdAssertions} from "forge-std/StdAssertions.sol";
```

### Exemplo simples:

Vamos começar com um exemplo básico de como funciona um teste no Foundry. Crie um arquivo `Token.t.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Token.sol";

contract TokenTest is Test {
    Token token;

    function setUp() public {
        // Criando o contrato Token com 1 milhão de tokens
        token = new Token(1_000_000);
    }

    function testInitialSupply() public {
        // Verificando se o totalSupply inicial está correto
        assertEq(token.totalSupply(), 1_000_000 * 1e18);
    }
}
```

### Explicação:
- **`setUp()`**: Inicializamos o contrato **Token** para que ele esteja disponível em cada teste.
- **`testInitialSupply()`**: Esse é o nosso primeiro teste, onde verificamos se o `totalSupply` inicial está correto. Usamos a função **`assertEq()`** para garantir que o valor seja igual ao esperado.

---

## **3. Tópico 2: Herança de `Test.sol` e uso de `setUp()`**

(🔧 Explicação mais profunda + exemplo intermediário)

Como vimos no exemplo anterior, os testes no Foundry herdam de **`Test.sol`**, que nos dá acesso a várias funções úteis para escrever testes de maneira eficiente. A função **`setUp()`** é muito importante, pois é executada antes de cada teste e pode ser usada para configurar o ambiente de teste.

### **O que `setUp()` faz?**
A função **`setUp()`** é chamada automaticamente antes de cada teste individual ser executado. Isso significa que qualquer configuração inicial — como a implantação de contratos ou a definição de variáveis — deve ser feita aqui.

No nosso exemplo, usamos **`setUp()`** para criar o contrato **Token** antes de cada teste:

```solidity
function setUp() public {
    token = new Token(1_000_000);
}
```

Isso garante que, em cada teste, temos um contrato novo e totalmente funcional.

### **Usando a `Vm` para simular cenários**

A biblioteca **Vm** nos dá controle total sobre o ambiente de teste. Podemos alterar o tempo, modificar o saldo de contas, fazer forks de redes, entre outros.

Exemplo de manipulação de tempo:

```solidity
// Simulando o avanço do tempo no teste
vm.warp(block.timestamp + 1000); // Avançando 1000 segundos
```

### **Funções de comparação (assertions)**

No Foundry, as asserções são fundamentais para validar o comportamento dos contratos. Vamos explorar algumas delas:

- **`assertEq(a, b)`**: Verifica se `a` é igual a `b`.
- **`assertGt(a, b)`**: Verifica se `a` é maior que `b`.
- **`assertLt(a, b)`**: Verifica se `a` é menor que `b`.
- **`assertLe(a, b)`**: Verifica se `a` é menor ou igual a `b`.
- **`assertGe(a, b)`**: Verifica se `a` é maior ou igual a `b`.

Vamos adicionar mais algumas comparações ao nosso teste para explorar essas asserções:

```solidity
function testSupplyComparisons() public {
    uint256 initialSupply = token.totalSupply();

    // Verificando se o totalSupply é maior que 0
    assertGt(initialSupply, 0);

    // Verificando se o totalSupply é menor ou igual a 1 milhão de tokens
    assertLe(initialSupply, 1_000_000 * 1e18);
}
```

---

## **4. Tópico 3: Escrevendo Testes Mais Avançados**

(🧪 Demonstração prática com complexidade crescente)

Agora que entendemos os conceitos básicos, vamos aprofundar e escrever testes mais avançados para o nosso contrato **Token**. Vamos incluir transferências de tokens e cenários de falha.

Crie mais testes no arquivo `Token.t.sol`:

```solidity
function testTransfer() public {
    address recipient = address(0x123);
    uint256 amount = 100 * 1e18;

    token.transfer(recipient, amount);

    // Verificando se o saldo do destinatário está correto
    assertEq(token.balanceOf(recipient), amount);
}

function testTransferFail() public {
    address recipient = address(0x456);
    uint256 amount = 2_000_000 * 1e18; // Mais do que o saldo disponível

    // Testando se a transferência falha ao exceder o saldo
    vm.expectRevert(); // Esperamos que o próximo comando falhe
    token.transfer(recipient, amount);
}
```

### O que está acontecendo:

- **`testTransfer()`**: Verifica se uma transferência de tokens entre contas está funcionando corretamente.
- **`testTransferFail()`**: Simulamos uma transferência que excede o saldo disponível, usando a função **`vm.expectRevert()`**, que garante que o teste falhe se a transação for bem-sucedida.

Esses exemplos nos ajudam a cobrir cenários positivos e negativos, garantindo que o contrato se comporte de maneira robusta.

---

## **5. Tópico 4: Cobertura de Testes e Como Aumentar a Cobertura**

(📊 Explicativo + prática)

### **Cobertura de Testes**

Cobertura de testes é uma métrica que nos diz quantas linhas ou funções do código foram testadas. No Foundry, podemos gerar relatórios de cobertura de maneira simples usando o comando:

```
forge coverage
```

Isso gera um relatório que mostra quais partes do contrato foram cobertas pelos testes e quais não foram.

### **Aumentando a cobertura**

Suponha que, após rodar o relatório de cobertura, percebemos que não testamos o comportamento do contrato quando a função **`_mint()`** é chamada. Podemos adicionar um teste para cobrir essa função:

```solidity
function testMintTokens() public {
    uint256 initialSupply = token.totalSupply();
    token.mint(address(this), 500 * 1e18);

    // Verificando se o novo totalSupply está correto
    assertEq(token.totalSupply(), initialSupply + 500 * 1e18);
}
```

Esse teste garante que a função **`_mint

()`** seja coberta e que o comportamento da emissão de novos tokens esteja funcionando como esperado.

### **Reexecutando a cobertura**

Após adicionar o novo teste, podemos rodar o comando **`forge coverage`** novamente para verificar se a cobertura aumentou e se todas as partes críticas do contrato foram testadas.

---

## **6. Conclusão**

(🎯 Amarrar os tópicos)

Hoje aprendemos como funcionam os testes no Foundry e exploramos ferramentas importantes como **Test**, **Vm** e **StdAssertions**. Vimos como configurar testes com **`setUp()`**, escrever testes com diferentes níveis de complexidade, e garantir que estamos cobrindo todas as partes importantes do nosso contrato. Também falamos sobre como aumentar a cobertura de testes, algo crucial para garantir a robustez dos contratos.

---

## **7. Recapitulação**

(📝 Resumo rápido)

- **Testes no Foundry**: Usamos `.t.sol` para escrever testes diretamente no ambiente Solidity.
- **Herança com Test.sol**: Exploramos o uso de **`setUp()`** para configurar o ambiente de teste e o uso de **Vm** para manipular a EVM.
- **Escrevendo testes**: Criamos testes para transferências de tokens e cenários de falha.
- **Cobertura de testes**: Geramos relatórios de cobertura e adicionamos novos testes para aumentar a cobertura.

---

## **8. Lição de casa**

(📚 Instruções práticas)

1. Escreva mais testes para o contrato **Token**, incluindo cenários de edge cases como transferências entre várias contas.
2. Use o comando **`forge coverage`** para verificar a cobertura dos seus testes e tente cobrir qualquer parte que ficou de fora.

---

## **9. Próxima aula**

(🔜 Antecipação da próxima aula)

Na próxima aula, vamos aprender a criar **scripts de deploy** e automatizar o deploy dos seus contratos na rede principal. Até lá, continue praticando seus testes e nos vemos na próxima aula! 👋

---

Esse roteiro foi ajustado para focar na estrutura solicitada, aumentando gradualmente a complexidade dos testes, e garantindo um entendimento mais profundo das ferramentas do Foundry, incluindo herança, manipulação da EVM e cobertura de testes.