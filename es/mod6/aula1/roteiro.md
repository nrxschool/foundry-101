
# **Clase 1: Migración de Hardhat a Foundry**  

## **1. Apertura**  

¡Bienvenido a la primera clase del **módulo avanzado**! Hoy aprenderemos cómo migrar un proyecto existente de **Hardhat** a **Foundry**.  

📌 **¿Por qué migrar de Hardhat a Foundry?**  
✅ **Mayor velocidad** en la ejecución de pruebas.  
✅ **Soporte nativo para Solidity** en pruebas y scripts.  
✅ **Entorno más ligero** sin necesidad de dependencias en Node.js.  

En esta clase, cubriremos los principales pasos para hacer la transición.  

📌 **Programa de la clase:**  
1. Crear un proyecto en Hardhat.  
2. Comparar con la estructura de Foundry.  
3. Migrar pruebas.  
4. Migrar scripts.  

¡Empecemos! 🚀  

---

## **2. Creando un Proyecto en Hardhat**  

Antes de migrar a Foundry, necesitamos entender la estructura de un proyecto en **Hardhat**.  

📌 **Requisitos**  
- Tener instalado [Node.js](https://nodejs.org/es/).  

### **Pasos para crear el proyecto en Hardhat**  

Ejecuta el siguiente comando:  

```bash
npx hardhat
```

Luego, selecciona **"Create a basic sample project"** y sigue las instrucciones.  

📌 **Estructura del proyecto Hardhat**  

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

📌 **¿Qué contiene cada carpeta?**  
- **contracts/** → Archivos Solidity.  
- **scripts/** → Scripts de despliegue en JavaScript/TypeScript.  
- **test/** → Pruebas con Mocha/Chai.  
- **hardhat.config.js** → Configuración de Hardhat.  

Ahora compararemos esta estructura con la de Foundry.  

---

## **3. Configurando Foundry en el Proyecto**  

### **Instalar Foundry**  

Si aún no tienes Foundry instalado, usa:  

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

📌 **Convertir el proyecto Hardhat en un proyecto Foundry**  

Podemos integrar Foundry en Hardhat antes de hacer la migración completa:  

```bash
npm install --save-dev @nomicfoundation/hardhat-foundry
```

Luego, edita `hardhat.config.js` y añade:  

```javascript
require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-foundry");

module.exports = {
  solidity: "0.8.27",
};
```

Después, ejecuta:  

```bash
npx hardhat init-foundry
```

✅ **Esto habilita Foundry en un proyecto Hardhat antes de migrar completamente.**  

---

## **4. Migrando Pruebas**  

📌 **Ejemplo de prueba en Hardhat (JavaScript):**  

```javascript
it("Should emit an event on withdrawals", async function () {
    const { lock, unlockTime, lockedAmount } = await loadFixture(deployOneYearLockFixture);

    await time.increaseTo(unlockTime);

    await expect(lock.withdraw())
      .to.emit(lock, "Withdrawal")
      .withArgs(lockedAmount, anyValue);
});
```

📌 **Prueba equivalente en Foundry (Solidity):**  

```solidity
function testEmitWithdrawalEvent() public {
    vm.warp(unlockTime + 1);
    vm.prank(alice);
    vm.expectEmit(address(lock));
    emit Lock.Withdrawal(1 ether, block.timestamp);
    lock.withdraw();
}
```

📌 **Diferencias clave:**  

| **Hardhat (JS)**         | **Foundry (Solidity)**  |
|--------------------------|------------------------|
| `.to.emit()` para eventos. | `vm.expectEmit()` para eventos. |
| `.withArgs()` para capturar valores. | Se deben especificar los valores esperados. |
| `time.increaseTo()` para cambiar el tiempo. | `vm.warp()` para fijar un timestamp. |

✅ **Las pruebas en Foundry son más rápidas y están mejor integradas con Solidity.**  

---

## **5. Migrando Scripts**  

📌 **Ejemplo de script de despliegue en Hardhat (JavaScript):**  

```javascript
async function main() {
  const Lock = await ethers.getContractFactory("Lock");
  const lock = await Lock.deploy(unlockTime);

  console.log("Lock deployed to:", lock.address);
}

main();
```

📌 **Versión en Foundry (Solidity):**  

```solidity
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

📌 **Diferencias clave:**  

| **Hardhat (JS)**          | **Foundry (Solidity)** |
|---------------------------|-----------------------|
| Usa JavaScript/TypeScript. | Usa Solidity nativamente. |
| `ethers.getContractFactory()` para instanciar contratos. | Se despliegan directamente en Solidity. |
| `console.log()` para imprimir direcciones. | No es necesario, Foundry genera logs automáticos. |

✅ **Los scripts en Foundry eliminan la dependencia de JavaScript.**  

---

## **6. Ejecutar Scripts y Pruebas**  

📌 **Ejecutar un script de despliegue**  

- **Hardhat**  

```bash
npx hardhat run scripts/deploy.js --network localhost
```

- **Foundry**  

```bash
forge script ignition/modules/Lock.s.sol:Deploy --broadcast --rpc-url http://localhost:8545
```

📌 **Ejecutar pruebas**  

- **Hardhat**  

```bash
npx hardhat test
```

- **Foundry**  

```bash
forge test
```

✅ **Foundry es más rápido y consume menos recursos.**  

---

## **7. Conclusión**  

📌 **Hoy aprendimos:**  
✔ **Cómo convertir un proyecto Hardhat en Foundry.**  
✔ **Cómo reescribir pruebas en Solidity usando Foundry.**  
✔ **Cómo migrar scripts de JavaScript a Solidity.**  
✔ **Cómo ejecutar pruebas y scripts en Foundry.**  

✅ **Con esta migración, obtendrás pruebas más rápidas y un flujo de trabajo optimizado.**  

---

## **8. Tarea para Casa**  

✏ **Ejercicio práctico:**  

1. **Crea un proyecto Hardhat** y migra a Foundry.  
2. **Convierte al menos una prueba y un script** de Hardhat a Foundry.  
3. **Ejecuta tus pruebas y scripts en Foundry** para verificar que funcionan correctamente.  

📌 **Guarda tus observaciones y compara el rendimiento entre Hardhat y Foundry.**  

---

## **9. Próxima Clase**  

📅 **En la próxima clase, exploraremos cómo almacenar claves privadas de forma segura con `Cast Wallet` para evitar exponerlas en scripts.**  

🚀 **¡Nos vemos allí!**  
