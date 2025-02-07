# **Clase 2: Utilidades de Cast**  

## **1. Apertura**  

¡Bienvenido a la **Clase 2 del Módulo 4**! Hoy exploraremos las poderosas **utilidades de Cast**, que facilitan diversas operaciones relacionadas con contratos inteligentes, como trabajar con **ABI**, hacer **conversiones** e interactuar directamente con **RPCs**.  

📌 **Temas de la clase:**  

1. **Utilidades de ABI** → Cómo codificar y decodificar datos de transacciones.  
2. **Conversión de datos con Cast** → Convertir entre diferentes formatos.  
3. **Interacción con RPCs en Anvil** → Probar contratos localmente.  
4. **Comandos de bloques en Cast** → Consultar información de la blockchain.  

✅ **¡Vamos directo al contenido!** 🚀  

---

## **2. Utilidades de ABI: Encode y Decode**  

El **Application Binary Interface (ABI)** es el estándar que permite la comunicación entre contratos y usuarios (o entre contratos). Con **Cast**, puedes **codificar** y **decodificar** datos ABI fácilmente.  

### **Codificación de datos con `cast calldata`**  

El comando **`cast calldata`** permite codificar una función de contrato y sus argumentos en un formato que la **EVM** (Ethereum Virtual Machine) entiende.  

📌 **Ejemplo: Codificar una llamada a `transfer` en un contrato ERC20**  

```bash
cast calldata "transfer(address,uint256)" 0x1234567890abcdef1234567890abcdef12345678 1000000000000000000
```

✅ **Salida esperada:**  

```
0xa9059cbb0000000000000000000000001234567890abcdef1234567890abcdef12345678000000000000000000000000000000000000000000000000000000000000000001
```

📌 **Este código representa la transacción que se enviaría al contrato.**  

---

### **Decodificación de datos con `cast calldata-decode`**  

Si tienes una transacción y quieres entender sus parámetros, usa **`cast calldata-decode`**.  

📌 **Ejemplo: Decodificar una transacción `transfer`**  

```bash
cast calldata-decode "transfer(address,uint256)" 0xa9059cbb0000000000000000000000001234567890abcdef1234567890abcdef12345678000000000000000000000000000000000000000000000000000000000000000001
```

✅ **Salida esperada:**  

```
transfer(
  address: 0x1234567890abcdef1234567890abcdef12345678,
  uint256: 1000000000000000000
)
```

📌 **Esto ayuda a entender los valores enviados en una transacción.**  

---

### **Otras utilidades de ABI**  

📌 **`cast abi-encode`** → Codifica los argumentos para una función o transacción.  

```bash
cast abi-encode "transfer(address,uint256)" 0x1234567890abcdef1234567890abcdef12345678 1000
```

📌 **`cast 4byte-decode`** → Decodifica la firma de una función usando su selector de 4 bytes.  

```bash
cast 4byte-decode 0xa9059cbb
```

📌 **`cast pretty-calldata`** → Formatea los datos de entrada en un formato legible.  

```bash
cast pretty-calldata 0xa9059cbb000000000000...
```

✅ **Estas herramientas son esenciales para analizar transacciones en la blockchain.**  

---

## **3. Conversión de Datos con Cast**  

Cast permite convertir entre diferentes formatos de datos con facilidad.  

### **Conversión de unidades de ETH con `cast to-wei` y `cast from-wei`**  

📌 **Convertir ETH a wei**  

```bash
cast to-wei 1ether
```

✅ **Salida:**  

```
1000000000000000000
```

📌 **Convertir wei a ETH**  

```bash
cast from-wei 1000000000000000000
```

✅ **Salida:**  

```
1.0
```

---

### **Conversión de Strings y Binarios**  

📌 **Convertir string UTF-8 a hexadecimal**  

```bash
cast from-utf8 "hello"
```

✅ **Salida:**  

```
0x68656c6c6f
```

📌 **Convertir hexadecimal a string ASCII**  

```bash
cast to-ascii 0x68656c6c6f
```

✅ **Salida:**  

```
hello
```

📌 **Convertir binario a hexadecimal**  

```bash
cast from-bin "\x41\x42\x43"
```

✅ **Salida:**  

```
0x414243
```

📌 **Convertir número a hexadecimal**  

```bash
cast to-hex 255
```

✅ **Salida:**  

```
0xff
```

---

## **4. Interactuar con RPCs en Anvil**  

Además de consultar blockchains públicas, **Cast** permite interactuar con **Anvil**, una blockchain local para desarrollo.  

### **Ejecutar Anvil y conectarse via RPC**  

📌 **Iniciar Anvil**  

```bash
anvil
```

📌 **Consultar saldo en Anvil**  

```bash
cast balance 0x1234567890abcdef1234567890abcdef12345678 --rpc-url http://127.0.0.1:8545
```

📌 **Enviar ETH en Anvil**  

```bash
cast send --private-key YOUR_PRIVATE_KEY 0x1234567890abcdef1234567890abcdef12345678 --value 0.1ether --rpc-url http://127.0.0.1:8545
```

✅ **Anvil es perfecto para pruebas locales antes del despliegue en redes reales.**  

---

## **5. Comandos de Bloques en Cast**  

Podemos consultar información de bloques de la blockchain en tiempo real.  

📌 **Obtener el número del último bloque**  

```bash
cast block-number --rpc-url https://mainnet.infura.io/v3/YOUR_INFURA_KEY
```

📌 **Obtener detalles de un bloque específico**  

```bash
cast block 12345678 --rpc-url https://mainnet.infura.io/v3/YOUR_INFURA_KEY
```

📌 **Verificar la fecha y hora de un bloque**  

```bash
cast age 12345678 --rpc-url https://mainnet.infura.io/v3/YOUR_INFURA_KEY
```

✅ **Estos comandos son esenciales para monitorear el estado de la blockchain.**  

---

## **6. Conclusión**  

📌 **Hoy aprendimos:**  

✔ **Codificar y decodificar datos ABI con Cast.**  
✔ **Convertir datos entre diferentes formatos.**  
✔ **Interactuar con Anvil y realizar pruebas locales.**  
✔ **Consultar información de bloques en la blockchain.**  

✅ **Estas herramientas son fundamentales para cualquier desarrollador de smart contracts.**  

---

## **7. Tarea para Casa**  

✏ **Ejercicio práctico:**  

1. Usa **`cast calldata`** para codificar una función personalizada de un contrato.  
2. Inicia **Anvil**, despliega un contrato y usa **Cast** para interactuar con él.  
3. Prueba los comandos de conversión (`cast to-wei`, `cast from-wei`, `cast to-hex`).  
4. Usa **`cast block`** para obtener información del último bloque de la Mainnet.  

📌 **Anota tus dudas y experimenta lo máximo posible.**  

---

## **8. Próxima Clase**  

📅 **En la próxima clase, exploraremos cómo gestionar cuentas y realizar transacciones seguras con Cast.**  

🚀 **¡Nos vemos allí!**  
