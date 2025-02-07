# **Clase 5: Depuración de Smart Contracts en Foundry**  

## **1. Apertura**  

¡Hola! Bienvenido a la **quinta clase del curso Foundry 101**.  

Hoy exploraremos un recurso extremadamente poderoso: **la depuración de smart contracts**.  

📌 **¿Por qué es importante la depuración?**  
✅ Ayuda a entender el comportamiento del contrato en la **EVM**.  
✅ Permite identificar **errores ocultos** que pueden no aparecer en las pruebas.  
✅ Proporciona herramientas para analizar **opcodes**, la **pila** y la **memoria** en tiempo de ejecución.  

📌 **En esta clase veremos:**  

1. **Qué son los opcodes, la pila y la memoria en la EVM**  
2. **Cómo acceder al depurador en Foundry**  
3. **Ejecutar `forge debug` con scripts y pruebas**  

---

## **2. Entendiendo Opcodes, Pila y Memoria en la EVM**  

📌 **¿Qué son los opcodes?**  

Los **opcodes** son las instrucciones de bajo nivel que la **EVM** usa para ejecutar contratos.  

Ejemplo de opcodes comunes:  
- **`PUSH`** → Agrega un valor a la pila.  
- **`MSTORE`** → Guarda un valor en la memoria.  
- **`CALL`** → Llama a otro contrato.  

📌 **¿Qué es la pila en la EVM?**  

- Es una estructura de datos **LIFO (Last In, First Out)**.  
- Cada operación en la EVM consume valores de la pila y puede agregar nuevos.  

📌 **¿Qué es la memoria en la EVM?**  

- Se usa para almacenar datos temporales.  
- Se borra después de cada transacción.  

📌 **Ejemplo de análisis de pila y memoria**  

Para entender mejor la ejecución de contratos, crearemos un contrato de **contador (`Counter`)** y lo depuraremos en Foundry.  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }
}
```  

---

## **3. Acceder al Depurador en Foundry**  

📌 **Ejecutar el depurador para un contrato específico**  

```bash
forge debug ./src/Counter.sol --sig "setNumber(uint256)" 8
```  

📌 **Salida esperada:**  

```
[DEBUG] Ejecutando Counter::setNumber(uint256)
Opcode: PUSH1 0x08
Stack: [0x00]
Memory: [0000000000000000000000000000000000000000000000000000000000000000]
```  

Podemos navegar por los opcodes y ver cómo se comporta el contrato en tiempo de ejecución.  

---

## **4. Ejecutar `forge debug` con Pruebas y Scripts**  

📌 **Depurar una prueba en Foundry**  

```bash
forge test --debug "testInitialSupply"
```  

📌 **Depurar un script en Foundry**  

```bash
forge script script/DeployToken.s.sol --debug
```  

---

## **5. Conclusión**  

📌 **Hoy aprendimos:**  

✔ **Qué son los opcodes y cómo afectan la ejecución de contratos.**  
✔ **Cómo funciona la pila y la memoria en la EVM.**  
✔ **Cómo usar `forge debug` para analizar contratos.**  
✔ **Depuración de pruebas y scripts con Foundry.**  

---

## **6. Recapitulación**  

📌 **Resumen de la clase:**  
1. **Fundamentos de la EVM: opcodes, pila y memoria.**  
2. **Uso de `forge debug` para inspeccionar contratos.**  
3. **Depuración de scripts y pruebas en Foundry.**  

---

## **7. Tarea para casa**  

✏ **Ejercicio práctico:**  

1. Escribe un contrato más complejo e intenta depurarlo con `forge debug`.  
2. Experimenta con diferentes operaciones en la pila y la memoria.  
3. Usa `forge debug` para analizar cómo se almacenan variables en la EVM.  

---

## **8. Próxima clase**  

📅 **En la próxima clase, exploraremos optimización de gas en Solidity y cómo reducir costos de transacción.**  

🚀 **¡Nos vemos allí!**  
