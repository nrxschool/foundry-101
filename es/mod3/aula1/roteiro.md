# **Clase 1: CLI y Ejecutando Blockchain con Anvil**  

## **1. Apertura**  

¡Hola! Bienvenido a la **primera clase del Módulo 3** de nuestro curso **Foundry 101**. Hoy aprenderemos sobre **Anvil**, la herramienta de blockchain local de Foundry. **Anvil** es esencial para simular entornos de prueba y desarrollar contratos inteligentes en un entorno controlado.  

📌 **Lo que veremos hoy:**  
1. **Cómo funciona Anvil** y su propósito.  
2. **Exploración de la CLI** y sus comandos principales.  
3. **Configuración de MetaMask** para conectarse a Anvil.  
4. **Otras configuraciones útiles para el desarrollo.**  

¡Comencemos! 🚀  

---

## **2. Introducción a Anvil y su Ejecución**  

### **¿Qué es Anvil?**  

**Anvil** es un nodo local que simula una blockchain completa en tu computadora. Viene incluido con **Foundry** y es extremadamente útil para probar contratos inteligentes sin necesidad de conectarse a una red pública.  

📌 **Beneficios de usar Anvil:**  
✅ **Cuentas de desarrollo preconfiguradas** para pruebas.  
✅ **Despliegue de contratos inteligentes** sin costos de gas real.  
✅ **Pruebas rápidas y controladas** en un entorno seguro.  

### **Cómo ejecutar Anvil**  

Para iniciar Anvil, simplemente ejecuta el siguiente comando en la terminal:  

```bash
anvil
```

📌 **Salida esperada:**  

```bash
Available Accounts
==================
(0) 0xF39Fd6e51aad88F6F4ce6aB8827279cffFb92266 (10000 ETH)
(1) 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC (10000 ETH)
(2) 0x90F79bf6EB2c4f870365E785982E1f101E93b906 (10000 ETH)
...
```

Anvil asigna **10 cuentas con saldo en ETH** para pruebas. Se ejecuta por defecto en **localhost:8545**, lo que permite interactuar con herramientas como **MetaMask**, **Remix** o **Cast**.  

---

## **3. Exploración de la CLI de Anvil**  

Ahora que Anvil está ejecutándose, exploremos sus opciones de configuración más útiles.  

### **Comandos útiles de Anvil**  

📌 **Modificar el número de cuentas generadas:**  

```bash
# Crea 15 cuentas en lugar de las 10 predeterminadas.
anvil --accounts 15
```

📌 **Modificar el saldo inicial de cada cuenta:**  

```bash
# Cada cuenta será creada con 500 ETH.
anvil --balance 500
```

📌 **Configurar la minería automática:**  

```bash
# Genera un nuevo bloque cada 10 segundos.
anvil --block-time 10
```

📌 **Ejecutar Anvil en un Chain ID específico:**  

```bash
# Especifica un Chain ID personalizado.
anvil --chain-id 1337
```

---

## **4. Conectar MetaMask a Anvil**  

### **Pasos para conectar MetaMask a Anvil:**  

1. Abre **MetaMask** y ve a la configuración de redes.  
2. Agrega una nueva red con los siguientes valores:  
   - **Nombre de la red**: Anvil Local  
   - **Nueva URL RPC**: `http://127.0.0.1:8545`  
   - **ID de Red**: `31337` (predeterminado de Anvil)  
   - **Moneda**: ETH  
3. Guarda los cambios y cambia a la red **Anvil Local**.  

✅ **¡Listo! Ahora puedes interactuar con contratos en tu blockchain local.**  

### **Importar Cuentas de Anvil en MetaMask**  

1. Copia una clave privada de las cuentas generadas por Anvil.  
2. En MetaMask, selecciona **Importar cuenta** y pega la clave privada.  
3. Ahora puedes usar esta cuenta para desplegar y probar contratos en Anvil.  

---

## **5. Configuraciones Avanzadas en Anvil**  

### **Hacer Fork de una Red Real**  

Anvil permite **forkear** una red real, es decir, replicar su estado en un entorno local.  

📌 **Ejemplo de fork de la Mainnet de Ethereum:**  

```bash
anvil --fork-url https://eth-mainnet.g.alchemy.com/v2/<API_KEY>
```

📌 **Ejemplo de fork de Sepolia:**  

```bash
anvil --fork-url https://eth-sepolia.g.alchemy.com/v2/<API_KEY>
```

Esto carga el estado actual de la red en tu máquina, permitiéndote probar interacciones con contratos reales sin gastar gas.  

### **Modo de Minería Manual**  

Si necesitas más control sobre cuándo se minan los bloques, puedes activar la **minería manual**:  

```bash
anvil --no-mining
```

Para generar un bloque manualmente, usa:  

```bash
RPC="http://127.0.0.1:8545"
cast rpc anvil_mine --rpc-url $RPC
```

### **Ajustar el Límite de Gas**  

Si estás probando contratos que requieren más gas, puedes configurar un límite más alto:  

```bash
anvil --gas-limit 12000000
```

✅ **Estas opciones avanzadas te permiten personalizar Anvil según tus necesidades.**  

---

## **6. Conclusión**  

Hoy hemos aprendido sobre **Anvil**, su CLI y cómo configurarlo para mejorar nuestro flujo de desarrollo con **Foundry**.  

📌 **Resumen de la clase:**  
✔ **Ejecutamos Anvil y exploramos sus cuentas de prueba.**  
✔ **Aprendimos a modificar configuraciones con la CLI.**  
✔ **Conectamos MetaMask a Anvil e importamos cuentas.**  
✔ **Exploramos funciones avanzadas como forks y minería manual.**  

✅ **Ahora tienes una blockchain local totalmente configurada para pruebas y desarrollo.**  

---

## **7. Recapitulación**  

📌 **Hoy aprendimos:**  
1. **Cómo ejecutar Anvil** y explorar sus opciones CLI.  
2. **Cómo conectar MetaMask** y trabajar con cuentas locales.  
3. **Cómo hacer forks de redes reales** para pruebas avanzadas.  
4. **Cómo modificar parámetros de minería y gas** para simular diferentes escenarios.  

---

## **8. Tarea para casa**  

✏ **Ejercicio práctico:**  

1. Ejecuta **Anvil** en tu máquina y genera 20 cuentas en lugar de 10.  
2. Modifica los balances iniciales de las cuentas.  
3. Conecta MetaMask a Anvil y realiza una transferencia de ETH entre cuentas.  
4. Haz un **fork de una testnet real** (Goerli o Sepolia) y consulta el estado de un contrato existente con `cast call`.  

📌 **Anota tus dudas y experimenta todo lo posible.**  

---

## **9. Próxima clase**  

📅 **En la próxima clase, aprenderemos a hacer despliegues locales en Anvil y a persistir el estado de la blockchain.**  

🚀 **¡Nos vemos allí!**  
