# **Clase 3: Forks Locales con Anvil**  

## **1. Apertura**  

¡Hola! Bienvenido a la **tercera clase del Módulo 3** del curso **Foundry 101**.  

Hoy exploraremos una de las funcionalidades más poderosas de **Anvil**: los **Forks Locales**. Aprenderemos cómo "copiar" el estado de una red real, como la **Mainnet** o una **testnet**, y usarlo localmente para probar contratos con datos reales.  

📌 **Lo que aprenderemos hoy:**  

1. **Qué es un fork local** y por qué utilizarlo.  
2. **Cómo configurar y ejecutar un fork** de una red real en **Anvil**.  
3. **Interactuar con contratos existentes en el fork**.  
4. **Probar nuevas implementaciones en un fork de red**.  

✅ **¡Vamos a ello!** 🚀  

---

## **2. Qué es un Fork Local y Por Qué Usarlo**  

### **¿Qué es un fork?**  

Un **fork local** es una copia exacta del estado de una blockchain real (como la **Mainnet** de Ethereum, **Goerli** o **Sepolia**). Con **Anvil**, puedes ejecutar esta copia en tu computadora y probar contratos o interacciones **sin pagar gas real**.  

📌 **Beneficios de usar forks locales:**  

✅ **Simular la Mainnet/Testnet localmente**: Puedes interactuar con contratos reales como si estuvieras en la red real.  
✅ **Probar cambios sin costos**: No gastas ETH real, lo que hace que las pruebas sean más económicas.  
✅ **Depuración avanzada**: Puedes inspeccionar estados anteriores y analizar el comportamiento de contratos reales.  

📌 **Ejemplo de uso:**  
- Probar una **swap en Uniswap** sin gastar dinero.  
- Simular interacciones con **Aave**, **Compound** u otros protocolos DeFi.  
- Desplegar y probar un contrato con datos reales antes de enviarlo a producción.  

---

## **3. Cómo Configurar y Ejecutar un Fork en Anvil**  

### **Paso 1: Ejecutar un Fork de una Red Real**  

Para hacer un fork local, necesitamos un **RPC URL** de un proveedor de blockchain (como **Infura**, **Alchemy** o **Ankr**).  

Ejemplo de fork de la **Mainnet** de Ethereum usando **Alchemy**:  

```bash
anvil --fork-url https://eth-mainnet.g.alchemy.com/v2/<API_KEY>
```

📌 **Explicación del comando:**  
- **`--fork-url`** → Indica la URL del RPC de la red a forkear.  
- **`<API_KEY>`** → Debes reemplazarlo con tu clave de API del proveedor de RPC.  

✅ Esto creará una copia local del estado de la **Mainnet**, permitiendo interactuar con contratos reales.  

### **Paso 2: Hacer Fork de una Testnet**  

Si queremos forkear **Sepolia**, el comando sería:  

```bash
anvil --fork-url https://eth-sepolia.g.alchemy.com/v2/<API_KEY>
```

📌 **Puedes forkear cualquier red EVM**, como **Optimism**, **Arbitrum**, **Polygon**, etc.  

---

## **4. Interactuar con Contratos Existentes en un Fork**  

Ahora que tenemos el fork en ejecución, podemos interactuar con **contratos que ya existen en la red real**.  

### **Paso 1: Usar Cast para Leer Datos de un Contrato**  

📌 **Ejemplo: Obtener el saldo de un usuario en Uniswap V2**  

```bash
cast call 0xUniswapV2ContractAddress "balanceOf(address)(uint256)" 0xYourAddress --rpc-url http://127.0.0.1:8545
```

✅ **Este comando consulta el saldo sin modificar la blockchain**.  

---

### **Paso 2: Modificar el Estado en el Fork**  

Podemos **simular transacciones** sin gastar ETH real.  

📌 **Ejemplo: Simular un swap en Uniswap**  

```bash
cast send 0xUniswapV2ContractAddress "swap(uint amount0Out, uint amount1Out, address to, bytes calldata data)" 100 0 0xYourAddress "0x" --rpc-url http://127.0.0.1:8545 --private-key <PRIVATE_KEY>
```

✅ **Esto ejecuta la transacción en el fork sin afectar la red real.**  

---

## **5. Probar Nuevas Implementaciones en un Fork**  

Una de las mejores características de los forks es que puedes **desplegar y probar nuevos contratos** en un entorno realista.  

### **Paso 1: Desplegar un Contrato en un Fork**  

📌 **Ejemplo: Desplegar un token ERC20 en la Mainnet forkeada**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "solmate/tokens/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("My Token", "MTK", 18) {
        _mint(msg.sender, initialSupply);
    }
}
```

### **Paso 2: Ejecutar el Despliegue**  

1. **Iniciar Anvil con el fork**  
2. **Ejecutar el script de despliegue**  

```bash
forge script script/DeployToken.s.sol --fork-url http://127.0.0.1:8545 --broadcast
```

✅ **Ahora el contrato está desplegado en tu fork local de la Mainnet.**  

📌 **Puedes interactuar con él usando Cast, pruebas unitarias o scripts.**  

---

## **6. Conclusión**  

Hoy aprendimos a:  
✔ **Crear forks locales de redes reales usando Anvil**.  
✔ **Interactuar con contratos ya desplegados en la blockchain real**.  
✔ **Probar nuevas implementaciones en un fork sin costos reales**.  

Esta técnica es extremadamente útil para simular escenarios reales y hacer pruebas sin riesgos.  

---

## **7. Recapitulación**  

📌 **Hoy vimos:**  
1. **Qué es un fork local y sus ventajas.**  
2. **Cómo ejecutar un fork con Anvil** usando `--fork-url`.  
3. **Cómo interactuar con contratos existentes** en la red forkeada.  
4. **Cómo desplegar y probar nuevos contratos en un fork local**.  

---

## **8. Tarea para casa**  

✏ **Ejercicio práctico:**  

1. **Haz un fork de la testnet Sepolia** y consulta el saldo de un contrato ERC20.  
2. **Despliega un nuevo contrato en el fork** y prueba sus funciones.  
3. **Modifica el estado de un contrato existente en el fork** y verifica los cambios.  

📌 **Toma notas de los resultados y experimenta lo máximo posible.**  

---

## **9. Próxima clase**  

📅 **En la próxima clase, aprenderemos a interactuar con contratos en la blockchain usando `Cast` y todo lo que hemos aprendido hasta ahora.**  

🚀 **¡Nos vemos allí!**  
