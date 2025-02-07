# **Clase 6: Seguridad Avanzada en Solidity**  

## **1. Apertura**  

¡Bienvenido a la **última clase del Módulo 6**! Hoy aprenderemos sobre **seguridad avanzada en Solidity** y cómo proteger contratos inteligentes contra ataques.  

📌 **¿Por qué es importante la seguridad en Solidity?**  
✅ Los contratos en blockchain son **inmutables** y no pueden corregirse después del despliegue.  
✅ Los errores pueden causar **pérdidas millonarias** en protocolos DeFi.  
✅ Las vulnerabilidades pueden ser **explotadas por hackers**.  

📌 **Lo que veremos hoy:**  
1. **Principales vulnerabilidades en Solidity y cómo prevenirlas.**  
2. **Herramientas para auditar contratos con Foundry.**  
3. **Ejemplo práctico de un ataque y su solución.**  

✅ **¡Vamos a ello!** 🚀  

---

## **2. Principales Vulnerabilidades en Solidity**  

Aquí están algunas de las vulnerabilidades más comunes en contratos inteligentes:  

---

### **1️⃣ Reentrancy Attack (Ataque de Reentrada)**  

📌 **¿Cómo funciona?**  
Un atacante explota un contrato llamando repetidamente una función **antes de que el estado se actualice**, permitiéndole retirar más fondos de lo permitido.  

📌 **Código vulnerable:**  

```solidity
contract ReentrancyVulnerable {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "Saldo insuficiente");
        (bool success, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(success, "Fallo en la transferencia");

        balances[msg.sender] = 0; // ❌ ¡Esto ocurre después de enviar ETH!
    }
}
```

📌 **Cómo se explota:**  
Un contrato malicioso puede llamar a `withdraw()` y, antes de que `balances[msg.sender] = 0;` se ejecute, **llamar nuevamente a `withdraw()`** y retirar más fondos.  

✅ **Solución: Usar el patrón "Checks-Effects-Interactions"**  

```solidity
contract ReentrancyFixed {
    mapping(address => uint256) public balances;

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Saldo insuficiente");

        balances[msg.sender] = 0; // ✅ Primero actualizamos el estado

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Fallo en la transferencia");
    }
}
```

📌 **Aquí actualizamos `balances[msg.sender] = 0;` antes de la transferencia.**  

✅ **También podemos usar el modificador `nonReentrant` de OpenZeppelin.**  

```solidity
import "openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";

contract SecureContract is ReentrancyGuard {
    function withdraw() public nonReentrant {
        // Código seguro
    }
}
```

---

### **2️⃣ Integer Overflow & Underflow**  

📌 **Antes de Solidity 0.8, los enteros podían desbordarse o subdesbordarse.**  

❌ **Código vulnerable en Solidity <0.8.0:**  

```solidity
function decrement() public {
    count -= 1; // ⚠️ Si `count == 0`, esto causará un underflow.
}
```

✅ **Solución: Usar `unchecked` para control manual o Solidity 0.8+**  

```solidity
function decrement() public {
    unchecked {
        count -= 1;
    }
}
```

✅ **Desde Solidity 0.8+, los overflows generan un error automáticamente.**  

---

### **3️⃣ Frontrunning y MEV (Maximal Extractable Value)**  

📌 **Problema:**  
- Si envías una transacción con una oferta, un bot puede copiarla y pagar más gas para ejecutarla antes.  
- Esto ocurre en subastas y trading DeFi.  

📌 **Ejemplo vulnerable:**  

```solidity
function placeBid() public payable {
    require(msg.value > highestBid, "Oferta demasiado baja");
    highestBid = msg.value;
    highestBidder = msg.sender;
}
```

📌 **Solución:**  
1. **Usar un sistema de ofertas encriptadas** (Commit-Reveal).  
2. **Usar un mecanismo tipo "Dutch Auction"**.  
3. **Incluir un retraso en la revelación de la oferta.**  

---

### **4️⃣ Manipulación de Precios con Oráculos**  

📌 **Problema:**  
Si un contrato depende del precio de un oráculo inseguro, un atacante puede manipular el precio y aprovecharse.  

📌 **Ejemplo vulnerable:**  

```solidity
contract VulnerableOracle {
    function getPrice() public view returns (uint256) {
        return priceFeed.getLatestPrice(); // ⚠️ Si el oráculo es manipulable, el precio cambia.
    }
}
```

✅ **Solución:**  
Usar **oráculos descentralizados** como **Chainlink** para evitar manipulación.  

```solidity
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract SecureOracle {
    AggregatorV3Interface internal priceFeed;

    constructor(address _priceFeed) {
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function getPrice() public view returns (uint256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price);
    }
}
```

✅ **Esto garantiza que el precio provenga de múltiples fuentes y no pueda ser manipulado.**  

---

## **3. Herramientas para Auditar Contratos con Foundry**  

📌 **1️⃣ `forge test --gas-report`** → Detecta funciones costosas en gas.  

```bash
forge test --gas-report
```

📌 **2️⃣ `slither`** → Análisis estático de seguridad.  

```bash
slither .
```

📌 **3️⃣ `echidna`** → Fuzz testing para Solidity.  

```bash
echidna-test .
```

📌 **4️⃣ `mythril`** → Escaneo de vulnerabilidades en contratos.  

```bash
myth analyze contract.sol
```

✅ **Estas herramientas ayudan a encontrar vulnerabilidades antes del despliegue.**  

---

## **4. Ejemplo Práctico de un Ataque y su Solución**  

📌 **Contrato vulnerable a reentrada:**  

```solidity
contract Vault {
    mapping(address => uint256) public balances;

    function withdraw() public {
        require(balances[msg.sender] > 0, "Sin fondos");

        (bool success, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(success, "Fallo en la transferencia");

        balances[msg.sender] = 0; // ❌ ¡Actualización tardía!
    }
}
```

📌 **Exploit en Solidity:**  

```solidity
contract Attack {
    Vault public vault;

    constructor(address _vault) {
        vault = Vault(_vault);
    }

    receive() external payable {
        if (address(vault).balance >= 1 ether) {
            vault.withdraw();
        }
    }

    function attack() public payable {
        vault.withdraw();
    }
}
```

📌 **Solución:**  
- **Usar `ReentrancyGuard` de OpenZeppelin.**  
- **Aplicar el patrón "Checks-Effects-Interactions".**  

✅ **Con estos cambios, el ataque se vuelve imposible.**  

---

## **5. Conclusión**  

📌 **Hoy aprendimos:**  
✔ **Cómo prevenir ataques de reentrada.**  
✔ **Cómo evitar overflows, frontrunning y manipulación de precios.**  
✔ **Qué herramientas usar para auditar contratos.**  
✔ **Cómo aplicar seguridad avanzada en Solidity.**  

✅ **Con estas estrategias, puedes escribir contratos más seguros y resistentes a ataques.**  

---

## **6. Próxima Etapa**  

🎉 **¡Felicidades! Has completado el curso Foundry 101.**  

📌 **Lo que puedes hacer ahora:**  
✅ **Explorar proyectos DeFi y NFTs con Foundry.**  
✅ **Contribuir a repositorios de código abierto en Solidity.**  
✅ **Seguir mejorando en seguridad y optimización de contratos.**  

🚀 **¡Nos vemos en la blockchain!**  
