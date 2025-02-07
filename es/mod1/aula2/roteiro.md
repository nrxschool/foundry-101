# **Clase 2: Historia del EVM Tooling**  

## **1. Apertura**  

¡Hola! Bienvenido a la segunda clase del curso **Foundry 101**.  

Hoy hablaremos sobre la **Historia del EVM Tooling**, abordando las herramientas que ayudaron a moldear el desarrollo de contratos inteligentes en Ethereum.  

Hemos dividido esta clase en cuatro temas principales:  

### **Programación:**  
1. Introducción a la EVM  
2. Las primeras herramientas  
3. El impacto de Remix  
4. La era de los frameworks y el avance con Foundry  

---

## **2. Introducción a la EVM**  

📌 [Documentación Oficial](https://ethereum.org/pt-br/developers/docs/evm/#the-ethereum-state-transition-function)  

Primero, debemos entender qué es la **Ethereum Virtual Machine (EVM)**.  

La EVM es el entorno donde se ejecutan todos los contratos inteligentes en Ethereum. Funciona como una máquina virtual descentralizada que procesa transacciones y ejecuta contratos.  

Dado que la EVM es una máquina virtual, en teoría cualquier blockchain puede implementarla. Si una blockchain es **EVM-compatible**, significa que puede ejecutar smart contracts en Solidity o en cualquier otro lenguaje que compile para Solidity.  

Sin la EVM, no sería posible crear contratos inteligentes o DApps. Es por eso que las herramientas de desarrollo son tan importantes: facilitan la interacción y el despliegue de contratos en la EVM.  

---

## **3. Las Primeras Herramientas (2014-2017)**  

En los primeros días, las opciones eran bastante limitadas.  

📌 **Mist (2014)** → Fue una de las primeras herramientas, diseñada para ser un navegador de DApps y una interfaz para el desarrollo.  

📌 **Geth (2015)** → Permitió ejecutar un nodo de Ethereum y conectarse a la blockchain a través de una interfaz de línea de comandos (CLI).  

📌 **Solidity (2015)** → La creación de este lenguaje permitió el desarrollo de los primeros contratos inteligentes.  

Durante esta fase inicial, los desarrolladores enfrentaban muchas dificultades, ya que tenían que escribir numerosos scripts manuales para realizar tareas básicas como pruebas y despliegues de contratos. Era un comienzo prometedor, pero todavía muy rudimentario.  

---

## **4. Remix y la Revolución del IDE Web (2016-2018)**  

En 2016, surge **Remix**, una herramienta que revolucionó el desarrollo de contratos inteligentes.  

Con **Remix**, se hizo mucho más fácil escribir, probar y desplegar contratos inteligentes directamente desde el navegador, sin necesidad de herramientas externas complejas.  

Aunque Remix simplificó el proceso de desarrollo, tenía algunas limitaciones, especialmente en proyectos grandes y en la integración con otras herramientas.  

Sin embargo, marcó el inicio de una nueva era de entornos de desarrollo (IDEs) especializados en Ethereum.  

---

## **5. Hardhat, Truffle y el Avance con Foundry (2018-presente)**  

Con el crecimiento del ecosistema, surgieron frameworks más avanzados:  

📌 **Truffle (2018)** → Fue uno de los primeros frameworks completos para el desarrollo en Ethereum. Introdujo herramientas como **Ganache**, que permitía simular una blockchain local para pruebas.  

📌 **Hardhat (2020)** → Proporcionó una experiencia más modular y flexible, con la posibilidad de crear plugins y herramientas avanzadas de debugging.  

📌 **Brownie y ApeWorx** → Alternativas escritas en Python para el desarrollo en Ethereum.  

📌 **Foundry (2021)** → Una herramienta moderna, rápida y eficiente, con menos dependencias de JavaScript y mayor integración con la EVM.  

**Foundry** se ha convertido en una de las soluciones más completas y eficientes para desarrolladores de smart contracts.  

📌 [Hardhat](https://hardhat.org)  
📌 [Truffle](https://archive.trufflesuite.com)  
📌 [Brownie](https://github.com/eth-brownie)  
📌 [ApeWorx](https://apeworx.io)  
📌 [Foundry](https://getfoundry.sh)  

---

## **6. Conclusión**  

Hoy hemos visto cómo el **tooling** de la EVM ha evolucionado desde las primeras herramientas como **Mist** y **Geth** hasta llegar a **Foundry**.  

Cada nueva herramienta surgió para resolver desafíos específicos, haciendo el desarrollo más eficiente y accesible.  

**Pregunta para reflexión:** ¿Has utilizado alguna de estas herramientas antes? ¿Cuál fue tu experiencia?  

---

## **7. Recapitulación**  

1. Entendimos qué es la EVM.  
2. Vimos las primeras herramientas como **Mist** y **Geth**.  
3. Analizamos el impacto de **Remix** como un IDE web.  
4. Exploramos cómo **Truffle, Hardhat y Foundry** transformaron el desarrollo de contratos inteligentes.  

---

## **8. Tarea para casa**  

📌 Ve a la documentación oficial de **Foundry** y léela por encima.  

Vamos a trabajar con varios de los temas mencionados allí, así que si lo lees con anticipación, absorberás mejor el contenido.  

---

## **9. Próxima clase**  

En la próxima clase, nos enfocaremos en el **Ecosistema de Foundry**, exploraremos sus orígenes, fortalezas y las herramientas que lo componen.  

📅 ¡Nos vemos allí! 🚀  
