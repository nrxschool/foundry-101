# **Clase 2: Despliegue Local en Anvil**  

## **1. Apertura**  

¡Hola! Bienvenido a la **segunda clase del Módulo 3** de nuestro curso **Foundry 101**. Hoy hablaremos sobre **despliegue local con Anvil** y cómo guardar, cargar y gestionar el estado de la blockchain local. También exploraremos las flags de Anvil que permiten la persistencia del estado, trabajaremos con logs y ejecutaremos pruebas.  

📌 **Temas que veremos hoy:**  

1. Cómo **gestionar estados de la blockchain** con **Anvil**.  
2. Escenario práctico de **persistencia de estado**.  

¡Vamos directo al punto! 🚀  

---

## **2. Flags y Configuración en Anvil**  

Anvil ofrece varias opciones para **guardar, cargar y gestionar** el estado de la blockchain local. Esto es extremadamente útil para mantener el progreso del entorno de pruebas o simular diferentes escenarios sin perder datos.  

### **Flags principales en Anvil**  

📌 **Guardar el estado al cerrar Anvil (`--dump-state`)**  

```bash
# Cuando Anvil se cierra, guarda el estado en un archivo JSON llamado `estado.json`.
anvil --dump-state ./estado.json
```

📌 **Cargar un estado guardado anteriormente (`--load-state`)**  

```bash
# Carga un estado previamente guardado al iniciar Anvil.
anvil --load-state ./estado.json
```

📌 **Definir el número máximo de estados guardados (`--max-persisted-states`)**  

```bash
# Configura el número máximo de estados almacenados en disco (rotación).
anvil --max-persisted-states 5
```

📌 **Preservar historial de estados (`--preserve-historical-states`)**  

```bash
# Mantiene un historial de estados de la blockchain.
anvil --preserve-historical-states
```

📌 **Configurar el intervalo de guardado de estado (`--state-interval`)**  

```bash
# Define el intervalo de tiempo para guardar el estado en disco (en segundos).
anvil --state-interval 60
```

📌 **Combinar carga y guardado de estado (`--state`)**  

```bash
# Usa el mismo archivo JSON tanto para cargar como para guardar el estado.
anvil --state ./estado.json
```

✅ **Estas flags son esenciales para el desarrollo de contratos inteligentes sin perder datos entre sesiones.**  

---

## **3. Práctica: Despliegue, Interacción y Persistencia del Estado**  

Ahora aplicaremos lo que aprendimos sobre las flags de Anvil.  

### **Paso 1: Iniciar Anvil con persistencia de estado**  

Ejecutemos **Anvil** con la opción `--dump-state` para asegurarnos de que el estado se guardará al cerrarlo:  

```bash
anvil --dump-state ./estado.json
```

---

### **Paso 2: Desplegar un contrato**  

Usaremos un contrato simple llamado **Counter**:  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    uint256 count;

    function incc() external {
        count++;
    }

    function set(uint256 number) external {
        count = number;
    }

    function get() external view returns (uint256) {
        return count;
    }
}
```

📌 **Ejecutar el despliegue con `forge create`**  

```bash
forge create \
    ./src/Counter.sol:Counter \
    --rpc-url http://127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

✅ Esto desplegará el contrato en la blockchain local de Anvil.  

---

### **Paso 3: Interactuar con el contrato**  

Ahora que el contrato está desplegado, interactuemos con él usando **Cast**.  

📌 **Obtener el valor inicial**  

```bash
CONTRACT_ADDRESS=0x5FbDB2315678afecb367f032d93F642f64180aa3
cast call \
    $CONTRACT_ADDRESS \
    "get()(uint256)"
```

📌 **Actualizar el valor a `7889`**  

```bash
cast send \
    $CONTRACT_ADDRESS \
    "set(uint256)" 7889 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

📌 **Verificar el último valor**  

```bash
cast call \
    $CONTRACT_ADDRESS \
    "get()(uint256)"
```

✅ **El contrato ahora tiene un nuevo valor almacenado en la blockchain local de Anvil.**  

---

### **Paso 4: Reiniciar Anvil y cargar el estado guardado**  

Después de interactuar con el contrato, cerremos Anvil. El estado se guardará en `estado.json`.  

Ahora reiniciemos Anvil con la opción `--load-state` para restaurar el estado anterior:  

```bash
anvil --load-state ./estado.json
```

📌 **Verificar el estado tras la recarga**  

```bash
cast call \
    $CONTRACT_ADDRESS \
    "get()(uint256)"
```

Si todo salió bien, el valor almacenado debería seguir siendo **7889**, lo que demuestra que el estado de la blockchain persistió correctamente.  

✅ **¡Ahora podemos guardar y restaurar estados en Anvil sin perder datos!**  

---

## **6. Conclusión**  

Hoy aprendimos a:  
✔ **Hacer despliegue localmente con Anvil.**  
✔ **Guardar y cargar estados de la blockchain con flags avanzadas.**  
✔ **Interactuar con contratos y verificar persistencia de datos.**  

Estas herramientas facilitan un desarrollo más eficiente y evitan la pérdida de datos en pruebas.  

---

## **7. Recapitulación**  

📌 **Hoy vimos:**  
1. **Flags esenciales en Anvil** (`--dump-state`, `--load-state`).  
2. **Práctica de despliegue e interacción con contratos.**  
3. **Guardado y restauración del estado de la blockchain local.**  

---

## **8. Tarea para casa**  

✏ **Ejercicio práctico:**  

1. **Despliega un contrato en Anvil** y realiza interacciones con él.  
2. **Guarda el estado de la blockchain** y verifica que persiste tras reiniciar Anvil.  
3. **Explora los logs de Anvil** para monitorear transacciones y llamadas a contratos.  

📌 **Anota tus dudas y experimenta al máximo.**  

---

## **9. Próxima clase**  

📅 **En la próxima clase, exploraremos cómo hacer forks de redes reales y probar interacciones con contratos existentes en un entorno local.**  

🚀 **¡Nos vemos allí!**  
