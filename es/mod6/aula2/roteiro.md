# **Clase 2: Almacenamiento de Claves con Cast Wallet**  

## **1. Apertura**  

¡Bienvenido a la **segunda clase del Módulo 6**! Hoy aprenderemos a **almacenar y administrar claves privadas de manera segura** utilizando **Cast Wallet**.  

📌 **¿Por qué almacenar claves con Cast Wallet?**  
✅ Evita exponer claves privadas en scripts y comandos.  
✅ Permite firmar transacciones sin copiar claves manualmente.  
✅ Facilita la integración con scripts y herramientas de Foundry.  

📌 **Lo que veremos hoy:**  
1. **Introducción a Cast Wallet** → ¿Cómo funciona?  
2. **Crear y administrar billeteras** → Generar, importar y exportar claves.  
3. **Firmar transacciones con Cast Wallet** → Usar claves sin exponerlas.  
4. **Mejores prácticas de seguridad** → Evitar filtraciones de claves.  

✅ **¡Vamos a ello!** 🚀  

---

## **2. Introducción a Cast Wallet**  

📌 **¿Qué es Cast Wallet?**  

**Cast Wallet** es un gestor de billeteras integrado en **Foundry**, que permite **guardar y recuperar claves privadas de manera segura**.  

📌 **Beneficios de usar Cast Wallet:**  
✅ **No necesitas copiar claves manualmente**.  
✅ **Puedes firmar transacciones sin exponer claves privadas**.  
✅ **Compatible con Foundry y Anvil** para pruebas locales.  

### **Verificar si Cast Wallet está instalado**  

Ejecuta:  

```bash
cast wallet --help
```

Si el comando no se encuentra, asegúrate de haber instalado **Foundry** con:  

```bash
foundryup
```

---

## **3. Crear y Administrar Billeteras**  

📌 **Generar una nueva billetera y almacenarla**  

```bash
cast wallet new --save
```

✅ **Salida esperada:**  

```
New wallet generated!
Address: 0x1234567890abcdef1234567890abcdef12345678
Keystore: ~/.foundry/keystore
```

📌 **El archivo se almacena en `~/.foundry/keystore` de forma cifrada.**  

---

### **📌 Listar billeteras almacenadas**  

```bash
cast wallet list
```

✅ **Muestra todas las claves almacenadas en Cast Wallet.**  

---

### **📌 Importar una clave privada existente**  

Si ya tienes una clave privada y quieres almacenarla en **Cast Wallet**, usa:  

```bash
cast wallet import 0xYourPrivateKey
```

✅ **Esto guarda la clave encriptada en el keystore.**  

---

### **📌 Exportar una clave privada almacenada**  

Si necesitas recuperar una clave almacenada:  

```bash
cast wallet export 0xYourWalletAddress
```

📌 **Te pedirá la contraseña antes de mostrar la clave.**  

✅ **Nunca compartas ni expongas claves privadas en texto plano.**  

---

## **4. Firmar Transacciones con Cast Wallet**  

### **📌 Enviar ETH desde una billetera almacenada**  

```bash
cast send \
    --wallet 0x1234567890abcdef1234567890abcdef12345678 \
    0xRecipientAddress \
    --value 0.1ether \
    --rpc-url http://127.0.0.1:8545
```

✅ **Esto usa la clave almacenada para firmar la transacción sin necesidad de escribirla manualmente.**  

---

### **📌 Firmar un mensaje con una clave almacenada**  

Podemos firmar mensajes para autenticación sin exponer la clave privada.  

```bash
cast wallet sign --wallet 0x1234567890abcdef1234567890abcdef12345678 "Este es un mensaje firmado"
```

✅ **Salida esperada:**  

```
Firma: 0x...
```

📌 **Esta firma puede verificarse en smart contracts o aplicaciones descentralizadas.**  

---

### **📌 Verificar una firma**  

Si alguien te envió un mensaje firmado, puedes verificar si realmente proviene de una cuenta específica.  

```bash
cast wallet verify "Este es un mensaje firmado" 0xFirmaGenerada
```

✅ **Esto confirma si la firma es válida o no.**  

---

## **5. Mejores Prácticas de Seguridad**  

📌 **❌ Evita estos errores comunes:**  

- ❌ **No guardes claves privadas en archivos de texto sin cifrar.**  
- ❌ **No copies claves manualmente en scripts.**  
- ❌ **No compartas claves privadas en repositorios públicos.**  

📌 **✅ Mejores prácticas:**  

- ✅ **Usa `cast wallet` para administrar claves de forma segura.**  
- ✅ **Usa keystores encriptados en lugar de archivos de texto plano.**  
- ✅ **Siempre usa `--wallet` en lugar de `--private-key` en transacciones.**  

✅ **Siguiendo estas prácticas, evitarás exponer claves y mejorarás la seguridad de tus transacciones.**  

---

## **6. Conclusión**  

📌 **Hoy aprendimos:**  
✔ **Cómo crear, importar y exportar claves con Cast Wallet.**  
✔ **Cómo firmar transacciones sin exponer claves privadas.**  
✔ **Cómo firmar y verificar mensajes con Cast.**  
✔ **Mejores prácticas de seguridad en el almacenamiento de claves.**  

✅ **Con Cast Wallet, puedes gestionar tus claves de manera segura y eficiente.**  

---

## **7. Recapitulación**  

📌 **Resumen de la clase:**  
1. **¿Qué es Cast Wallet?** → Herramienta segura para almacenar claves.  
2. **Cómo crear y administrar billeteras** → `cast wallet new`, `cast wallet import`.  
3. **Firmar transacciones sin exponer claves** → `cast send --wallet`.  
4. **Buenas prácticas de seguridad** → Evitar exponer claves privadas.  

---

## **8. Tarea para Casa**  

✏ **Ejercicio práctico:**  

1. **Crea una nueva billetera con Cast Wallet.**  
2. **Importa una clave privada y envía ETH desde la billetera almacenada.**  
3. **Firma un mensaje y verifica su autenticidad.**  

📌 **Toma notas de los resultados y experimenta lo máximo posible.**  

---

## **9. Próxima Clase**  

📅 **En la próxima clase, aprenderemos cómo integrar Foundry con ScaffoldETH2 para construir aplicaciones descentralizadas de manera eficiente.**  

🚀 **¡Nos vemos allí!**  
