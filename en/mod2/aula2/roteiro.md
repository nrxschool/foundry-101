# **Lesson 2: Local Deployment with Anvil**  

## **1. Introduction**  

👋 Welcome to **Module 2, Lesson 2** of the **Foundry 101** course!  

In this lesson, we will learn how to **deploy smart contracts locally** using **Foundry and Anvil**.  

📌 **What we will cover today:**  
1️⃣ Deploying a contract on Anvil.  
2️⃣ Using Cast to interact with the deployed contract.  
3️⃣ Automating deployments with Foundry scripts.  

✅ **By the end of this lesson, you will know how to deploy smart contracts locally and interact with them using Foundry and Cast!**  

---

## **2. Deploying a Contract on Anvil**  

📌 **First, start Anvil in a terminal:**  

```bash
anvil
```

✅ **This launches a local blockchain at `http://127.0.0.1:8545`.**  

📌 **Now, let’s compile our contract:**  

```bash
forge build
```

✅ **Expected output:**  

```
[✓] Compiled 1 contracts
```

---

### **📌 Deploying with `forge create`**  

📌 **To deploy a contract manually, run:**  

```bash
forge create --rpc-url http://127.0.0.1:8545 --private-key 0xYourPrivateKey src/Counter.sol:Counter
```

✅ **This deploys the `Counter` contract on Anvil.**  

📌 **Expected output:**  

```
Deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
```

---

## **3. Interacting with the Deployed Contract**  

📌 **Check the contract’s storage:**  

```bash
cast storage 0x5FbDB2315678afecb367f032d93F642f64180aa3 0 --rpc-url http://127.0.0.1:8545
```

✅ **This returns the value stored in the contract’s first storage slot.**  

---

### **📌 Calling a Function with Cast**  

📌 **Get the current `count` value:**  

```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "count()(uint256)" --rpc-url http://127.0.0.1:8545
```

✅ **Returns `0`, since the counter starts at zero.**  

📌 **Increment the counter:**  

```bash
cast send --private-key 0xYourPrivateKey 0x5FbDB2315678afecb367f032d93F642f64180aa3 "increment()" --rpc-url http://127.0.0.1:8545
```

✅ **Calls `increment()`, increasing the counter by 1.**  

📌 **Check the updated `count`:**  

```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "count()(uint256)" --rpc-url http://127.0.0.1:8545
```

✅ **The result should now be `1`.**  

---

## **4. Automating Deployments with Foundry Scripts**  

📌 **Instead of deploying manually, we can automate deployment with Foundry scripts.**  

📌 **Create a new file `script/DeployCounter.s.sol`:**  

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

📌 **Execute the script:**  

```bash
forge script script/DeployCounter.s.sol --broadcast --rpc-url http://127.0.0.1:8545
```

✅ **This deploys the contract using Foundry’s built-in scripting system.**  

📌 **To deploy on a testnet, change the RPC URL:**  

```bash
forge script script/DeployCounter.s.sol --broadcast --rpc-url https://sepolia.infura.io/v3/YOUR_API_KEY
```

✅ **This deploys the contract to Sepolia.**  

---

## **5. Conclusion**  

📌 **Today we learned:**  
✔ **How to deploy smart contracts on Anvil using `forge create`.**  
✔ **How to interact with deployed contracts using Cast.**  
✔ **How to automate deployments with Foundry scripts.**  

✅ **Now you can deploy and interact with contracts locally using Foundry and Anvil!**  

---

## **6. Summary**  

📌 **Today's key takeaways:**  
1. **Start Anvil with `anvil` to run a local blockchain.**  
2. **Use `forge create` to deploy a contract manually.**  
3. **Use Cast to interact with deployed contracts (`cast call`, `cast send`).**  
4. **Automate deployments with Foundry scripts (`forge script --broadcast`).**  

---

## **7. Homework**  

✏ **Practice Exercises:**  
1. **Modify the `Counter` contract** to set an initial value at deployment.  
2. **Write a script to deploy and interact with the modified contract.**  
3. **Deploy the contract on a public testnet using Foundry scripts.**  

📌 **Experiment and test different deployment strategies!**  

---

## **8. Next Lesson**  

📅 **In the next lesson, we will explore how to create and manage local forks using Anvil.**  

🚀 **See you there!**  