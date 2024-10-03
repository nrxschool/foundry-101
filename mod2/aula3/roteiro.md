# Roteiro da Aula 3: Testes e Coverage no Foundry

## 1. Abertura

Olá! Bem-vindo à nossa terceira aula do curso **Foundry 101**. Hoje vamos nos aprofundar em um dos aspectos mais importantes do desenvolvimento de contratos inteligentes: os **testes**.

Sem testes, o risco de introduzirmos falhas críticas em contratos que não podem ser modificados é muito alto. O Foundry nos oferece uma série de ferramentas para garantir que nossos contratos estão funcionando como esperado.

Nesta aula, vamos explorar:

1. Como funcionam os testes no Foundry
2. Configurando Teste com `Test.sol`
3. Escrever testes avançados
4. Como fazer cobertura de testes com Foundry

Vamos começar com o básico sobre como os testes funcionam no Foundry.

---

## 2. Como funcionam os testes no Foundry

No Foundry, os testes são escritos em arquivos **`.t.sol`**, que são contratos Solidity, mas focados exclusivamente em testar outros contratos. Isso é uma grande vantagem, pois podemos escrever testes no mesmo ambiente que os contratos são desenvolvidos, utilizando o poder do Solidity.

Os arquivos `.t.sol` ficam na pasta **`test/`** do seu projeto e são automaticamente detectados quando você roda o comando `forge test`. O Foundry também oferece uma biblioteca chamada **forge-std**, que fornece ferramentas poderosas para facilitar a criação de testes.

Vamos falar de três bibliotecas principais:

### Test

Essa biblioteca é o coração dos testes no Foundry. Ela oferece diversas funções para facilitar a criação de testes.

O contrato `Test.sol` é a base para todos os testes, e nele podemos definir variáveis, usar funções de manipulação da EVM e várias ferramentas úteis.

```javascript
import { Test } from "forge-std/Test.sol";
```

### Vm

O `Vm` permite que você interaja diretamente com a **máquina virtual Ethereum (EVM)** nos testes.

Isso significa que você pode manipular o tempo, as contas, os saldos e até controlar a execução de transações durante os testes.

```javascript
import { Vm } from "forge-std/Vm.sol";
```

### StdAssertions\*

A biblioteca `StdAssertions` oferece funções de asserção que permitem verificar se os valores nos testes estão corretos.

Funções como **`assertEq()`**, **`assertGt()`** e **`assertLt()`** são usadas para comparar valores e garantir que o comportamento do contrato é o esperado.

```javascript
import { StdAssertions } from "forge-std/StdAssertions.sol";
```

### Exemplo simples:

Vamos começar com um exemplo básico de como funciona um teste no Foundry. Crie um arquivo `Token.t.sol`:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

contract TokenTest is Test {
    Token token;

    function setUp() public {
        token = new Token(1_000_000);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1_000_000 * 1e18);
    }
}
```

Agora execute:

```shell
$ forge t
[⠊] Compiling...
No files changed, compilation skipped

Ran 1 test for test/Token.t.sol:TokenTest
[PASS] testInitialSupply() (gas: 14286)
Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 4.69ms (1.33ms CPU time)

Ran 1 test suite in 142.20ms (4.69ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)

```

### Explicação:

- **`setUp()`**: Inicializamos o contrato **Token** para que ele esteja disponível em cada teste.
- **`testInitialSupply()`**: Todo teste deve começar com `test`. Nesse teste verificamos se o `totalSupply` inicial está correto. Usamos a função **`assertEq()`** para garantir que o valor seja igual ao esperado.

---

## 3. Configurando Teste com `Test.sol`

Como vimos no exemplo anterior, os testes no Foundry herdam de **`Test.sol`**, que nos dá acesso a várias funções úteis para escrever testes de maneira eficiente.

### O que `setUp()` faz?

A função **`setUp()`** é chamada automaticamente antes de cada teste individual ser executado. Isso significa que qualquer configuração inicial — como a implantação de contratos ou a definição de variáveis — deve ser feita aqui.

No nosso exemplo, usamos **`setUp()`** para criar o contrato **Token** antes de cada teste:

```javascript
function setUp() public {
    token = new Token(1_000_000);
}
```

Isso garante que, em cada teste, temos um contrato novo e totalmente funcional.

### Usando a `Vm` para simular cenários

A biblioteca **Vm** nos dá controle total sobre o ambiente de teste. Podemos alterar o tempo, modificar o saldo de contas, fazer forks de redes, entre outros.

Exemplo de manipulação de tempo:

```javascript
// Simulando uma chamada de do usuário 0x00000000000000000000000000000000000000ff
vm.prank(address(0xff));

