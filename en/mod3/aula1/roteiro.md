# **Lesson 1: Migrating from Hardhat to Foundry**  

## **1. Introduction**  

👋 Welcome to **Module 3, Lesson 1** of the **Foundry 101** course!  

In this lesson, we will explore how to **migrate an existing Hardhat project to Foundry**, including its structure, test files, and deployment scripts.  

📌 **What we will cover today:**  
1️⃣ Comparing Hardhat and Foundry project structures.  
2️⃣ Setting up Foundry in an existing Hardhat project.  
3️⃣ Migrating tests from JavaScript to Solidity.  
4️⃣ Migrating deployment scripts.  

✅ **By the end of this lesson, you will have successfully migrated a Hardhat project to Foundry!**  

---

## **2. Comparing Hardhat and Foundry Project Structures**  

📌 **Typical Hardhat project structure:**  

```
hardhat-project/
├── contracts/         # Smart contracts
│   ├── Greeter.sol
├── scripts/           # Deployment scripts (JS/TS)
│   ├── deploy.js
├── test/              # Tests (JS/TS)
│   ├── greeter.test.js
├── hardhat.config.js  # Hardhat configuration
├── package.json       # Node.js dependencies
└── node_modules/      # Installed packages
```

📌 **Typical Foundry project structure:**  

```
foundry-project/
├── src/               # Smart contracts
│   ├── Greeter.sol
├── script/            # Deployment scripts (Solidity)
│   ├── Deploy.s.sol
├── test/              # Tests (Solidity)
│   ├── Greeter.t.sol
├── foundry.toml       # Foundry configuration
└── lib/               # External dependencies
```

✅ **Key differences:**  
- Foundry **does not use JavaScript/TypeScript** for tests or scripts.  
- Foundry compiles and tests contracts using **native Solidity** instead of JavaScript.  

---

## **3. Setting Up Foundry in an Existing Hardhat Project**  

📌 **Step 1: Install Foundry**  

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

📌 **Step 2: Initialize a Foundry project inside the Hardhat project**  

```bash
forge init foundry-migration
cd foundry-migration
```

✅ **Now you have a Foundry project inside your Hardhat directory.**  

📌 **Step 3: Move your Solidity contracts to the Foundry `src/` folder**  

```bash
mv ../hardhat-project/contracts/* src/
```

✅ **Your smart contracts are now inside the Foundry project.**  

📌 **Step 4: Remove Hardhat dependencies (optional)**  

```bash
rm -rf ../hardhat-project/node_modules ../hardhat-project/package.json ../hardhat-project/hardhat.config.js
```

✅ **Now the Hardhat project is no longer needed.**  

---

## **4. Migrating Tests from JavaScript to Solidity**  

### **📌 Example: Hardhat JavaScript Test**  

📌 **Original Hardhat test (`test/greeter.test.js`):**  

```javascript
const { expect } = require("chai");

describe("Greeter", function () {
  it("Should return the new greeting", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, Hardhat!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, Hardhat!");
  });
});
```

📌 **Equivalent Foundry test in Solidity (`test/Greeter.t.sol`):**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Greeter.sol";

contract GreeterTest is Test {
    Greeter greeter;

    function setUp() public {
        greeter = new Greeter("Hello, Foundry!");
    }

    function testGreet() public {
        assertEq(greeter.greet(), "Hello, Foundry!");
    }
}
```

✅ **Key differences:**  
- Hardhat uses **JavaScript** (`chai` and `ethers.js`) for testing.  
- Foundry uses **native Solidity tests** (`forge-std/Test.sol`).  
- No need for `ethers.getContractFactory()` – contracts are directly instantiated in Solidity.  

📌 **Run the Foundry test:**  

```bash
forge test
```

✅ **Foundry executes tests faster than Hardhat!**  

---

## **5. Migrating Deployment Scripts**  

### **📌 Example: Hardhat JavaScript Deployment Script**  

📌 **Original Hardhat script (`scripts/deploy.js`):**  

```javascript
const hre = require("hardhat");

async function main() {
  const Greeter = await hre.ethers.getContractFactory("Greeter");
  const greeter = await Greeter.deploy("Hello, Hardhat!");

  console.log("Greeter deployed to:", greeter.address);
}

main();
```

📌 **Equivalent Foundry script in Solidity (`script/Deploy.s.sol`):**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/Greeter.sol";

contract DeployGreeter is Script {
    function run() external {
        vm.startBroadcast();
        new Greeter("Hello, Foundry!");
        vm.stopBroadcast();
    }
}
```

✅ **Key differences:**  
- Hardhat uses **JavaScript scripts** with `ethers.js`.  
- Foundry uses **Solidity scripts** with `forge-std/Script.sol`.  

📌 **Run the Foundry script to deploy the contract:**  

```bash
forge script script/Deploy.s.sol --broadcast --rpc-url http://127.0.0.1:8545
```

✅ **This deploys the contract using Foundry’s scripting system.**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **The differences between Hardhat and Foundry project structures.**  
✔ **How to set up Foundry inside an existing Hardhat project.**  
✔ **How to migrate tests from JavaScript to Solidity.**  
✔ **How to convert Hardhat deployment scripts to Foundry scripts.**  

✅ **Now you can migrate any Hardhat project to Foundry with ease!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **Foundry projects use Solidity for testing and scripting (no JavaScript).**  
2. **Tests in Foundry are written in `test/` using `forge-std/Test.sol`.**  
3. **Deployment scripts in Foundry use `forge-std/Script.sol`.**  
4. **`forge test` runs tests significantly faster than Hardhat.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Migrate a Hardhat project to Foundry following today’s lesson.**  
2. **Rewrite at least one Hardhat test in Solidity using Foundry.**  
3. **Rewrite a JavaScript deployment script as a Foundry Solidity script.**  
4. **Run `forge test --gas-report` and compare gas usage between Hardhat and Foundry.**  

📌 **Experiment and observe the performance improvements!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will learn how to securely store and manage private keys using Cast Wallet.**  

🚀 **See you there!**  