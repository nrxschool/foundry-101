# **Clase 4: Optimización de Gas en Solidity**  

## **1. Apertura**  

¡Bienvenido a la **cuarta clase del Módulo 6**! Hoy exploraremos **cómo reducir los costos de gas en Solidity** utilizando **Foundry** para optimizar contratos inteligentes.  

📌 **¿Por qué optimizar el gas?**  
✅ Reduce costos de transacción para los usuarios.  
✅ Hace que los contratos sean más eficientes.  
✅ Evita desperdicio de recursos en la red.  

📌 **Lo que veremos hoy:**  
1. **Cómo Foundry ayuda en la optimización de gas.**  
2. **Buenas prácticas para escribir contratos eficientes.**  
3. **Herramientas para analizar consumo de gas en Foundry.**  
4. **Ejemplos prácticos de optimización.**  

✅ **¡Vamos a ello!** 🚀  

---

## **2. Cómo Foundry Ayuda en la Optimización de Gas**  

📌 **Foundry tiene herramientas nativas para medir el consumo de gas**.  

### **Ejecutar pruebas de gas en Foundry**  

Podemos analizar cuánto gas consume una función con:  

```bash
forge test --gas-report
```

✅ **Salida esperada:**  

```
| Function | Min | Avg | Max | # Calls |
|----------|------|------|------|--------|
| transfer | 20000 | 25000 | 28000 | 10 |
| mint     | 50000 | 55000 | 60000 | 5  |
```

📌 **Esto nos muestra el costo de cada función en gas.**  

---

## **3. Buenas Prácticas para Reducir Gas**  

### **1️⃣ Usar `calldata` en Lugar de `memory` en Parámetros**  

📌 **Evita copiar datos innecesarios en memoria.**  

❌ **Menos eficiente (usa `memory`)**  

```solidity
function setName(string memory _name) public {
    name = _name;
}
```

✅ **Más eficiente (usa `calldata`)**  

```solidity
function setName(string calldata _name) public {
    name = _name;
}
```

📌 **`calldata` es más barato porque evita copias en memoria.**  

---

### **2️⃣ Usar `uint256` en Lugar de `uint8`, `uint16`, etc.**  

📌 **Los tipos pequeños pueden ser menos eficientes debido a padding de la EVM.**  

❌ **Menos eficiente**  

```solidity
uint8 x = 255;
uint8 y = 100;
```

✅ **Más eficiente**  

```solidity
uint256 x = 255;
uint256 y = 100;
```

📌 **Usar `uint256` es mejor en la mayoría de los casos porque la EVM maneja datos en palabras de 32 bytes.**  

---

### **3️⃣ Evitar `for` y `while` con Altos Costos de Gas**  

📌 **Los bucles pueden hacer que las transacciones sean muy costosas.**  

❌ **Menos eficiente (usa `for`)**  

```solidity
function sumArray(uint256[] memory arr) public pure returns (uint256) {
    uint256 total = 0;
    for (uint256 i = 0; i < arr.length; i++) {
        total += arr[i];
    }
    return total;
}
```

✅ **Más eficiente (usa `unchecked` para ahorrar gas)**  

```solidity
function sumArray(uint256[] memory arr) public pure returns (uint256 total) {
    unchecked {
        for (uint256 i = 0; i < arr.length; i++) {
            total += arr[i];
        }
    }
}
```

📌 **`unchecked` evita verificaciones innecesarias de desbordamiento en Solidity 0.8+.**  

---

### **4️⃣ Optimizar Almacenamiento en la Blockchain**  

📌 **Reducir escrituras en `storage` disminuye el costo de gas.**  

❌ **Menos eficiente (múltiples escrituras en `storage`)**  

```solidity
function increment() public {
    count += 1;
    count += 1;
}
```

✅ **Más eficiente (una sola escritura en `storage`)**  

```solidity
function increment() public {
    uint256 newCount = count + 2;
    count = newCount;
}
```

📌 **Cada escritura en `storage` cuesta más gas que una variable en `memory`.**  

---

## **4. Herramientas para Analizar Gas en Foundry**  

📌 **Usar `forge snapshot` para comparar optimizaciones de gas.**  

```bash
forge snapshot
```

✅ **Muestra el gas consumido antes y después de un cambio.**  

📌 **Habilitar informes de gas detallados en `foundry.toml`**  

```toml
[profile.default]
gas_reports = ["*"]
```

✅ **Esto genera reportes de gas automáticamente después de cada prueba.**  

---

## **5. Ejemplo Práctico de Optimización**  

📌 **Código original (costoso en gas)**  

```solidity
contract GasInefficient {
    uint256 public count;

    function increment() public {
        count += 1;
    }

    function reset() public {
        count = 0;
    }
}
```

📌 **Código optimizado (menor consumo de gas)**  

```solidity
contract GasEfficient {
    uint256 public count;

    function increment() public {
        unchecked {
            count += 1;
        }
    }

    function reset() public {
        assembly {
            sstore(count.slot, 0)
        }
    }
}
```

📌 **Diferencias clave:**  
- ✅ `unchecked {}` para evitar verificaciones de desbordamiento innecesarias.  
- ✅ `sstore(count.slot, 0)` usa **Yul (assembly)** para minimizar costos de gas en `storage`.  

✅ **¡Estos cambios pueden reducir el costo de gas hasta en un 30%!**  

---

## **6. Conclusión**  

📌 **Hoy aprendimos:**  
✔ **Cómo Foundry ayuda a analizar y reducir el consumo de gas.**  
✔ **Mejores prácticas para escribir contratos eficientes.**  
✔ **Cómo usar `forge snapshot` y `forge test --gas-report` para medir gas.**  
✔ **Ejemplo práctico de optimización en Solidity.**  

✅ **Optimizar el gas no solo ahorra costos, sino que también mejora la escalabilidad de los contratos.**  

---

## **7. Recapitulación**  

📌 **Resumen de la clase:**  
1. **Uso de herramientas de Foundry** → `forge test --gas-report`, `forge snapshot`.  
2. **Buenas prácticas** → `calldata`, `unchecked`, `storage`.  
3. **Análisis de consumo de gas** → Reportes detallados.  
4. **Ejemplo práctico** → Código optimizado con menor costo de gas.  

---

## **8. Tarea para Casa**  

✏ **Ejercicio práctico:**  

1. **Escribe dos versiones de un contrato** (una sin optimización y otra optimizada).  
2. **Ejecuta `forge test --gas-report`** y compara los costos de gas.  
3. **Modifica variables de `memory` a `calldata` y mide el impacto en gas.**  
4. **Prueba `unchecked` en loops y funciones matemáticas.**  

📌 **Anota los resultados y comparte tus optimizaciones.**  

---

## **9. Próxima Clase**  

📅 **En la próxima clase, aprenderemos sobre Meta-Transacciones y cómo permitir a los usuarios interactuar con contratos sin pagar gas.**  

🚀 **¡Nos vemos allí!**  
