# **Clase 3: Ecosistema Foundry**  

## **1. Apertura**  

¡Hola! ¡Bienvenido a nuestra tercera clase del curso **Foundry 101**!  

Hoy exploraremos en profundidad el **ecosistema Foundry**, una de las herramientas más modernas y potentes para el desarrollo en blockchain.  

En esta clase, abordaremos los siguientes temas:  

### **Programación:**  
1. **Historia de Foundry** → Cómo y por qué se creó esta herramienta.  
2. **Forge** → El núcleo de Foundry y su principal herramienta de desarrollo.  
3. **Anvil** → Permite simular un entorno blockchain local.  
4. **Cast y Chisel** → Herramientas avanzadas para facilitar la interacción con contratos.  

📌 **⚠️ Importante:** Si no realizaste la tarea de la clase 1, te costará seguir esta lección.  

Ahora sí, ¡comencemos! 🚀  

---

## **2. Historia de Foundry**  

**Foundry** nació de la necesidad de una herramienta más rápida y flexible para los desarrolladores que trabajan con contratos inteligentes en la **Ethereum Virtual Machine (EVM)**.  

### **¿Por qué se creó Foundry?**  

Tradicionalmente, los desarrolladores utilizaban herramientas como **Truffle** o **Hardhat**, que aunque eran populares, presentaban limitaciones en cuanto a rendimiento y facilidad de uso, especialmente en proyectos grandes.  

Aquí es donde aparece **Foundry**:  

✅ **Más ligero**  
✅ **Más rápido**  
✅ **Menos dependencias externas**  
✅ **Mayor integración con la EVM**  

Con Foundry, puedes gestionar todo el ciclo de vida de un contrato inteligente: **compilación, pruebas, despliegue e interacción**, sin necesidad de herramientas adicionales.  

📌 **Dato curioso:** Todo el ecosistema de Foundry está escrito en **Rust**.  

---

## **3. Forge**  

**Forge** es la principal herramienta dentro de Foundry. Su función es compilar, probar y desplegar contratos inteligentes.  

Podemos compararlo con:  
- **`npm`** en JavaScript  
- **`poetry`** en Python  
- **`cargo`** en Rust  

### **Comandos básicos de Forge**  

Para ver los comandos disponibles en Forge, ejecuta:  

```bash
$ forge
```  

---

## **4. Anvil**  

**Anvil** es fundamental para simular un entorno blockchain local.  

🔹 **¿Para qué sirve?**  
Permite probar contratos y transacciones sin necesidad de interactuar con la mainnet o una testnet pública.  

🔹 **Ejemplo de uso:**  

```bash
$ anvil
```  

Esto iniciará una blockchain local en tu máquina. Desde allí, puedes desplegar contratos, enviar transacciones y probar escenarios sin riesgo.  

Si estás desarrollando un contrato complejo, es importante ejecutar pruebas localmente antes de interactuar con la blockchain real.  

---

## **5. Cast y Chisel**  

Ahora hablaremos de **Cast** y **Chisel**, herramientas auxiliares pero muy importantes dentro del ecosistema Foundry.  

### **Cast**  

**Cast** es una **herramienta de línea de comandos** que permite interactuar con contratos ya desplegados.  

🔹 **Ejemplo:**  
Si quieres verificar el saldo de un usuario en un contrato ERC20, puedes ejecutar:  

```bash
$ cast call <dirección_contrato> "balanceOf(address)" <dirección_usuario>
```  

Esto devuelve el saldo del usuario directamente en la terminal, sin necesidad de una interfaz gráfica.  

---

### **Chisel**  

**Chisel** es una herramienta **REPL (Read-Eval-Print Loop)**, que permite ejecutar comandos en tiempo real.  

🔹 **Ejemplo:**  

```bash
$ chisel
Welcome to Chisel! Type `!help` to show available commands.
$ 1 + 1
Type: uint256
├ Hex: 0x2
├ Hex (full word): 0x2
└ Decimal: 2
```  

Es un entorno interactivo donde puedes probar código y obtener resultados instantáneamente.  

---

## **6. Conclusión**  

Hoy hemos aprendido sobre:  
✔ **Historia de Foundry** y por qué se creó.  
✔ **Forge** → La herramienta central para compilar, probar y desplegar contratos.  
✔ **Anvil** → Un simulador de blockchain local para pruebas rápidas y seguras.  
✔ **Cast y Chisel** → Herramientas para interactuar con contratos y ejecutar código en tiempo real.  

Con estos conocimientos, ahora tienes una visión completa del **ecosistema Foundry** y cómo puede mejorar tu flujo de desarrollo en blockchain.  

---

## **7. Recapitulación**  

📌 **Hoy aprendimos:**  
1. **Historia de Foundry** y sus ventajas sobre Hardhat y Truffle.  
2. **Forge** → Herramienta para compilar, probar y desplegar contratos.  
3. **Anvil** → Simulador de blockchain local.  
4. **Cast y Chisel** → Herramientas para interacción con contratos y pruebas en tiempo real.  

---

## **8. Tarea para casa**  

✏ **Ejercicio práctico:**  

1. Instalar Foundry en tu máquina (si aún no lo hiciste).  
2. Crear un contrato inteligente en Solidity.  
3. Compilar y probarlo con **Forge**.  
4. Ejecutar **Anvil** y desplegarlo localmente.  
5. Interactuar con el contrato usando **Cast**.  

📌 **Anota tus dudas y experimenta todo lo posible**.  

---

## **9. Próxima clase**  

En la próxima clase, profundizaremos en **Forge**, exploraremos su interfaz de línea de comandos y configuraremos un proyecto desde cero.  

📅 **¡Nos vemos allí!** 🚀  
