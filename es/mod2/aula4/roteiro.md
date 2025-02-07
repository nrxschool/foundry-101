# **Clase 4: Despliegue usando Scripts**  

## **1. Apertura**  

¡Hola! Bienvenido a nuestra cuarta clase del curso **Foundry 101**.  

Hoy exploraremos uno de los temas más poderosos en Foundry: **el despliegue de contratos usando scripts en Solidity**.  

📌 **¿Por qué usar scripts en Foundry?**  
✅ Permiten un **despliegue más organizado y programático**.  
✅ Facilitan la **automatización** de procesos.  
✅ Son más eficientes que los comandos manuales como `forge create`.  

📌 **En esta clase veremos:**  

1. **Cómo funcionan los scripts en Foundry**  
2. **Escribir scripts de despliegue simples**  
3. **Desplegar contratos on-chain**  
4. **Scripts avanzados on-chain**  

¡Comencemos! 🚀  

---

## **2. Cómo funcionan los scripts en Foundry**  

En Foundry, los **scripts se guardan en la carpeta `script/`** y tienen la extensión **`.s.sol`**.  

📌 **Ventaja sobre Hardhat**  
A diferencia de Hardhat, donde los scripts se escriben en JavaScript o TypeScript, en **Foundry los scripts se escriben en Solidity**, lo que permite ejecutarlos directamente en la **EVM**.  

📌 **Modos de ejecución de los scripts:**  

- **Ejecutar localmente** → Se simula en la EVM sin interactuar con la blockchain.  
- **Simulación on-chain** → Se prueba el resultado sin enviar transacciones.  
- **Ejecución on-chain (`--broadcast`)** → Envía las transacciones reales a la blockchain.  

---

## **3. Scripts de Despliegue Simples**  

📌 **Ejemplo básico de script**  

Creamos un archivo `script/TokenDeploy.s.sol`:  

```solidity
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

📌 **Explicación del script:**  
- **`Script.sol`** → Importamos la librería que permite ejecutar scripts en Foundry.  
- **`run()`** → Función principal del script.  
- **`vm.startBroadcast()`** → Inicia la firma de transacciones con la clave privada.  
- **`vm.stopBroadcast()`** → Finaliza la ejecución.  

---

### **Ejecutar el script localmente**  

Para ejecutar el script sin interactuar con la blockchain:  

```bash
forge script script/TokenDeploy.s.sol
```  

📌 **Salida esperada:**  

```
Script ran successfully.
Gas used: 487532
```  

Para simular el resultado en una red on-chain sin enviar transacciones:  

```bash
forge script \
    script/TokenDeploy.s.sol \
    --rpc-url http://127.0.0.1:8545
```  

📌 **Salida esperada:**  

```
SIMULATION COMPLETE. To broadcast these transactions, add --broadcast.
```  

---

## **4. Desplegar Contratos On-Chain**  

Para ejecutar el script en una blockchain real, usamos `--broadcast`:  

```bash
forge script \
    script/TokenDeploy.s.sol \
    --rpc-url http://127.0.0.1:8545 \
    --broadcast
```  

📌 **Salida esperada:**  

```
ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
Contract Address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
```  

El contrato **Token** ha sido desplegado en la blockchain.  

---

## **5. Scripts Avanzados On-Chain**  

Ahora agregaremos una función de **airdrop** que distribuirá tokens automáticamente a múltiples direcciones.  

📌 **Nuevo script con airdrop:**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract Deploy is Script {
    address[] public recipients;
    uint256 public amount = 100 * 1e18;

    function setUp() public {
        recipients = [
            0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f,
            0x70997970C51812dc3A010C7d01b50e0d17dc79C8,
            0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
        ];
    }

    function run() external {
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);

        Token token = new Token(1_000_000 * 1e18);

        for (uint256 i = 0; i < recipients.length; i++) {
            token.transfer(recipients[i], amount);
        }

        vm.stopBroadcast();
    }
}
```  

📌 **Explicación del script:**  
- **`setUp()`** → Define las direcciones que recibirán tokens.  
- **`run()`** → Crea el token y transfiere tokens a los destinatarios.  
- **Bucle `for`** → Itera sobre los destinatarios y envía tokens.  

📌 **Ejecutar el script con airdrop:**  

```bash
forge script script/TokenDeploy.s.sol --rpc-url http://127.0.0.1:8545 --broadcast
```  

📌 **Salida esperada:**  

```
Contract Address: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Tokens enviados a 3 destinatarios.
```  

✅ **¡Ahora el contrato se despliega y distribuye tokens automáticamente!**  

---

## **6. Conclusión**  

📌 **Hoy aprendimos:**  
✔ **Cómo funcionan los scripts en Foundry** → Uso de `.s.sol` en la carpeta `script/`.  
✔ **Escribir scripts básicos** → Implementación de `run()` y `vm.startBroadcast()`.  
✔ **Desplegar contratos on-chain** → Uso de `forge script --broadcast`.  
✔ **Automatizar tareas con scripts avanzados** → Airdrop de tokens a múltiples direcciones.  

Automatizar despliegues con scripts facilita el proceso y reduce errores en producción.  

---

## **7. Recapitulación**  

📌 **Resumen de la clase:**  
1. **Estructura de los scripts en Foundry.**  
2. **Ejecución local, simulación on-chain y despliegue real.**  
3. **Automatización del despliegue con airdrop.**  

---

## **8. Tarea para casa**  

✏ **Ejercicio práctico:**  

1. Optimiza el código del script usando un `for`.  
2. Despliega el contrato **Token** en una **testnet pública**.  
3. Modifica el script para incluir un **mecanismo de verificación de saldos** después del airdrop.  

---

## **9. Próxima clase**  

📅 **En la próxima clase, aprenderemos sobre debugging en Foundry y cómo usar herramientas avanzadas para detectar errores en contratos.**  

🚀 **¡Nos vemos allí!**  
