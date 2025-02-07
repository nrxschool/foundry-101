# **Clase 1: Introducción a Chisel**  

## **1. Apertura**  

¡Bienvenido a nuestra primera clase sobre **Chisel**!  

**Chisel** es el **REPL** (*Read-Eval-Print Loop*) de **Foundry**, diseñado para Solidity. Permite probar rápidamente fragmentos de código, sin necesidad de compilar ni ejecutar pruebas completas.  

📌 **Lo que aprenderemos hoy:**  

1. **Qué es Chisel y cómo funciona.**  
2. **Comandos esenciales de Chisel.**  
3. **Ejecutar y probar código en Chisel.**  
4. **Exportar código e integrarlo con Foundry.**  

✅ **Chisel es una herramienta poderosa para el desarrollo ágil en Solidity. ¡Vamos a descubrirla!** 🚀  

---

## **2. Qué es Chisel y Cómo Funciona**  

📌 **¿Qué es un REPL?**  

Un **REPL** es un entorno interactivo que permite escribir código, ejecutarlo inmediatamente y ver el resultado.  

### **Ventajas de Chisel**  

✅ **Pruebas instantáneas** → Ejecuta fragmentos de código sin necesidad de compilar contratos completos.  
✅ **Depuración rápida** → Encuentra errores sin necesidad de realizar pruebas formales.  
✅ **Iteración ágil** → Modifica y prueba código en tiempo real.  

### **Iniciar Chisel**  

Para iniciar Chisel, ejecuta:  

```bash
chisel
```

📌 **Esto abrirá una consola interactiva donde podrás escribir código Solidity directamente.**  

---

## **3. Comandos Esenciales de Chisel**  

Chisel incluye comandos que facilitan la navegación y gestión del entorno de pruebas.  

### **📌 `!help` → Mostrar todos los comandos disponibles**  

```bash
!help
```

✅ **Lista todos los comandos y su descripción.**  

---

### **📌 `!source` → Ver el código generado en la sesión actual**  

```bash
!source
```

✅ **Muestra el código que ha sido ejecutado en la sesión de Chisel.**  

---

### **📌 `!clear` → Limpiar el entorno**  

```bash
!clear
```

✅ **Reinicia la sesión y borra el código ejecutado.**  

---

### **📌 `!save` → Guardar la sesión actual**  

```bash
!save 101
```

✅ **Guarda la sesión para poder retomarla más tarde.**  

---

## **4. Ejecutar Código en Chisel**  

📌 **Ejemplo: Definir Variables y Operaciones Matemáticas**  

```solidity
uint256 a = 42;
uint256 b = 58;
a + b;
```

📌 **Operaciones Booleanas**  

```solidity
bool isTrue = true;
bool isFalse = false;
isTrue && isFalse;
```

📌 **Manejo de Ether y Wei**  

```solidity
1 ether == 1e18 wei;
0.5 ether;
```

✅ **Chisel permite probar estas expresiones instantáneamente.**  

---

## **5. Exportar Código e Integrarlo con Foundry**  

📌 **Para exportar una sesión a un script en Foundry:**  

```bash
!export
```

✅ **Esto genera un archivo dentro del directorio `scripts/` del proyecto Foundry.**  

📌 **Chisel hereda la configuración del proyecto Foundry** → Incluye dependencias, versión de compilador y entorno de red.  

---

## **6. Conclusión**  

📌 **Hoy aprendimos:**  
✔ **Qué es Chisel y sus ventajas como REPL.**  
✔ **Comandos principales (`!help`, `!clear`, `!save`).**  
✔ **Cómo ejecutar código Solidity de manera interactiva.**  
✔ **Cómo exportar sesiones y usarlas en Foundry.**  

✅ **Chisel es una herramienta poderosa para agilizar el desarrollo y depuración de contratos en Solidity.**  

---

## **7. Recapitulación**  

📌 **Resumen de la clase:**  
1. **Introducción a Chisel** → ¿Qué es y cómo usarlo?  
2. **Comandos esenciales** → `!help`, `!clear`, `!save`, `!export`.  
3. **Ejecutar código en Chisel** → Variables, operaciones matemáticas y lógica booleana.  
4. **Exportar código** → Guardar sesiones y reutilizar en Foundry.  

---

## **8. Tarea para Casa**  

✏ **Ejercicio práctico:**  

1. **Prueba Chisel** → Define variables y prueba operaciones matemáticas.  
2. **Usa `!save` para guardar una sesión y `!load` para recuperarla.**  
3. **Exporta un código y revísalo en Foundry.**  

📌 **Toma notas de los resultados y experimenta lo máximo posible.**  

---

## **9. Próxima Clase**  

📅 **En la próxima clase, aprenderemos sobre funciones avanzadas de Chisel, incluyendo estructuras de datos como arrays, mappings y structs.**  

🚀 **¡Nos vemos allí!**  