// Simulando o avanço de 1000 blocos no teste
vm.roll(1000);
```

### Funções de comparação (assertions)

No Foundry, as asserções são fundamentais para validar o comportamento dos contratos. Vamos explorar algumas delas:

- **`assertNotEq(a, b)`**: Verifica se `a` != `b`.
- **`assertEq(a, b)`**: Verifica se `a` == `b`.
- **`assertGt(a, b)`**: Verifica se `a` > `b`.
- **`assertLt(a, b)`**: Verifica se `a` < `b`.
- **`assertLe(a, b)`**: Verifica se `a` <= `b`.
- **`assertGe(a, b)`**: Verifica se `a` >= `b`.

Vamos adicionar mais algumas comparações ao nosso teste anterior para explorar essas asserções:

```javascript
function testInitialSupply() public {
    // totalSupply == 1_000_000
    assertEq(token.totalSupply(), 1_000_000 * 1e18);
    // totalSupply <= 1_000_000
    assertLe(token.totalSupply(), 1_000_000 * 1e18);
    // totalSupply > 0
    assertGt(token.totalSupply(), 0);
    // totalSupply != 0
    assertNotEq(token.totalSupply(), 0);
}
```

---

## 4. Escrevendo Testes Avançados

Agora que entendemos os conceitos básicos, vamos aprofundar e escrever testes mais avançados para o nosso contrato **Token**.

Vamos incluir transferências de tokens e cenários de falha.

### Criando usuários

Vamos criar 2 usuários, alice e bob para os testes ficarem mais legiveis

```javascript
contract TokenTest is Test {
    address alice = address(0xaaa);
    address bob = address(0xbbb);
    Token token;

    function setUp() public {

        vm.prank(alice);
        token = new Token(1_000_000);
    }

    // codigo...
}
```

### Criando Labels

Agora vamos adicionar labels para facilitar a leitura do tracing quando houver erro no teste

```javascript
function setUp() public {
    vm.label(alice, "ALICE");
    vm.label(bob, "BOB");

    // codigo...
}
```

### Fazendo deploy com `alice`

Agora vamos usar alice como o `msg.sender` para fazer deploy do nosso contrato

```javascript
function setUp() public {
    // codigo...

    vm.prank(alice);
    token = new Token(1_000_000);
}
```

### Testando saldo de `alice`

Vamos testar o saldo de `alice` e ver como funcionam as labels. Pra isso vamos escrever o teste errado para ver o tracing no terminal.

```javascript
function testInitialAliceBalance() public {
    assertEq(token.balanceOf(alice), 1_000_001 * 1e18);
}
```

Executando o teste

```
$ forge t --mt Alice -vvv
[⠊] Compiling...
No files changed, compilation skipped
...
    ├─ [2522] Token::balanceOf(ALICE: [0x0000000000000000000000000000000000000aaa]) [staticcall] 👈👈👈
...
```

Isso facilita muito a leitura dos testes quando temos erros. Agora corriga o teste!

### Testando a transferencia

```javascript
function testTransfer() public {
    vm.prank(alice);
    token.transfer(bob, 100 * 1e18);

    assertEq(token.balanceOf(bob), amount);
}

function testTransferFail() public {
    vm.prank(alice);
    vm.expectRevert();
    token.transfer(bob, 2_000_000 * 1e18);
}
```

### O que está acontecendo:

- **`testTransfer()`**: Verifica o saldo de `bob` após uma transferência de tokens.
- **`testTransferFail()`**: Verifica se ao enviar mais tokens do que seu saldo a chamada `token.transfer` falha.

Esses exemplos nos ajudam a cobrir cenários positivos e negativos, garantindo que o contrato se comporte de maneira robusta.

---

## 5. Cobertura de Testes e Como Aumentar a Cobertura

### Cobertura de Testes

Cobertura de testes é uma métrica que nos diz quantas linhas ou funções do código foram testadas. No Foundry, podemos gerar relatórios de cobertura de maneira simples usando o comando:

```shell
$ forge coverage
forge coverage

