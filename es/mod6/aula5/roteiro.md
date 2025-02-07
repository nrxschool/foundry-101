# **Lección 5: Soporte para Vyper**  

## **Introducción**  

En esta lección, exploraremos **Vyper**, un lenguaje de programación para contratos inteligentes, y cómo configurarlo en **Foundry**. Aprenderemos a compilar contratos Vyper, escribir pruebas y scripts, e interactuar con los contratos.  

El objetivo es entender cómo usar Vyper junto con Foundry para desarrollar contratos inteligentes **seguros y eficientes**.  

### **📌 Contenido de la lección:**  
1️⃣ Introducción a Vyper y diferencias con Solidity.  
2️⃣ Configuración de Foundry para compilar Vyper.  
3️⃣ Escribir un contrato y pruebas en Vyper.  
4️⃣ Implementación e interacción con el contrato.  

---

## **1. Introducción a Vyper y Diferencias con Solidity**  

**Vyper** es un lenguaje de programación para contratos inteligentes que prioriza **simplicidad y seguridad**. A diferencia de **Solidity**, que ofrece más flexibilidad y funciones avanzadas, **Vyper adopta un enfoque más restringido** para reducir vulnerabilidades.  

### **🔹 Principales diferencias:**  
- **Sintaxis más sencilla** → Más intuitiva y legible.  
- **No permite sobrecarga de funciones** → Cada función debe tener un nombre único.  
- **Diseño enfocado en seguridad** → Reduce vulnerabilidades comunes en contratos.  

---

## **2. Configuración de Foundry para Compilar Vyper**  

Para usar Vyper en Foundry, primero debemos instalarlo. Hay varias formas de hacerlo, como **Docker** o **PIP**. A continuación, explicamos cómo configurarlo:  

### **📌 Instalación de Vyper**  

1️⃣ **Crear un entorno virtual en Python**  

```bash
python3 -m venv .venv
source .venv/bin/activate
```

2️⃣ **Instalar Vyper**  

```bash
pip3 install vyper
which vyper
```

### **📌 Configuración de Foundry**  

Agregar la configuración de Vyper en el archivo `foundry.toml`:  

```toml
[vyper]
path = "/ruta/a/vyper"
```

---

## **3. Escribiendo y Probando un Contrato en Vyper**  

### **📌 Contrato simple en Vyper (Sistema de Votación)**  

```python
#pragma version >0.4.0

voted: public(HashMap[address, bool])
candidate: public(HashMap[address, uint256])

@external
def vote(candidate: address) -> bool:
    assert not self.voted[msg.sender], "You have already voted."

    self.voted[msg.sender] = True
    self.candidate[candidate] += 1

    return True
```

---

### **📌 Pruebas del Contrato**  

Usaremos Solidity para escribir pruebas y desplegar el contrato.  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

contract VyperDeployer is Test {
    function deployContract(string memory fileName) public returns (address) {
        g[](2);
        cmds[0] = "vyper";
        cmds[1] = string.concat("src/", fileName, ".vy");

        bytes memory bytecode = vm.ffi(cmds);
        address deployedAddress;
        assembly {
            deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        require(deployedAddress != address(0), "VyperDeployer could not deploy contract");
        return deployedAddress;
    }
}
```

---

### **📌 Escribiendo las Pruebas**  

```solidity
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

## **4. Implementación e Interacción con el Contrato**  

### **📌 Implementar con `forge create`**  

```bash
forge create \
    ./src/Voting.vy:Voting \
    --account my-net
```

---

### **📌 Implementar con un Script de Foundry**  

```solidity
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

---

### **📌 Interactuando con el Contrato Usando `cast`**  

Ejecuta el siguiente comando para interactuar con el contrato:  

**Votar**  

```bash
cast send \
    0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35 \
    "vote(address)(bool)" 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720 \
    --account my-net
```

**Verificar el Voto**  

```bash
cast call 0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35 "voted(address)(bool)" 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720
cast call 0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35 "candidate(address)(uint256)" 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720
```

---

## **5. Conclusión**  

📌 **Hoy aprendimos:**  
✔ **Qué es Vyper y cómo se compara con Solidity.**  
✔ **Cómo configurar Foundry para compilar contratos en Vyper.**  
✔ **Cómo escribir y probar un contrato Vyper.**  
✔ **Cómo implementar e interactuar con un contrato Vyper usando Foundry.**  

✅ **¡Ahora puedes desarrollar y probar contratos en Vyper con Foundry!**  

---

## **6. Tarea**  

✏ **Ejercicios prácticos:**  
1️⃣ **Crea un contrato en Vyper que emita eventos y escribe pruebas para verificar su emisión.**  
2️⃣ **Usa `prank` para simular diferentes cuentas interactuando con el contrato.**  
3️⃣ **Implementa una función que falle y usa `expectRevert` en las pruebas para validar errores.**  

📌 **Experimenta con diferentes interacciones para mejorar tu comprensión.**  

---

## **7. Próxima Lección**  

📅 **En la próxima lección, exploraremos pruebas avanzadas en Foundry.**  

🚀 **¡Nos vemos allí!**  
