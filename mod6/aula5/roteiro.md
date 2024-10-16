# Aula 5: Suporte ao Vyper

## Abertura

Nesta aula, vamos explorar o **Vyper**, uma linguagem de programação para contratos inteligentes, e como configurá-lo no **Foundry**. Vamos aprender a compilar contratos Vyper, escrever testes e scripts, além de interagir com os contratos. O objetivo é entender como o Vyper pode ser utilizado em conjunto com o Foundry para desenvolver contratos inteligentes seguros e eficientes.

### Programa da aula:

1. Apresentando o Vyper e suas diferenças em relação ao Solidity.
2. Configurando o Foundry para compilar Vyper.
3. Escrevendo um contrato simples e testes em Vyper.
4. Escrevendo um script em Vyper e interagindo com o contrato.

---

## 1. Apresentando o Vyper e Comparando com Solidity

O Vyper é uma linguagem de programação para contratos inteligentes que prioriza a simplicidade e a segurança. Ao contrário do Solidity, que possui uma sintaxe mais flexível e recursos mais complexos, o Vyper se concentra em uma abordagem mais restrita, o que pode levar a um código mais seguro.

### Principais Diferenças:

- **Sintaxe mais simples**: O Vyper tem uma sintaxe mais intuitiva e legível.
- **Sem suporte a sobrecarga de funções**: Cada função deve ter um nome único.
- **Foco em segurança**: O design do Vyper é voltado para evitar vulnerabilidades comuns.

---

## 2. Configurando o Foundry para Compilar Vyper

Para usar o Vyper no Foundry, primeiro precisamos instalá-lo. Existem várias maneiras de fazer isso, incluindo Docker e PIP. Abaixo estão as instruções para configurá-lo:

### Instalação do Vyper:

1. **Crie um ambiente Python**:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

2. **Instale o Vyper**:

```bash
pip3 install vyper
which vyper
```

### Configurando o Foundry:

Adicione a configuração do Vyper no arquivo `foundry.toml`:

```toml
[vyper]
path = "/path/to/vyper"
```

---

## 3. Testando nosso contrato em Vyper

### Contrato Vyper Simples (Voting):

```python
#pragma version >0.3.0

voted: public(HashMap[address, bool])
candidate: public(HashMap[address, uint256])

@external
def vote(candidate: address) -> bool:
    assert not self.voted[msg.sender], "You have already voted."

    self.voted[msg.sender] = True
    self.candidate[candidate] += 1

    return True
```

### Testando o Contrato:

Usaremos Solidity para escrever os testes, e um deployer.

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

contract VyperDeployer is Test {
    ///@notice Compiles a Vyper contract and returns the address that the contract was deployeod to
    ///@notice If deployment fails, an error will be thrown
    ///@param fileName - The file name of the Vyper contract. For example, the file name for "SimpleStore.vy" is "SimpleStore"
    ///@return deployedAddress - The address that the contract was deployed to
    function deployContract(string memory fileName) public returns (address) {
        ///@notice create a list of strings with the commands necessary to compile Vyper contracts
        string[] memory cmds = new string[](2);
        cmds[0] = "vyper";
        cmds[1] = string.concat("src/", fileName, ".vy");

        ///@notice compile the Vyper contract and return the bytecode
        bytes memory bytecode = vm.ffi(cmds);

        ///@notice deploy the bytecode with the create instruction
        address deployedAddress;
        assembly {
            deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        ///@notice check that the deployment was successful
        require(deployedAddress != address(0), "VyperDeployer could not deploy contract");

        ///@notice return the address that the contract was deployed to
        return deployedAddress;
    }

    ///@notice Compiles a Vyper contract with constructor arguments and returns the address that the contract was deployeod to
    ///@notice If deployment fails, an error will be thrown
    ///@param fileName - The file name of the Vyper contract. For example, the file name for "SimpleStore.vy" is "SimpleStore"
    ///@return deployedAddress - The address that the contract was deployed to
    function deployContract(string memory fileName, bytes calldata args) public returns (address) {
        ///@notice create a list of strings with the commands necessary to compile Vyper contracts
        string[] memory cmds = new string[](2);
        cmds[0] = "vyper";
        cmds[1] = string.concat("src/", fileName, ".vy");

        ///@notice compile the Vyper contract and return the bytecode
        bytes memory _bytecode = vm.ffi(cmds);

        //add args to the deployment bytecode
        bytes memory bytecode = abi.encodePacked(_bytecode, args);

        ///@notice deploy the bytecode with the create instruction
        address deployedAddress;
        assembly {
            deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        ///@notice check that the deployment was successful
        require(deployedAddress != address(0), "VyperDeployer could not deploy contract");

        ///@notice return the address that the contract was deployed to
        return deployedAddress;
    }
}
```

Vamos escrever os testes agora:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {VyperDeployer} from "./VyperDeploy.sol";

interface IVoting {
    function vote(address) external returns (bool);

    function voted(address) external returns (bool);

    function candidate(address) external returns (uint256);
}

contract VotingTest is VyperDeployer {
    VyperDeployer deployer;
    IVoting voting;
    address alice = address(0xaAaAaAaaAaAaAaaAaAAAAAAAAaaaAaAaAaaAaaAa);
    address bob = address(0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB);

    function setUp() public {
        deployer = new VyperDeployer();
        voting = IVoting(deployer.deployContract("Voting"));
    }

    function testVote() public {
        vm.prank(alice);
        voting.vote(alice);

        assertEq(voting.candidate(alice), 1);
        assertEq(voting.voted(alice), true);
    }

    function testVoteTwice() public {
        voting.vote(alice);

        vm.expectRevert("You have already voted.");
        voting.vote(alice);
    }
}
```

---

## 4. Deploy do nosso contrato em Vyper

### Deploy com `forge create`

```bash
forge create \
    ./src/Voting.vy:Voting \
    --account my-net
```

### Deploy com `Script`:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "forge-std/console2.sol";
import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "../test/vyper/VyperDeploy.sol";

interface IVoting {
    function candidate(address) external returns (uint256);
    function voted(address) external returns (bool);
    function vote(address) external returns (bool);
}

contract Deploy is Script {
    VyperDeployer deployer;
    IVoting voting;

    function setUp() public {
        deployer = new VyperDeployer();
        voting = IVoting(deployer.deployContract("Voting"));
    }

    function run() external {
        vm.startBroadcast();

        vm.stopBroadcast();
    }
}
```

### Interagindo com o contrato com `cast`:

Use o seguinte comando para rodar o script e interagir com o contrato:

**Votar**

```bash
cast send \
    0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35 \
    "vote(address)(bool)" 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720 \
    --account my-net
```

**Verificar voto**

```bash
cast call 0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35 "voted(address)(bool)" 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720
cast call 0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35 "candidate(address)(uint256)" 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720
```

---

## Conclusão

Nesta aula, aprendemos sobre o **Vyper** e sua integração com o **Foundry**. Exploramos a configuração do ambiente, a escrita de contratos simples e testes, além de scripts em Vyper para interagir com contratos. Essas habilidades são essenciais para desenvolver contratos inteligentes de forma segura e eficiente.

---

## Lição de casa

1. Crie um contrato Vyper que utilize eventos e escreva testes para garantir que esses eventos são emitidos corretamente.
2. Utilize o `prank` para simular diferentes contas interagindo com o contrato que você criou.
3. Tente implementar uma função que falhe e utilize `expectRevert` em seus testes para validar as falhas.

---

## Próxima Aula

Na próxima aula, vamos explorar como criar Testes Avançados. Até lá!
