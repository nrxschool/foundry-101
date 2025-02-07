# **Lesson 2: Foundry Project Structure**  

## **1. Introduction**  

👋 Welcome to **Module 1, Lesson 2** of the **Foundry 101** course!  

Now that you have installed Foundry and written your first smart contract, let's explore the **structure of a Foundry project** and understand how to organize contracts, scripts, and tests.  

📌 **What we will cover today:**  
1️⃣ Understanding the Foundry project structure.  
2️⃣ The role of each directory and file.  
3️⃣ Managing dependencies with Foundry.  
4️⃣ Customizing the `foundry.toml` configuration file.  

✅ **By the end of this lesson, you will have a well-organized Foundry project and understand how to manage dependencies.**  

---

## **2. Foundry Project Structure**  

📌 **When you create a new Foundry project using `forge init`, it generates the following structure:**  

```
my-foundry-project/
├── src/              # Smart contracts
│   ├── Counter.sol   # Example contract
├── script/           # Deployment scripts
│   ├── Deploy.s.sol  # Example script
├── test/             # Solidity tests
│   ├── Counter.t.sol # Example test
├── foundry.toml      # Configuration file
├── lib/              # External dependencies
└── out/              # Compiled contract artifacts (auto-generated)
```

✅ **Each folder has a specific function, which we will now explore in detail.**  

---

## **3. Understanding Each Directory**  

### **📌 `src/` - Smart Contracts**  

This folder contains all the **Solidity smart contracts** that make up your project.  

📌 **Example contract in `src/Counter.sol`:**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    uint256 public count;

    function increment() public {
        count += 1;
    }
}
```

✅ **This is where you write the core logic of your DApp.**  

---

### **📌 `script/` - Deployment Scripts**  

This folder contains **Solidity scripts** for deploying smart contracts. Unlike Hardhat, Foundry allows **writing deployment scripts in Solidity instead of JavaScript**.  

📌 **Example script in `script/Deploy.s.sol`:**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/Counter.sol";

contract DeployCounter is Script {
    function run() external {
        vm.startBroadcast();
        new Counter();
        vm.stopBroadcast();
    }
}
```

📌 **To execute the script and deploy the contract:**  

```bash
forge script script/Deploy.s.sol --broadcast --rpc-url http://127.0.0.1:8545
```

✅ **This will deploy the contract to a local or test network.**  

---

### **📌 `test/` - Solidity Tests**  

This folder contains **unit tests written in Solidity**.  

📌 **Example test in `test/Counter.t.sol`:**  

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
}
```

📌 **To run tests:**  

```bash
forge test
```

✅ **The `test/` folder is where you verify your contract logic.**  

---

### **📌 `lib/` - External Dependencies**  

📌 **Used to store external Solidity libraries, such as OpenZeppelin.**  

To **install** OpenZeppelin contracts:  

```bash
forge install OpenZeppelin/openzeppelin-contracts
```

This will create:  

```
lib/
└── openzeppelin-contracts/
```

📌 **To import OpenZeppelin contracts into your Solidity files:**  

```solidity
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
```

✅ **All external dependencies are managed in the `lib/` folder.**  

---

### **📌 `out/` - Compiled Artifacts**  

📌 **This folder is automatically generated after compilation and contains the ABI and bytecode of contracts.**  

To compile your contracts and generate this folder, run:  

```bash
forge build
```

✅ **This folder is useful when integrating with frontend applications.**  

---

## **4. Managing Dependencies in Foundry**  

📌 **To install external libraries:**  

```bash
forge install <github-repo>
```

✅ **Example:** Install OpenZeppelin:  

```bash
forge install OpenZeppelin/openzeppelin-contracts
```

📌 **To update dependencies:**  

```bash
forge update
```

📌 **To remove a dependency:**  

```bash
rm -rf lib/<dependency-name>
```

✅ **Foundry makes dependency management easy with its built-in package manager.**  

---

## **5. Customizing `foundry.toml`**  

📌 **The `foundry.toml` file is the configuration file for your project.**  

📌 **Example `foundry.toml`:**  

```toml
[profile.default]
solc_version = "0.8.24"
optimizer = true
optimizer_runs = 200
libs = ["lib"]
remappings = [
    "@openzeppelin/=lib/openzeppelin-contracts/"
]
```

📌 **Key configurations:**  
✅ **`solc_version`** → Solidity compiler version.  
✅ **`optimizer`** → Enables gas optimization.  
✅ **`optimizer_runs`** → Controls optimization level.  
✅ **`libs`** → Defines the folder where dependencies are stored.  
✅ **`remappings`** → Allows importing dependencies using aliases.  

📌 **To apply configuration changes, recompile the project:**  

```bash
forge build
```

✅ **Customizing `foundry.toml` allows you to optimize gas usage and manage libraries efficiently.**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **How a Foundry project is structured.**  
✔ **The role of each directory and file.**  
✔ **How to install and manage dependencies.**  
✔ **How to configure the `foundry.toml` file.**  

✅ **Now you understand how to structure your projects properly in Foundry!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **The `src/` folder contains smart contracts.**  
2. **The `script/` folder stores Solidity deployment scripts.**  
3. **The `test/` folder contains Solidity tests.**  
4. **The `lib/` folder manages external dependencies.**  
5. **The `foundry.toml` file allows project customization.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Modify the `Counter` contract** to allow setting a custom initial value.  
2. **Write a new test** to verify this feature.  
3. **Configure the optimizer settings in `foundry.toml` and analyze gas savings.**  

📌 **Experiment with different configurations and compare results!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will explore how to write advanced tests in Foundry and use debugging tools like Anvil and Cast.**  

🚀 **See you there!**  