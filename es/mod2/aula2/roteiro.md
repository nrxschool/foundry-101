# **Clase 2: Estructura del Framework, Instalación de Dependencias y Creación de un Token**  

## **1. Apertura**  

¡Hola! Bienvenido a nuestra segunda clase del curso **Foundry 101**.  

Hoy daremos un paso más en el desarrollo con **Foundry**. Aprenderemos a:  

### **Programación**  

1. **Estructura básica de un proyecto**  
2. **Instalar dependencias externas**  
3. **Crear un token ERC20 usando la biblioteca Solady**  
4. **Desplegar e interactuar con nuestro token**  

Al final de esta clase, tendrás una visión completa de cómo estructurar tu proyecto, instalar bibliotecas externas y usar estas dependencias para crear contratos eficientes.  

---

## **2. Estructura Básica del Framework**  

Cuando inicias un nuevo proyecto con **Foundry**, este genera automáticamente una estructura organizada. Veamos qué representa cada directorio y archivo.  

Después de ejecutar `forge init mi-proyecto`, la estructura será la siguiente:  

```
mi-proyecto/
├── lib/
├── src/
│   └── Contract.sol
├── test/
├── script/
└── foundry.toml
```  

📌 **Explicación de cada carpeta:**  

- **`lib/`** → Almacena dependencias externas instaladas.  
- **`src/`** → Contiene los contratos principales del proyecto.  
- **`test/`** → Carpeta donde escribimos pruebas unitarias para los contratos.  
- **`script/`** → Scripts de despliegue e interacción con contratos.  
- **`foundry.toml`** → Archivo de configuración del proyecto.  

El objetivo de esta estructura es organizar el desarrollo y facilitar la escalabilidad del proyecto.  

---

## **3. Instalación de Dependencias Externas**  

Una de las grandes ventajas de **Foundry** es la facilidad para instalar y usar bibliotecas externas.  

Hoy instalaremos **Solady**, una biblioteca que optimiza la implementación de contratos en Solidity.  

📌 **Para instalar una dependencia en Foundry, usamos:**  

```bash
forge install Vectorized/solady
```  

Esto descargará la biblioteca **Solady** y la almacenará en la carpeta `lib/`. Ahora podremos acceder a sus contratos e integrarlos en nuestro código.  

Ahora que tenemos **Solady** instalada, usémosla para crear un **Token ERC20**.  

---

## **4. Creación de un Token ERC20 con Solady**  

Vamos a crear nuestro primer **token ERC20** con la biblioteca **Solady**, que ofrece implementaciones más eficientes en consumo de gas.  

📌 **Abre el archivo `src/Token.sol` y escribe el siguiente código:**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "solady/tokens/ERC20.sol";

contract Token is ERC20 {
    constructor(uint256 amount) {
        _mint(msg.sender, amount * 1e18);
    }

    function name() public pure override returns (string memory) {
        return "My Token";
    }

    function symbol() public pure override returns (string memory) {
        return "TOKEN";
    }
}
```  

📌 **Explicación del código:**  

- **Hereda de ERC20** → Usamos la implementación optimizada de **Solady**.  
- **Constructor** → Define la cantidad inicial de tokens y los asigna al creador del contrato.  
- **`name()` y `symbol()`** → Devuelven el nombre y el símbolo del token.  

Con este código, ya tenemos un **token ERC20 funcional y optimizado**. Ahora, vamos a desplegarlo y probarlo.  

---

## **5. Despliegue del Token y Pruebas de Interacción**  

Ahora que nuestro token está listo, lo desplegaremos en nuestra blockchain local con **Anvil** y lo probaremos con **Cast**.  

### **Paso 1: Compilar el contrato**  

Ejecuta el siguiente comando en la terminal:  

```bash
forge build
```  

Si todo está bien, el contrato se compilará sin errores.  

---

### **Paso 2: Iniciar Anvil**  

Ejecutemos **Anvil**, que simulará una blockchain local para nuestras pruebas:  

```bash
anvil -b 2
```  

📌 **Anvil generará cuentas con saldo en ETH para firmar transacciones.**  

---

### **Paso 3: Desplegar el Token**  

Ahora ejecutamos el siguiente comando para desplegar el contrato:  

```bash
forge create \
    src/Token.sol:Token \
    --constructor-args 100 "lucas" \
    --rpc-url http://127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```  

📌 **Explicación:**  

- **`src/Token.sol:Token`** → Indica el contrato a desplegar.  
- **`--rpc-url`** → Conexión con la blockchain local (Anvil).  
- **`--private-key`** → Clave privada de una cuenta con saldo en Anvil.  

Si el despliegue es exitoso, se mostrará la dirección del contrato en la terminal.  

---

### **Paso 4: Consultar el saldo del Token**  

Para verificar el saldo inicial del creador del contrato, ejecuta:  

```bash
cast call \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "balanceOf(address)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```  

Esto mostrará el saldo de tokens en la cuenta del creador.  

---

### **Paso 5: Transferir Tokens**  

Para transferir tokens a otra cuenta, usa:  

```bash
cast send \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "transfer(address,uint256)" 0x0000000000000000000000000000000000000022 97000000000000000000 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```  

📌 Esto enviará **97 TOKEN** a la dirección especificada.  

✅ **¡Listo! Hemos creado, desplegado e interactuado con nuestro token ERC20 en una blockchain local.**  

---

## **6. Conclusión**  

📌 **Hoy aprendimos:**  

✔ **Estructura del proyecto en Foundry** → Cómo organizar el código.  
✔ **Instalación de dependencias** → Usamos `forge install` para añadir Solady.  
✔ **Creación de un Token ERC20** → Implementamos un token eficiente con Solady.  
✔ **Despliegue y pruebas** → Usamos `forge create` y `cast` para interactuar con el contrato.  

Estos conocimientos son fundamentales para cualquier desarrollador de smart contracts.  

---

## **7. Recapitulación**  

📌 **Resumen de la clase:**  
1. **Estructura del framework** → Organización del proyecto en Foundry.  
2. **Instalación de dependencias** → Uso de `forge install` para agregar bibliotecas externas.  
3. **Creación de un Token ERC20** → Implementamos un token eficiente con Solady.  
4. **Despliegue e interacción** → Probamos nuestro token con **Anvil** y **Cast**.  

---

## **8. Tarea para casa**  

✏ **Ejercicio práctico:**  

1. Crea un nuevo proyecto con Foundry.  
2. Instala **Solady** como dependencia.  
3. Implementa un **ERC20, ERC721 o ERC1155** usando Solady.  
4. Despliega el contrato en Anvil.  
5. Usa **Cast** para consultar el saldo y transferir tokens.  

---

## **9. Próxima clase**  

📅 **En la próxima clase, exploraremos el mundo de las pruebas en Foundry, aprenderemos a escribir pruebas efectivas y a generar reportes de cobertura.**  

🚀 **¡Nos vemos allí!**  
