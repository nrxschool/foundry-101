# **Clase 3: Pruebas y Cobertura en Foundry**  

## **1. Apertura**  

¡Hola! Bienvenido a nuestra tercera clase del curso **Foundry 101**.  

Hoy nos adentraremos en uno de los aspectos más importantes del desarrollo de smart contracts: **las pruebas**.  

Sin pruebas, el riesgo de introducir errores críticos en contratos que no pueden modificarse es muy alto. **Foundry** nos proporciona herramientas avanzadas para asegurarnos de que nuestros contratos funcionan correctamente.  

📌 **En esta clase veremos:**  

1. **Cómo funcionan las pruebas en Foundry**  
2. **Configuración de pruebas con `Test.sol`**  
3. **Escribir pruebas avanzadas**  
4. **Cobertura de pruebas en Foundry**  

---

## **2. Cómo funcionan las pruebas en Foundry**  

En **Foundry**, las pruebas se escriben en archivos `.t.sol`, que son contratos Solidity diseñados para probar otros contratos.  

📌 **Beneficios:**  
✅ Se ejecutan en el mismo entorno que los contratos, sin necesidad de scripts en JavaScript o TypeScript.  
✅ Son rápidas y eficientes.  
✅ Tienen acceso a herramientas avanzadas como `vm`, `cheatcodes` y `fuzzing`.  

📌 **Estructura básica de una prueba:**  

1. **Las pruebas se guardan en la carpeta `test/`.**  
2. **Se usa la biblioteca `forge-std`** para funciones avanzadas.  
3. **Se hereda del contrato `Test.sol`** para facilitar las aserciones.  

Ejemplo de una prueba en Foundry:  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

contract TokenTest is Test {
    Token token;

    function setUp() public {
        token = new Token(1_000_000);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1_000_000 * 1e18);
    }
}
```  

📌 **Ejecutar las pruebas:**  

```bash
forge test
```  

📌 **Ejecutar pruebas con mayor detalle:**  

```bash
forge test -vvv
```  

---

## **3. Configuración de pruebas con `Test.sol`**  

El contrato **`Test.sol`** nos permite acceder a herramientas avanzadas para escribir pruebas de manera eficiente.  

📌 **Funciones clave de `Test.sol`:**  

- **`setUp()`** → Se ejecuta antes de cada prueba.  
- **`assertEq(a, b)`** → Verifica que `a == b`.  
- **`assertGt(a, b)`** → Verifica que `a > b`.  
- **`assertLt(a, b)`** → Verifica que `a < b`.  
- **`vm.roll(blockNumber)`** → Cambia el número de bloque.  
- **`vm.warp(timestamp)`** → Cambia la marca de tiempo.  

Ejemplo de prueba con manipulación del tiempo:  

```solidity
function testTimeTravel() public {
    uint256 start = block.timestamp;
    vm.warp(start + 100);
    assertEq(block.timestamp, start + 100);
}
```  

📌 **Ejecutar una prueba específica:**  

```bash
forge test --match-test testTimeTravel
```  

---

## **4. Escribir pruebas avanzadas**  

Ahora que entendemos los conceptos básicos, veamos cómo escribir pruebas más avanzadas.  

📌 **1. Simulación de diferentes usuarios**  

Podemos simular transacciones desde distintas cuentas con `vm.prank()`.  

```solidity
function testTransfer() public {
    address alice = address(0xAAA);
    address bob = address(0xBBB);

    vm.startPrank(alice);
    token.transfer(bob, 100 * 1e18);
    vm.stopPrank();

    assertEq(token.balanceOf(bob), 100 * 1e18);
}
```  

📌 **2. Verificar que una transacción falle**  

Si queremos asegurarnos de que una operación fallará, usamos `vm.expectRevert()`.  

```solidity
function testTransferFail() public {
    address alice = address(0xAAA);
    address bob = address(0xBBB);

    vm.startPrank(alice);
    vm.expectRevert();
    token.transfer(bob, 2_000_000 * 1e18);
    vm.stopPrank();
}
```  

📌 **Ejecutar una prueba específica con más detalles:**  

```bash
forge test -vvv --match-test testTransfer
```  

---

## **5. Cobertura de pruebas en Foundry**  

📌 **¿Qué es la cobertura de pruebas?**  

La cobertura mide cuántas líneas de código han sido ejecutadas durante las pruebas. Cuanto mayor sea la cobertura, más confiabilidad tendremos en nuestro contrato.  

📌 **Ejecutar un informe de cobertura:**  

```bash
forge coverage
```  

📌 **Ejemplo de salida de cobertura:**  

```bash
| Archivo          | % Líneas      | % Declaraciones | % Funciones    |
|-----------------|--------------|----------------|---------------|
| src/Token.sol   | 85.00% (17/20) | 90.00% (9/10)  | 80.00% (4/5)  |
| Total           | 85.00% (17/20) | 90.00% (9/10)  | 80.00% (4/5)  |
```  

📌 **Ejecutar cobertura para un contrato específico:**  

```bash
forge coverage --match-path test/Token.t.sol
```  

📌 **Aumentar la cobertura**  

Si la cobertura no es del 100%, debemos agregar pruebas para las funciones no verificadas.  

Ejemplo de prueba adicional para mejorar la cobertura:  

```solidity
function testTokenName() public {
    assertEq(token.name(), "My Token");
}

function testTokenSymbol() public {
    assertEq(token.symbol(), "TOKEN");
}
```  

📌 **Ejecutar cobertura nuevamente:**  

```bash
forge coverage
```  

✅ **¡Listo! Ahora nuestro contrato tiene una cobertura del 100%.**  

---

## **6. Conclusión**  

📌 **Hoy aprendimos:**  

✔ **Cómo funcionan las pruebas en Foundry** → Uso de archivos `.t.sol`.  
✔ **Configuración con `Test.sol`** → Aserciones, `setUp()` y `vm`.  
✔ **Escribir pruebas avanzadas** → Simulación de usuarios y fallos.  
✔ **Cómo verificar la cobertura de pruebas** → Uso de `forge coverage`.  

Las pruebas son una parte fundamental del desarrollo de smart contracts, y con **Foundry**, podemos hacerlas de manera rápida y eficiente.  

---

## **7. Recapitulación**  

📌 **Hoy vimos:**  
1. **Cómo funcionan las pruebas en Foundry.**  
2. **Uso de `Test.sol` y `vm` para manipular el entorno.**  
3. **Pruebas avanzadas, incluyendo errores esperados.**  
4. **Cobertura de pruebas con `forge coverage`.**  

---

## **8. Tarea para casa**  

✏ **Ejercicio práctico:**  

1. Escribe pruebas para tu contrato **Token**, verificando funciones como `approve` y `transferFrom`.  
2. Usa `vm.prank()` para simular múltiples usuarios en las pruebas.  
3. Genera un reporte de cobertura con `forge coverage`.  
4. Asegúrate de que la cobertura sea del 100%.  

---

## **9. Próxima clase**  

📅 **En la próxima clase, aprenderemos a escribir scripts de despliegue y automatizar el proceso de lanzamiento de smart contracts.**  

🚀 **¡Nos vemos allí!**  