[⠊] Compiling...
[⠒] Compiling 26 files with Solc 0.8.24
[⠘] Solc 0.8.24 finished in 2.63s
Compiler run successful with warnings:
Analysing contracts...
Running tests...

Ran 4 tests for test/Token.t.sol:TokenTest
[PASS] testInitialAliceBalance() (gas: 13647)
[PASS] testInitialSupply() (gas: 16115)
[PASS] testTransfer() (gas: 45584)
[PASS] testTransferFail() (gas: 16397)
Suite result: ok. 4 passed; 0 failed; 0 skipped; finished in 7.30ms (1.40ms CPU time)

Ran 1 test suite in 141.72ms (7.30ms CPU time): 4 tests passed, 0 failed, 0 skipped (4 total tests)
| File          | % Lines      | % Statements | % Branches    | % Funcs      |
|---------------|--------------|--------------|---------------|--------------|
| src/Token.sol | 33.33% (1/3) | 33.33% (1/3) | 100.00% (0/0) | 33.33% (1/3) |
| Total         | 33.33% (1/3) | 33.33% (1/3) | 100.00% (0/0) | 33.33% (1/3) |
```

Isso gera um relatório que mostra quais partes do contrato foram cobertas pelos testes e quais não foram. veja que temos 3 funções e apenas 1 foi testado.

### Aumentando a cobertura

Vamos escrever 1 teste para as outras funções do contrato `Token` e rodar o `forge coverage` novamente.

```javascript
function testName() public {
    assertEq(token.name(), "My Token");
}

function testSymbol() public {
    assertEq(token.symbol(), "TOKEN");
}
```

Executando `forge coverage`:

```shell
➜  counter git:(main) ✗ forge coverage

[⠊] Compiling...
[⠑] Compiling 26 files with Solc 0.8.24
[⠃] Solc 0.8.24 finished in 2.70s
Compiler run successful with warnings:
Analysing contracts...
Running tests...

Ran 6 tests for test/Token.t.sol:TokenTest
[PASS] testInitialAliceBalance() (gas: 13647)
[PASS] testInitialSupply() (gas: 16115)
[PASS] testName() (gas: 10559)
[PASS] testSymbol() (gas: 10669)
[PASS] testTransfer() (gas: 45584)
[PASS] testTransferFail() (gas: 16397)
Suite result: ok. 6 passed; 0 failed; 0 skipped; finished in 15.46ms (10.87ms CPU time)

Ran 1 test suite in 151.58ms (15.46ms CPU time): 6 tests passed, 0 failed, 0 skipped (6 total tests)
| File          | % Lines       | % Statements  | % Branches    | % Funcs       |
|---------------|---------------|---------------|---------------|---------------|
| src/Token.sol | 100.00% (3/3) | 100.00% (3/3) | 100.00% (0/0) | 100.00% (3/3) |
| Total         | 100.00% (3/3) | 100.00% (3/3) | 100.00% (0/0) | 100.00% (3/3) |
```

Agora nosso contrato está 100% coberto (3/3). Lembrando que isso não é uma garantia de segurança nem de qualidade!

---

## 6. Conclusão

Hoje aprendemos como funcionam os testes no Foundry e exploramos ferramentas importantes como **Test**, **Vm** e **StdAssertions**. Vimos como configurar testes com **`setUp()`**, escrever testes com diferentes níveis de complexidade, e garantir que estamos cobrindo todas as partes importantes do nosso contrato. Também falamos sobre como aumentar a cobertura de testes, algo crucial para garantir a robustez dos contratos.

---

## 7. Recapitulação

- **Como funcionam os testes no Foundry**: Usamos `.t.sol` para escrever testes diretamente no ambiente Solidity.
- **Configurando Teste com `Test.sol`**: Exploramos o uso de **`setUp()`** para configurar o ambiente de teste e o uso de **Vm** para manipular a EVM.
- **Escrever testes avançados**: Criamos testes para transferências de tokens e cenários de falha.
- **Como fazer cobertura de testes com Foundry**: Geramos relatórios de cobertura e adicionamos novos testes para aumentar a cobertura.

---

## 8. Lição de casa

1. Escreva testes para o contrato **Token**: teste os cenários de `approve` e `transferFrom` entre várias contas.

---

## 9. Próxima aula

Na próxima aula, vamos aprender a criar **scripts de deploy** e automatizar o deploy dos seus contratos na rede principal. Até lá, continue praticando seus testes e nos vemos na próxima aula! 👋
