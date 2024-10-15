# Aula 4: Cheetcodes e Lib Vm

## Abertura

Nesta aula, vamos abordar um dos aspectos mais poderosos do **Foundry**, a **lib Vm** e os **cheatcodes**. Essas ferramentas permitem manipular o comportamento da EVM durante os testes e facilitar a simulação de diferentes cenários, como revert calls, emissões de eventos e gerenciamento de contas. Vamos explorar como utilizar essas ferramentas para construir testes mais robustos e detalhados.

### Programa da aula:

1. O que são cheatcodes.
2. Assertions: `expectRevert`, `expectEmit`, `expectCall`.
3. Controle do ambiente: `prank`, `startPrank`, `deal`, `label`.

---

## 1. O que são Cheatcodes

Cheatcodes são funções especiais disponíveis no Foundry, acessíveis pela **lib Vm**. Elas permitem manipular o estado da Ethereum Virtual Machine (EVM) em tempo de execução, tornando os testes mais flexíveis e poderosos.

Com cheatcodes, você pode:

- Simular transações de diferentes contas.
- Forçar alterações no estado da blockchain.
- Ignorar limitações que normalmente precisariam de pré-configurações complexas.

A lib Vm é incluída em testes através do seguinte import:

```javascript
import { Vm } from "forge-std/Vm.sol";
```

---

## 2. Assertions: `expectRevert`, `expectEmit`, `expectCall`

### `expectRevert`

O cheatcode `expectRevert` permite que você simule e verifique quando uma função está destinada a falhar com um revert. Isso é útil para garantir que certas condições em contratos, como validações e permissões, estão sendo aplicadas corretamente.

```javascript
contract Reversible {

    error Unauthorized();
    error YouNotOwner(address account);

    function revertString() public {
        revert("Unauthorized");
    }
    function revertError() public {
        revert Unauthorized();
    }
    function revertErrorArgs() public {
        revert YouNotOwner(msg.sender);
    }
}

Reversible r = new Reversible();

vm.expectRevert("Unauthorized");
r.revertString();

vm.expectRevert(Reversible.Unauthorized.selector);
r.revertError();


bytes memory signature = abi.encodeWithSelector(Reversible.YouNotOwner.selector, address(this));
vm.expectRevert(signature);
r.revertErrorArgs();
```

Neste exemplo, o teste espera que a chamada à função `restrictedFunction()` falhe com a mensagem `"Unauthorized"`.

### `expectEmit`

O cheatcode `expectEmit` permite testar se eventos estão sendo emitidos conforme esperado. Isso é importante para garantir que as interações com o contrato estão sendo rastreadas corretamente através dos logs de eventos.

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

event Point(uint256 indexed x, uint256 indexed y, uint256 indexed z);
event Vector(uint256 indexed module);
event Called();

contract Cartesian {
    function makePoint(uint256 x, uint256 y, uint256 z) public {
        emit Point(x, y, z);
    }

    function makeVector(uint256 x, uint256 y, uint256 z) public {
        uint256 m = x ** 2 + y ** 2 + z ** 2;
        emit Vector(m);
    }

    function call() public {
        emit Called();
    }
}

contract CartesianB {
    function makeVector(uint256 x, uint256 y, uint256 z) public {
        uint256 m = x ** 2 + y ** 2 + z ** 2;
        emit Vector(m);
    }
}

contract CartesianTest is Test {
    Cartesian cartesian;
    CartesianB b;

    function setUp() public {
        cartesian = new Cartesian();
        b = new CartesianB();
    }

    function testEmitEventSimple() public {
        vm.expectEmit();
        emit Called();

        cartesian.call();
    }

    function testEmitEventTopics() public {
        vm.expectEmit(true, false, false, false);
        emit Point(1, 0, 0);

        cartesian.makePoint(1, 2, 3);
    }

    function testFailEmitEventEmmiter() public {
        vm.expectEmit(true, false, false, false, address(cartesian));
        emit Vector(14);

        b.makeVector(1, 2, 3);
   }
}
```

Os parâmetros indicam quais campos do evento estão sendo verificados.

### `expectCall`

O cheatcode `expectCall` permite testar se uma função externa está sendo chamada corretamente, verificando tanto o endereço do contrato quanto os argumentos da chamada.

```javascript
function testTransferCall() public {
    vm.prank(alice);
    vm.expectCall(
        address(token),
        abi.encodeCall(token.transfer, (bob, 10))
    );
    token.transfer(bob, 10);
}
```

---

## 3. Controle do Ambiente: `prank`, `startPrank`, `deal`, `label`

### `prank`

O cheatcode `prank` simula uma transação sendo enviada de um endereço diferente do padrão `msg.sender`. Isso é útil para testar cenários onde diferentes usuários interagem com o contrato.

```javascript
vm.prank(address(0xbeef));
contract.someFunction();
```

Aqui, `someFunction()` será chamada como se o `msg.sender` fosse `0xBEEF`.

### `startPrank` e `stopPrank`

Diferente do `prank`, que afeta apenas a próxima transação, `startPrank` altera o `msg.sender` para todas as transações subsequentes até que `stopPrank` seja chamado.

```javascript
vm.startPrank(address(0xbeef));
contract.someFunction();
contract.anotherFunction();
vm.stopPrank();
```

Isso permite simular múltiplas interações a partir do mesmo endereço.

### `deal`

O cheatcode `deal` permite ajustar o saldo de um endereço diretamente. Isso é útil para configurar cenários de testes onde as contas precisam de um saldo específico.

```javascript
vm.deal(address(0xBEEF), 10 ether);
```

Isso define o saldo de `0xBEEF` como `10 ether`.

### `label`

O cheatcode `label` permite atribuir nomes aos endereços, o que facilita a leitura dos logs de teste. Útil para identificar rapidamente diferentes contas nos resultados dos testes.

```javascript
vm.label(address(0xbeef), "Bob");
```

A partir de agora, o endereço `0xBEEF` será exibido como `"Bob"` nos logs de teste.

---

## Conclusão

Nesta aula, vimos como usar os **cheatcodes** e a **lib Vm** para manipular o ambiente de execução e realizar testes mais precisos. Exploramos o uso de asserts como `expectRevert` e `expectEmit` para garantir a integridade das funções e eventos, e como `prank`, `deal` e `label` podem simular interações e estados diversos. Essas ferramentas são essenciais para criar testes mais eficientes e detalhados.

---

## Lição de casa

1. Use o `expectRevert` para verificar se uma função está falhando como esperado ao passar um valor inválido.
2. Use o `prank` para simular múltiplas contas interagindo com seu contrato.
3. Defina um saldo específico para uma conta e simule uma transação usando `deal`.

---

## Próxima Aula

Na próxima aula, vamos explorar como testar contratos Solidity usando o compilador **Vyper** no **Foundry**. Até lá!
