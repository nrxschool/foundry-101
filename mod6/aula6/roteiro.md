# Aula 5: Testes Avançados

## Abertura

Nesta aula, vamos explorar as metodologias de teste em desenvolvimento de contratos inteligentes, focando em **Test-Driven Development (TDD)** e a importância dos testes na construção de aplicações em **Web3**. Em particular, vamos nos aprofundar no **Fuzz Testing**, uma técnica poderosa que ajuda a identificar comportamentos inesperados nos contratos. Além disso, abordaremos o uso de **cheatcodes** e como interpretar os resultados dos testes.

### Programa da aula:

1. O que é TDD e a importância de testes em Web3.
2. Fuzz Testing.
3. Cheatcodes.
4. Interpretação de resultados.

---

## 1. O que é TDD e a Importância de Testes em Web3

**Test-Driven Development (TDD)** é uma metodologia que prioriza a escrita de testes antes do desenvolvimento do código. Isso garante que cada nova funcionalidade seja validada, resultando em um código mais robusto e menos propenso a falhas. Em um ambiente como o Web3, onde contratos inteligentes lidam com ativos valiosos e são expostos a ataques, a necessidade de testes rigorosos se torna ainda mais crítica.

Os testes não apenas ajudam a validar a lógica do contrato, mas também garantem que ele se comporta como esperado sob diferentes condições, aumentando a confiança dos desenvolvedores e usuários.

---

## 2. Fuzz Testing

O **Fuzz Testing** é uma abordagem de teste que se concentra em gerar uma variedade de entradas aleatórias para um contrato, a fim de explorar cenários que poderiam causar falhas ou comportamentos inesperados. O Forge, ferramenta de teste do Foundry, suporta este tipo de teste de maneira eficaz.

### Exemplo de Fuzz Testing

Vamos examinar um contrato simples e como podemos transformar um teste unitário em um teste baseado em propriedades usando Fuzz Testing:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


import {Test} from "forge-std/Test.sol";

contract Safe {
    receive() external payable {}

    function withdraw() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}

contract SafeTest is Test {
    Safe safe;
    address alice;

    receive() external payable {}

    function setUp() public {
        safe = new Safe();
    }

    function test_Withdraw() public {
        payable(address(safe)).transfer(1 ether);
        uint256 preBalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(preBalance + 1 ether, postBalance);
    }

    function testFuzz_Withdraw(uint256 amount) public {
        vm.assume(amount > 0.1 ether && amount < 10000 ether);

        vm.deal(alice, amount);
        vm.prank(alice);
        payable(address(safe)).transfer(amount);
        uint256 preBalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(preBalance + amount, postBalance);
    }
}
```

### Resultados do Teste

Ao executar o teste, o Forge executa múltiplas iterações com valores diferentes para `amount`. Se um valor inválido for gerado (como um número maior que o saldo do contrato), o teste falhará, permitindo identificar problemas potenciais.

---

## 3. Cheatcodes

Os **cheatcodes** são funções especiais disponíveis no Foundry que permitem manipular o estado da Ethereum Virtual Machine (EVM) em tempo de execução. Eles são extremamente úteis durante os testes, permitindo simular diferentes cenários de forma fácil.

Alguns dos cheatcodes que você pode usar incluem:

- `vm.assume(condition)`: Descarta entradas que não satisfazem uma condição específica.
- `vm.prank(address)`: Simula uma chamada de função a partir de um endereço específico.
- `vm.deal(address, amount)`: Ajusta o saldo de um endereço.

### Exemplo de Uso de Cheatcodes

```javascript
function testFuzz_Withdraw(uint96 amount) public {
    vm.assume(amount > 0); // Descarta valores que não atendem à condição
    // ...
}
```

---

## 4. Interpretação de Resultados

Ao rodar testes fuzz, os resultados são apresentados de maneira um pouco diferente dos testes unitários:

- **"runs"**: Refere-se à quantidade de cenários que o fuzzer testou. Por padrão, o fuzzer gera 256 cenários.
- **"μ" (mu)**: Média do gás usado em todas as execuções do fuzzer.
- **"~" (tilde)**: Mediana do gás usado em todas as execuções do fuzzer.

### Configurando Execução de Testes Fuzz

Você pode configurar a execução de testes fuzz através de parâmetros que podem ser controlados pelo usuário. Isso inclui definir quantos cenários o fuzzer deve gerar ou ajustar os limites de valores aceitos.

---

## Conclusão

Nesta aula, aprendemos sobre **TDD** e a importância dos testes em **Web3**, além de explorar como realizar **Fuzz Testing** para identificar falhas em contratos inteligentes. Discutimos o uso de **cheatcodes** para manipular o ambiente de teste e a interpretação dos resultados para entender o comportamento do seu contrato.

---

## Lição de Casa

1. Crie um contrato e implemente um teste fuzz para garantir que as transferências de saldo funcionem conforme o esperado.
2. Use o `assume` para filtrar entradas indesejadas em seus testes fuzz.
3. Experimente com diferentes configurações de teste fuzz e interprete os resultados.
