# **Lesson 1: Setup and Getting Started**  

## **1. Introduction**  

👋 Welcome to **Module 1, Lesson 1** of the **Foundry 101** course!  

In this first class, we will set up your **Foundry development environment**, install all necessary dependencies, and write your **first smart contract** using Foundry.  

📌 **What we will cover today:**  
1️⃣ What is Foundry, and why use it?  
2️⃣ Installing Foundry and setting up the environment.  
3️⃣ Creating your first smart contract.  
4️⃣ Running your first tests.  

✅ **By the end of this lesson, you will have a fully functional Foundry setup and be ready to start developing smart contracts.**  

---

## **2. What is Foundry and Why Use It?**  

### **📌 Foundry vs. Other Smart Contract Frameworks**  

Foundry is a **powerful development framework** for **Ethereum smart contracts**, written in **Rust** and optimized for **speed and efficiency**.  

🚀 **Why use Foundry?**  
✅ **Faster than Hardhat and Truffle** – Executes tests in milliseconds.  
✅ **Native Solidity Testing** – No need for JavaScript; tests are written in Solidity.  
✅ **Built-in Debugging Tools** – Includes **Anvil**, a local blockchain, and **Cast**, a CLI for interacting with contracts.  
✅ **Optimized for Gas and Performance** – Integrated gas reporting and optimizations.  

📌 **Foundry provides an all-in-one solution for Solidity developers, offering tools for compiling, testing, and deploying contracts efficiently.**  

---

## **3. Installing Foundry**  

📌 **To install Foundry, run the following command:**  

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

✅ **This will install Foundry and its dependencies.**  

📌 **Verify that Foundry was installed correctly:**  

```bash
forge --version
```

✅ **Expected output:**  

```
forge 0.2.0 (commit hash)
```

📌 **If you encounter errors, try running:**  

```bash
foundryup
```

This ensures that you have the latest Foundry version.  

---

## **4. Creating Your First Foundry Project**  

📌 **Step 1: Initialize a new project**  

```bash
forge init my-foundry-project
cd my-foundry-project
```

✅ **This will create the following project structure:**  

```
my-foundry-project/
├── src/              # Smart contracts
│   ├── Counter.sol   # Example contract
├── script/           # Deployment scripts
├── test/             # Solidity tests
│   ├── Counter.t.sol # Example test
├── foundry.toml      # Configuration file
└── lib/              # External dependencies
```

---

## **5. Writing Your First Smart Contract**  

📌 **Open `src/Counter.sol` and replace it with this code:**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    uint256 public count;

    function increment() public {
        count += 1;
    }

    function decrement() public {
        count -= 1;
    }
}
```

✅ **This contract includes:**  
- `increment()` → Increases the counter by 1.  
- `decrement()` → Decreases the counter by 1.  

---

## **6. Writing a Test in Solidity**  

📌 **Create a test file in `test/Counter.t.sol` and add:**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    Counter counter;

    function setUp() public {
        counter = new Counter();
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.count(), 1);
    }

    function testDecrement() public {
        counter.increment();
        counter.decrement();
        assertEq(counter.count(), 0);
    }
}
```

✅ **Explanation:**  
- **`setUp()`** → Runs before each test, deploying the contract.  
- **`testIncrement()`** → Calls `increment()` and checks if `count == 1`.  
- **`testDecrement()`** → Calls `increment()`, then `decrement()`, and verifies if `count == 0`.  

---

## **7. Running Your First Tests**  

📌 **To run tests, execute:**  

```bash
forge test
```

✅ **Expected output:**  

```
[PASS] testIncrement() (gas: 25000)
[PASS] testDecrement() (gas: 26000)
```

📌 **To enable gas reporting:**  

```bash
forge test --gas-report
```

✅ **This provides insights into gas consumption for each function.**  

---

## **8. Conclusion**  

📌 **Today we learned:**  
✔ **What Foundry is and why it is better than other frameworks.**  
✔ **How to install Foundry and set up a project.**  
✔ **How to write and deploy a smart contract.**  
✔ **How to write Solidity tests and execute them.**  

✅ **Now you have a working Foundry environment and are ready for more advanced topics!**  

---

## **9. Summary**  

📌 **Today's key takeaways:**  
1. **Installed Foundry** using `foundryup`.  
2. **Created a Foundry project** using `forge init`.  
3. **Wrote a basic Solidity smart contract** (`Counter.sol`).  
4. **Created Solidity unit tests** in `Counter.t.sol`.  
5. **Executed tests and analyzed gas costs** using `forge test --gas-report`.  

---

## **10. Homework**  

✏ **Practice Exercises:**  
1. **Modify the `Counter` contract** to allow increments of custom values.  
2. **Write a new test** to verify the modified contract.  
3. **Run the tests and analyze gas consumption.**  

📌 **Take notes on your results and experiment as much as possible.**  

---

## **11. Next Lesson**  

📅 **In the next lesson, we will explore the structure of a Foundry project and how to manage dependencies effectively.**  

🚀 **See you there!**  