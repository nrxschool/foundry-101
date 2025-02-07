# **Clase 1: CLI, Creación de Proyecto, Configuración y Ejecución de Proyecto**  

## **1. Apertura**  

¡Hola! Bienvenido a nuestra clase del curso **Foundry 101**.  

Hoy nos sumergiremos en los fundamentos prácticos de cómo usar **Forge** y configurar tu entorno de desarrollo con **Foundry**.  

Esta es una clase muy práctica, donde crearemos y configuraremos un proyecto desde cero.  

Seguiremos el siguiente esquema:  

1. Comandos principales de la CLI  
2. Crear un nuevo proyecto  
3. Configuraciones útiles  
4. Ejecutar el proyecto  

Así que prepárate, porque hoy ¡vamos a poner manos a la obra!  

---

## **2. Comandos principales de la CLI `forge`**  

Comencemos conociendo los **comandos principales de la CLI de Forge**.  

La línea de comandos (**CLI**) es donde interactuarás directamente con **Forge** para realizar acciones como crear, compilar, probar y desplegar contratos.  

Aquí están los comandos más importantes:  

- **`forge init`** → Inicia un nuevo proyecto.  
- **`forge build`** → Compila los contratos del proyecto.  
- **`forge test`** → Ejecuta pruebas unitarias para los contratos.  
- **`forge install`** → Instala dependencias externas (como bibliotecas).  
- **`forge create`** → Despliega un contrato directamente en la blockchain.  
- **`forge script`** → Ejecuta scripts personalizados, como scripts de despliegue.  

---

## **3. Creación de un nuevo proyecto**  

Ahora que conocemos los comandos principales de la CLI, crearemos un **nuevo proyecto** para aplicarlos en la práctica.  

### **1. Crear un proyecto llamado "Counter"**  

En la terminal, escribe:  

```bash
forge init counter
```  

Esto generará la estructura básica del proyecto con carpetas como:  

- **`src/`** → Para almacenar los contratos.  
- **`test/`** → Para almacenar las pruebas.  
- **`foundry.toml`** → Archivo de configuración del proyecto.  

📌 **En la próxima clase estudiaremos más a fondo la estructura básica del proyecto.**  

---

## **4. Configuraciones útiles del proyecto**  

Ahora que el proyecto está creado, veamos algunas **configuraciones útiles** que podemos ajustar en el archivo `foundry.toml`.  

📌 **Abramos `foundry.toml`**, donde encontramos configuraciones importantes como:  

- **Versión de Solidity** → Define la versión del compilador que se usará en el proyecto.  

Ejemplo de cómo definir la versión de Solidity:  

```toml
[profile.default]
solc_version = '0.8.24'
```  

---

## **5. Ejecutar el Proyecto**  

Ahora que hemos creado y compilado nuestro contrato, es hora de hacer el **despliegue** utilizando el comando **`forge create`**, que facilita la implementación del contrato en la blockchain local o en redes reales.  

### **1. Iniciar una blockchain local**  

Primero, ejecutemos **Anvil**, que simula una blockchain local:  

```bash
anvil -b 2
```  

📌 Anvil generará claves privadas con saldo en ETH para pruebas. Vamos a usar una de ellas:  

```
0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```  

---

### **2. Desplegar el contrato**  

Con Anvil en ejecución, ahora podemos desplegar nuestro contrato con el siguiente comando:  

```bash
forge create \
    src/Counter.sol:Counter \
    --rpc-url http://127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```  

📌 **Explicación del comando:**  
- **Especifica el contrato a desplegar** → `src/Counter.sol:Counter`  
- **Usa la URL de la blockchain local (Anvil)** → `http://127.0.0.1:8545`  
- **Utiliza la clave privada para firmar la transacción**  

Si todo está correcto, se mostrará la dirección del contrato desplegado en la terminal.  

---

### **3. Interactuar con el contrato**  

Ahora interactuaremos con el contrato usando **Cast**.  

**📌 Primero, consultemos el valor actual de `number` en la blockchain:**  

```bash
cast call \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "number()(uint256)" \
    --rpc-url http://127.0.0.1:8545
```  

📌 **Ahora, modifiquemos el valor de `number` con `setNumber` y verifiquemos el cambio:**  

```bash
cast send \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "setNumber(uint256)" 42 \
    --rpc-url http://127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```  

📌 **Verifiquemos el nuevo valor de `number`:**  

```bash
cast call \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "number()(uint256)" \
    --rpc-url http://127.0.0.1:8545
```  

✅ **¡Listo!** Hemos desplegado el contrato e interactuado con él usando las herramientas de Foundry.  

---

## **6. Conclusión**  

En esta clase, hemos aprendido a trabajar con los **comandos principales de la CLI de Forge**, incluyendo el comando **`forge create`** para el despliegue de contratos.  

📌 **Resumen:**  
✔ Creamos un proyecto desde cero.  
✔ Ajustamos configuraciones en `foundry.toml`.  
✔ Desplegamos el contrato en **Anvil**.  
✔ Interactuamos con el contrato usando **Cast**.  

Estos conocimientos son fundamentales para un desarrollo eficiente con **Foundry**.  

---

## **7. Recapitulación**  

📌 **Hoy aprendimos:**  
1. **CLI de Forge** → Exploramos comandos como `forge init`, `forge build` y `forge create`.  
2. **Creación de proyectos** → Iniciamos un nuevo proyecto y creamos un contrato simple.  
3. **Configuraciones útiles** → Ajustamos el archivo `foundry.toml` para optimización.  
4. **Despliegue completo** → Usamos `forge create` para desplegar el contrato en Anvil.  
5. **Interacción con el contrato** → Usamos **Cast** para consultar y modificar valores en el contrato.  

---

## **8. Tarea para casa**  

✏ **Ejercicio práctico:**  

1. Crea un nuevo proyecto con Forge.  
2. Escribe un contrato simple que almacene otros datos y prueba interacciones con él.  
3. Modifica el `foundry.toml` para usar versiones antiguas de Solidity.  
4. Despliega el contrato en **Anvil** con `forge create`.  
5. Usa **Cast** para interactuar con el contrato y probar sus funciones.  

📌 **Anota tus dudas y experimenta lo máximo posible.**  

---

## **9. Próxima clase**  

📅 **En la próxima clase, exploraremos la estructura básica de un proyecto, aprenderemos a instalar dependencias con `forge` y crearemos un Token ERC20.**  

🚀 **¡No te lo pierdas! Nos vemos en la próxima clase.**  
