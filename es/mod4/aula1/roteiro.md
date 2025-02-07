# **Clase 1: Lectura y Escritura con Cast**  

## **1. Apertura**  

¡Hola y bienvenido a la **Clase 1 del Módulo 4**!  

En este módulo, profundizaremos en **Cast**, la herramienta de línea de comandos (**CLI**) de **Foundry** para interactuar con contratos inteligentes y realizar llamadas RPC directamente desde la terminal. Si ya usaste Cast en clases anteriores, ahora exploraremos sus características de manera más detallada.  

📌 **En esta clase veremos:**  
1. **Introducción avanzada a Cast** y su interfaz CLI.  
2. **Lectura de datos en la blockchain** con Cast.  
3. **Cómo escribir transacciones en la blockchain** usando Cast.  

✅ **¡Comencemos explorando Cast y su CLI!** 🚀  

---

## **2. Explorando Cast en Profundidad**  

**Cast** es una herramienta poderosa para realizar llamadas a contratos inteligentes, enviar transacciones y recuperar información de la blockchain directamente desde la terminal.  

📌 **Estructura básica de Cast:**  

```bash
cast
```

### **Principales Subcomandos**  

- **`cast call`** → Realiza una consulta de lectura a un contrato.  
- **`cast send`** → Envía una transacción a la blockchain.  
- **`cast estimate`** → Calcula el costo de gas de una transacción.  
- **`cast balance`** → Muestra el saldo de una cuenta en wei o ether.  
- **`cast nonce`** → Muestra el nonce de una cuenta.  
- **`cast gas-price`** → Muestra el precio actual del gas.  

📌 **A lo largo de este módulo, exploraremos estos subcomandos en detalle.**  

---

## **3. Todo Sobre la Lectura en la Blockchain**  

Una de las funciones más importantes de **Cast** es la capacidad de **leer datos en la blockchain**. Veamos cómo usar **Cast** para hacer consultas eficientes a contratos y cuentas.  

### **`cast call` → Consultar datos de contratos**  

El subcomando `cast call` permite consultar contratos sin publicar transacciones ni gastar gas.  

📌 **Ejemplo: Consultar el saldo de una cuenta en un contrato ERC20**  

```bash
CONTRACT=0x6b175474e89094c44da98b954eedeac495271d0f
cast call \
    $CONTRACT \
    "balanceOf(address)(uint256)" \
    0x1234567890abcdef1234567890abcdef12345678 \
    --rpc-url http://127.0.0.1:8545
```

✅ **Esto devuelve el saldo de tokens de la cuenta especificada.**  

---

### **`cast balance` → Consultar saldo de una cuenta**  

Para consultar el saldo de una cuenta en wei o ether:  

📌 **En wei (unidad mínima de ETH):**  

```bash
cast balance \
    0x1234567890abcdef1234567890abcdef12345678 \
    --rpc-url http://127.0.0.1:8545
```

📌 **Convertir el saldo a ether:**  

```bash
cast balance \
    0x1234567890abcdef1234567890abcdef12345678 \
    --ether \
    --rpc-url http://127.0.0.1:8545
```

✅ **Esto devuelve el saldo de ETH de la cuenta.**  

---

### **Otros comandos útiles de lectura**  

📌 **`cast gas-price` → Obtener el precio actual del gas**  

```bash
cast gas-price --rpc-url http://127.0.0.1:8545
```

📌 **`cast block-number` → Obtener el número del último bloque**  

```bash
cast block-number --rpc-url http://127.0.0.1:8545
```

📌 **`cast code` → Obtener el bytecode de un contrato**  

```bash
CONTRACT=0x5FbDB2315678afecb367f032d93F642f64180aa3
cast code \
    $CONTRACT \
    --rpc-url http://127.0.0.1:8545
```

✅ **Estos comandos permiten acceder a información clave sobre la blockchain de manera rápida y eficiente.**  

---

## **4. Todo Sobre Escritura en la Blockchain**  

Para modificar datos en la blockchain, necesitamos **enviar transacciones**. **Cast** nos permite hacerlo con el comando **`cast send`**.  

### **`cast send` → Enviar transacciones**  

📌 **Ejemplo: Enviar 0.1 ETH a otra cuenta**  

```bash
YOUR_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
cast send \
    --private-key $YOUR_PRIVATE_KEY \
    0x1234567890abcdef1234567890abcdef12345678 \
    --value 0.1ether \
    --rpc-url http://127.0.0.1:8545
```

✅ **Esto transfiere 0.1 ETH a la cuenta de destino.**  

---

### **Enviar transacciones a contratos inteligentes**  

También podemos invocar funciones en contratos inteligentes.  

📌 **Ejemplo: Transferir 1 token ERC20**  

```bash
YOUR_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
CONTRACT=0x6b175474e89094c44da98b954eedeac495271d0f
cast send \
    --private-key $YOUR_PRIVATE_KEY \
    $CONTRACT \
    "transfer(address,uint256)" \
    0x1234567890abcdef1234567890abcdef12345678 1000000000000000000 \
    --rpc-url http://127.0.0.1:8545
```

✅ **Esto ejecuta la función `transfer` en el contrato ERC20.**  

---

### **Otras opciones de `cast send`**  

📌 **Definir gas y nonce manualmente**  

```bash
cast send \
    --private-key $YOUR_PRIVATE_KEY \
    0x1234567890abcdef1234567890abcdef12345678 \
    --value 0.1ether \
    --gas-limit 21000 \
    --gas-price 100gwei \
    --rpc-url http://127.0.0.1:8545
```

✅ **Esto permite mayor control sobre la transacción.**  

---

## **5. Conclusión**  

📌 **Hoy aprendimos:**  
✔ **Introducción a la CLI de Cast y sus comandos principales.**  
✔ **Cómo leer datos de la blockchain** (`cast call`, `cast balance`).  
✔ **Cómo enviar transacciones a cuentas y contratos** (`cast send`).  

✅ **Ahora sabes cómo interactuar con la blockchain directamente desde la terminal.**  

---

## **6. Recapitulación**  

📌 **Resumen de la clase:**  
1. **Lectura en la blockchain** → `cast call`, `cast balance`, `cast gas-price`.  
2. **Envío de transacciones** → `cast send` para ETH y contratos inteligentes.  

---

## **7. Tarea para casa**  

✏ **Ejercicio práctico:**  

1. Usa **`cast call`** para consultar el saldo de un token ERC20 en una cuenta.  
2. Usa **`cast send`** para transferir ETH entre cuentas en **Anvil**.  
3. Experimenta con el envío de transacciones usando `cast send` con diferentes valores de gas.  

📌 **Anota tus dudas y experimenta al máximo.**  

---

## **8. Próxima clase**  

📅 **En la próxima clase, aprenderemos sobre utilidades de ABI y conversión de datos en Cast.**  

🚀 **¡Nos vemos allí!**  
