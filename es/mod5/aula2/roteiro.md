# **Clase 2: Uso Avanzado de Chisel**  

## **1. Apertura**  

¡Bienvenido a la **segunda clase sobre Chisel**! Hoy exploraremos cómo utilizar Chisel de manera más avanzada, manipulando sesiones, estructuras de datos y depurando el estado de la EVM.  

📌 **Lo que aprenderemos hoy:**  

1. **Gestión de sesiones en Chisel** → `!load`, `!list`, `!clearcache`, `!export`.  
2. **Uso de arrays, mappings, structs y enums** en Solidity dentro de Chisel.  
3. **Creación y prueba de funciones, contratos y eventos.**  
4. **Depuración con `!stackdump`, `!memdump`, `!rawstack`**.  

✅ **¡Vamos a ello!** 🚀  

---

## **2. Gestión de Sesiones en Chisel**  

Podemos trabajar en varias sesiones en Chisel, guardarlas y recargarlas más tarde.  

### **📌 Listar Sesiones Guardadas**  

```bash
!list
```

✅ **Muestra todas las sesiones almacenadas en caché.**  

---

### **📌 Cargar una Sesión Anterior**  

```bash
!load 101
```

✅ **Carga una sesión previamente guardada para continuar trabajando en ella.**  

---

### **📌 Guardar una Sesión**  

```bash
!save 202
```

✅ **Guarda el estado actual de la sesión Chisel.**  

---

### **📌 Limpiar el Caché de Sesiones**  

```bash
!clearcache
```

✅ **Elimina todas las sesiones almacenadas.**  

---

### **📌 Exportar Código a Foundry**  

```bash
!export
```

✅ **Guarda el código de la sesión en `scripts/` dentro del proyecto Foundry.**  

---

## **3. Uso de Arrays, Mappings, Structs y Enums**  

Podemos crear estructuras de datos avanzadas en Solidity dentro de Chisel.  

---

### **📌 Arrays en Chisel**  

```solidity
uint256[] public numeros;
numeros.push(10);
numeros[0];
numeros.length;
```

✅ **Crea y manipula arrays dinámicos en Chisel.**  

---

### **📌 Mappings en Chisel**  

```solidity
mapping(address => uint256) public saldos;
saldos[address(0x22)] = 123;
saldos[address(0x22)];
```

✅ **Los mappings permiten almacenar valores asociados a claves específicas.**  

---

### **📌 Structs en Chisel**  

```solidity
struct Persona {
    string nombre;
    uint256 edad;
}
Persona memory p = Persona("Juan", 30);
```

✅ **Permiten definir tipos de datos personalizados.**  

---

### **📌 Enums en Chisel**  

```solidity
enum Estado {
    Activo,
    Inactivo,
    Suspendido
}
Estado e = Estado.Activo;
uint(e);
```

✅ **Los enums ayudan a representar estados predefinidos en Solidity.**  

---

## **4. Creación de Funciones, Contratos y Eventos**  

Podemos escribir y probar contratos directamente en Chisel.  

### **📌 Función de Suma**  

```solidity
function suma(uint256 a, uint256 b) public pure returns (uint256) {
    return a + b;
}
suma(5, 10);
```

✅ **Ejecuta funciones sin necesidad de compilar un contrato.**  

---

### **📌 Creación de un Contrato Counter**  

```solidity
contract Counter {
    uint256 public count;
    
    event Incremento(uint256 nuevoValor);
    
    function increment() public {
        count += 1;
        emit Incremento(count);
    }
}

Counter c = new Counter();
c.increment();
c.count();
```

✅ **Crea e interactúa con contratos en tiempo real.**  

---

### **📌 Captura de Eventos en Chisel**  

Para ver eventos emitidos en el contrato, activamos `!traces`:  

```bash
!traces
```

✅ **Permite analizar las transacciones dentro de Chisel.**  

---

## **5. Depuración con Stack y Memoria**  

Podemos inspeccionar el estado de la EVM con herramientas avanzadas.  

📌 **`!stackdump` → Ver el estado de la pila (stack)**  

```bash
!stackdump
```

📌 **`!memdump` → Ver el estado de la memoria**  

```bash
!memdump
```

📌 **`!rawstack` → Inspeccionar la pila en tiempo real**  

```bash
!rawstack
```

✅ **Estas herramientas permiten un análisis detallado del comportamiento del contrato.**  

---

## **6. Conclusión**  

📌 **Hoy aprendimos:**  
✔ **Cómo gestionar sesiones en Chisel (`!save`, `!load`, `!export`).**  
✔ **Cómo trabajar con arrays, mappings, structs y enums.**  
✔ **Cómo crear y probar contratos, funciones y eventos.**  
✔ **Cómo depurar la memoria y la pila de la EVM en tiempo real.**  

✅ **Con estas herramientas, podrás desarrollar y probar contratos de forma más eficiente.**  

---

## **7. Recapitulación**  

📌 **Resumen de la clase:**  
1. **Gestión de sesiones en Chisel.**  
2. **Manipulación de estructuras de datos en Solidity.**  
3. **Creación y prueba de contratos y eventos.**  
4. **Depuración de la EVM en tiempo real.**  

---

## **8. Tarea para Casa**  

✏ **Ejercicio práctico:**  

1. **Crea un contrato en Chisel** que almacene un array de direcciones.  
2. **Prueba la captura de eventos** activando `!traces`.  
3. **Usa `!stackdump` y `!memdump`** para analizar la ejecución del contrato.  

📌 **Toma notas de los resultados y experimenta lo máximo posible.**  

---

## **9. Próxima Clase**  

📅 **En la próxima clase, exploraremos cómo usar Chisel para depurar contratos más complejos y analizar la ejecución de transacciones en profundidad.**  

🚀 **¡Nos vemos allí!**  
