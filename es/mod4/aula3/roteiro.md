# **Clase 3: Gestión de Cuentas con Cast**  

## **1. Apertura**  

¡Bienvenido a la **Clase 3 del Módulo 4**! Hoy profundizaremos en el **modelo de cuentas en Ethereum** y aprenderemos cómo **gestionar cuentas y billeteras** con **Cast**, incluyendo la firma de transacciones y mensajes.  

📌 **Lo que veremos hoy:**  

1. **Modelo de cuentas en Ethereum** → EOAs vs. cuentas de contrato.  
2. **Comandos de cuenta en Cast** → Consultar saldos, nonce y datos de almacenamiento.  
3. **Gestión de billeteras** → Crear y administrar claves privadas.  
4. **Firmar transacciones y mensajes** → Cómo autorizar operaciones en la blockchain.  

✅ **¡Vamos a ello!** 🚀  

---

## **2. Modelo de Cuentas en Ethereum**  

Ethereum usa el **Account Model**, diferente del modelo **UTXO (Unspent Transaction Output)** de Bitcoin.  

### **Diferencia entre UTXO y Account Model**  

- **UTXO (Bitcoin)**: Las transacciones gastan salidas de transacciones anteriores y generan nuevas.  
- **Account Model (Ethereum)**: Cada cuenta tiene un saldo y cada transacción modifica directamente el estado de la cuenta.  

📌 **Tipos de cuentas en Ethereum:**  

1. **Externally Owned Accounts (EOAs)**  
   - Controladas por claves privadas.  
   - Se utilizan para enviar y recibir transacciones.  

2. **Contract Accounts**  
   - Asociadas a smart contracts.  
   - No tienen clave privada; solo responden a transacciones externas.  

✅ **Ahora aprenderemos a interactuar con estas cuentas usando Cast.**  

---

## **3. Comandos de Cuenta en Cast**  

Podemos usar **Cast** para consultar información de cualquier cuenta en la blockchain.  

### **Consultar saldo de una cuenta**  

📌 **En wei:**  

```bash
cast balance 0x1234567890abcdef1234567890abcdef12345678 --rpc-url http://127.0.0.1:8545
```

📌 **Convertir saldo a ETH:**  

```bash
cast balance 0x1234567890abcdef1234567890abcdef12345678 --ether --rpc-url http://127.0.0.1:8545
```

---

### **Consultar el nonce de una cuenta**  

📌 **El nonce indica cuántas transacciones ha enviado una cuenta.**  

```bash
cast nonce 0x1234567890abcdef1234567890abcdef12345678 --rpc-url http://127.0.0.1:8545
```

✅ **Esto es útil para evitar transacciones duplicadas o pérdidas de gas.**  

---

### **Consultar datos de almacenamiento de una cuenta**  

Si un contrato almacena datos en la blockchain, podemos recuperarlos con **Cast**.  

📌 **Ejemplo: Consultar el almacenamiento de un contrato**  

```bash
cast storage 0xContractAddress 0 --rpc-url http://127.0.0.1:8545
```

✅ **Esto devuelve el valor almacenado en la posición 0 del almacenamiento del contrato.**  

---

## **4. Gestión de Billeteras con Cast**  

Podemos usar **Cast** para generar y administrar claves privadas de forma segura.  

### **Generar una nueva clave privada**  

```bash
cast wallet new
```

✅ **Salida esperada:**  

```
Private Key: 0x...
Address:     0x...
```

📌 **Guarda tu clave privada en un lugar seguro.**  

---

### **Obtener la dirección de una clave privada**  

Si ya tienes una clave privada, puedes derivar su dirección Ethereum:  

```bash
cast wallet address --private-key 0xYourPrivateKey
```

✅ **Salida esperada:**  

```
Address: 0x1234567890abcdef1234567890abcdef12345678
```

---

### **Firmar Mensajes con una Clave Privada**  

Podemos firmar mensajes fuera de la blockchain para autenticación.  

📌 **Ejemplo: Firmar un mensaje con Cast**  

```bash
cast wallet sign --private-key 0xYourPrivateKey "Este es un mensaje firmado"
```

✅ **Salida esperada:**  

```
Firma: 0x...
```

📌 **Esto permite verificar la identidad del firmante sin hacer una transacción.**  

---

## **5. Envío de Transacciones Firmadas**  

Para modificar datos en la blockchain, debemos enviar transacciones firmadas.  

📌 **Ejemplo: Enviar 0.1 ETH a otra cuenta**  

```bash
cast send --private-key 0xYourPrivateKey 0xRecipientAddress --value 0.1ether --rpc-url http://127.0.0.1:8545
```

✅ **Esto envía 0.1 ETH desde tu cuenta sin necesidad de abrir MetaMask.**  

---

### **Firmar una Transacción sin Enviarla**  

📌 **Ejemplo: Firmar una transacción pero no enviarla inmediatamente**  

```bash
cast wallet sign-tx --private-key 0xYourPrivateKey --to 0xRecipientAddress --value 0.1ether
```

✅ **Esto genera una transacción firmada que puedes enviar manualmente más tarde.**  

---

### **Enviar una Transacción Firmada**  

Si tienes una transacción firmada, puedes enviarla a la blockchain con:  

```bash
cast publish 0xSignedTransaction
```

✅ **Útil para retransmitir transacciones sin exponer tu clave privada.**  

---

## **6. Conclusión**  

📌 **Hoy aprendimos:**  

✔ **Cómo funcionan las cuentas en Ethereum (EOA vs. cuentas de contrato).**  
✔ **Consultar saldo, nonce y datos de almacenamiento en Cast.**  
✔ **Generar y administrar billeteras con Cast.**  
✔ **Firmar mensajes y transacciones sin exponer la clave privada.**  

✅ **Estas herramientas son esenciales para cualquier desarrollador de smart contracts.**  

---

## **7. Recapitulación**  

📌 **Resumen de la clase:**  
1. **Cuentas en Ethereum** → EOAs y cuentas de contrato.  
2. **Consultar datos en Cast** → `cast balance`, `cast nonce`, `cast storage`.  
3. **Gestión de billeteras** → `cast wallet new`, `cast wallet address`.  
4. **Firmar y enviar transacciones** → `cast wallet sign`, `cast send`.  

---

## **8. Tarea para Casa**  

✏ **Ejercicio práctico:**  

1. **Crea una nueva billetera con Cast** y guarda la clave privada.  
2. **Consulta el saldo de una cuenta en una testnet (Sepolia o Goerli).**  
3. **Firma un mensaje con tu nueva billetera** y verifica la firma.  
4. **Envía una transacción en Anvil y verifica que fue procesada.**  

📌 **Toma notas de los resultados y experimenta lo máximo posible.**  

---

## **9. Próxima Clase**  

📅 **En la próxima clase, exploraremos cómo trabajar con transacciones sin gas (`meta-transactions`) y cómo integrarlas con Cast.**  

🚀 **¡Nos vemos allí!**  
