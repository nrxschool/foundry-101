# **Lección 6: Pruebas Avanzadas**  

## **1. Introducción**  

En esta lección, exploraremos **metodologías de prueba en el desarrollo de contratos inteligentes**, centrándonos en **Desarrollo Basado en Pruebas (TDD)** y la importancia de las pruebas en aplicaciones **Web3**.  

También aprenderemos sobre **Fuzz Testing**, una técnica poderosa para identificar comportamientos inesperados en los contratos. Además, veremos cómo utilizar **cheatcodes** y cómo interpretar los resultados de las pruebas.  

### **📌 Contenido de la lección:**  
1️⃣ ¿Qué es TDD y por qué es importante en Web3?  
2️⃣ Fuzz Testing.  
3️⃣ Uso de cheatcodes.  
4️⃣ Interpretación de resultados.  

---

## **2. ¿Qué es TDD y por qué es importante en Web3?**  

📌 **El Desarrollo Basado en Pruebas (TDD)** es una metodología que prioriza la **escritura de pruebas antes de desarrollar el código**. Esto garantiza que cada nueva funcionalidad sea validada, lo que resulta en un código **más robusto y confiable**.  

En Web3, donde los contratos inteligentes **gestionan activos valiosos y están expuestos a ataques**, las pruebas son **esenciales**.  

✅ **Beneficios de las pruebas en el desarrollo de contratos inteligentes:**  
- Aseguran que el **contrato funcione correctamente** en diferentes condiciones.  
- Previenen **vulnerabilidades de seguridad** y errores lógicos.  
- Aumentan la **confianza** de los desarrolladores y usuarios antes de desplegar un contrato.  

---

## **3. Fuzz Testing**  

📌 **¿Qué es Fuzz Testing?**  

El **Fuzz Testing** es una técnica en la que se generan **entradas aleatorias** para probar el comportamiento de un contrato inteligente. En lugar de escribir casos de prueba con valores fijos, Foundry nos permite **probar automáticamente múltiples valores dinámicos**.  

### **📌 Ejemplo: Implementando Fuzz Testing en Foundry**  

```solidity
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

📌 **¿Cómo funciona esto?**  
- **`test_Withdraw`** → Prueba con un valor fijo de 1 ether.  
- **`testFuzz_Withdraw`** → Genera **valores aleatorios** para `amount`.  
- **`vm.assume(amount > 0.1 ether && amount < 10000 ether);`** → Filtra valores no válidos.  

✅ **Ejecutar pruebas de fuzzing:**  

```bash
forge test --fuzz-runs 1000
```

✅ **Foundry ejecutará la prueba 1,000 veces con valores diferentes para encontrar posibles fallos.**  

---

## **4. Cheatcodes**  

📌 **¿Qué son los cheatcodes?**  

Los **cheatcodes** son comandos especiales en Foundry que permiten **manipular el estado de la EVM (Ethereum Virtual Machine) durante las pruebas**.  

📌 **Algunos cheatcodes comunes:**  
- **`vm.assume(condición);`** → Filtra entradas no deseadas.  
- **`vm.prank(dirección);`** → Simula una transacción desde una dirección específica.  
- **`vm.deal(dirección, cantidad);`** → Ajusta el saldo de una cuenta.  

### **📌 Ejemplo: Uso de Cheatcodes en Pruebas Fuzz**  

```solidity
function testFuzz_Withdraw(uint96 amount) public {
    vm.assume(amount > 0); // Ignorar valores no válidos
    // ...
}
```

✅ **Los cheatcodes facilitan la simulación de diferentes estados de la blockchain en pruebas.**  

---

## **5. Interpretación de Resultados de Fuzz Testing**  

📌 **Cómo leer los resultados de las pruebas de fuzzing:**  

- **"Runs"** → Número de veces que se ejecutó la prueba (por defecto: 256).  
- **"μ" (mu)** → Promedio de gas usado por ejecución.  
- **"~" (tilde)** → Mediana del gas usado en todas las ejecuciones.  

📌 **Ejemplo de salida:**  

```
[PASS] testFuzz_Withdraw(uint256) (runs: 256, μ: 21,000, ~: 20,500)
```

✅ **¿Qué significa esto?**  
- La prueba se ejecutó **256 veces** con entradas aleatorias.  
- El **costo promedio de gas** fue **21,000**.  
- El **costo mediano de gas** fue **20,500**.  

---

## **6. Configuración de Parámetros en Fuzz Testing**  

📌 **Podemos ajustar los parámetros de fuzz testing en Foundry:**  

- **Ejecutar más pruebas:**  

```bash
forge test --fuzz-runs 5000
```

- **Ajustar aleatoriedad y restricciones de entrada:**  

Modificar la lógica de la prueba usando `vm.assume()`.  

---

## **7. Conclusión**  

📌 **Hoy aprendimos:**  
✔ **Qué es el Desarrollo Basado en Pruebas (TDD) y por qué es clave en Web3.**  
✔ **Cómo usar Fuzz Testing para detectar comportamientos inesperados en contratos.**  
✔ **Cómo utilizar cheatcodes para manipular la blockchain en pruebas.**  
✔ **Cómo interpretar y configurar los resultados de fuzz testing.**  

✅ **Ahora puedes aplicar técnicas avanzadas de prueba para mejorar la seguridad y confiabilidad de tus contratos inteligentes.**  

---

## **8. Tarea**  

✏ **Ejercicios prácticos:**  
1️⃣ **Crea un contrato y escribe una prueba de fuzzing para transferencias de saldo.**  
2️⃣ **Usa `assume()` para filtrar entradas no deseadas en tus pruebas.**  
3️⃣ **Experimenta con diferentes configuraciones de fuzzing y analiza los resultados.**  

📌 **Aplica estos métodos para reforzar tus habilidades en pruebas de contratos inteligentes.**  

---

## **9. Próximos Pasos**  

🚀 **¡Felicidades! Has completado el curso Foundry 101.**  

🔹 **¿Qué sigue?**  
- Sigue practicando y mejorando tus habilidades de **pruebas de contratos inteligentes**.  
- Experimenta con **estrategias avanzadas de fuzzing** para detectar vulnerabilidades ocultas.  
- Mantente actualizado con las **nuevas características de Foundry**.  

🎉 **¡Ahora estás listo para construir y probar contratos inteligentes sólidos usando Foundry!**  
