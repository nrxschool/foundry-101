# **Lesson 3: Integrating Foundry with ScaffoldETH2**  

## **1. Introduction**  

👋 Welcome to **Module 3, Lesson 3** of the **Foundry 101** course!  

In this lesson, we will explore how to **integrate Foundry with ScaffoldETH2**, a framework that simplifies the development of decentralized applications (**DApps**) by providing a **pre-configured frontend and smart contract environment**.  

📌 **What we will cover today:**  
1️⃣ What is ScaffoldETH2, and why use it?  
2️⃣ Installing and setting up ScaffoldETH2 with Foundry.  
3️⃣ Deploying a Foundry contract and connecting it to a frontend.  
4️⃣ Interacting with the contract through the UI.  

✅ **By the end of this lesson, you will have a full DApp setup using Foundry and ScaffoldETH2!**  

---

## **2. What is ScaffoldETH2?**  

📌 **ScaffoldETH2 is a framework for rapidly developing Ethereum DApps with a built-in frontend.**  

🚀 **Why use ScaffoldETH2?**  
✅ **Pre-configured frontend** → Includes React, Next.js, and wagmi hooks.  
✅ **Built-in smart contract UI** → Instantly interact with contracts.  
✅ **Works with Foundry, Hardhat, and other frameworks.**  

📌 **ScaffoldETH2 makes it easier to test and iterate on smart contracts.**  

---

## **3. Installing and Setting Up ScaffoldETH2**  

📌 **Step 1: Clone the ScaffoldETH2 repository**  

```bash
git clone https://github.com/scaffold-eth/scaffold-eth-2.git
cd scaffold-eth-2
```

📌 **Step 2: Install dependencies**  

```bash
pnpm install
```

📌 **Step 3: Remove Hardhat (since we are using Foundry)**  

```bash
rm -rf packages/hardhat
```

📌 **Step 4: Modify `package.json` to use Foundry**  

Find the `"contracts"` script and replace it with:  

```json
"contracts": "cd packages/foundry && forge build"
```

✅ **Now ScaffoldETH2 is configured to use Foundry instead of Hardhat.**  

---

## **4. Deploying a Foundry Contract in ScaffoldETH2**  

📌 **Step 1: Create the contract in Foundry**  

Inside `packages/foundry/src/`, create `Counter.sol`:  

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

📌 **Step 2: Compile the contract**  

```bash
forge build
```

📌 **Step 3: Start Anvil**  

```bash
anvil
```

📌 **Step 4: Deploy the contract using Foundry scripts**  

Create a new file `packages/foundry/script/DeployCounter.s.sol`:  

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

📌 **Deploy the contract:**  

```bash
forge script script/DeployCounter.s.sol --broadcast --rpc-url http://127.0.0.1:8545
```

✅ **Copy the deployed contract address for use in the frontend.**  

---

## **5. Connecting the Contract to the Frontend**  

📌 **Step 1: Add the contract to ScaffoldETH2’s config**  

Open `packages/nextjs/scaffold.config.ts` and add:  

```typescript
const contracts = {
  Counter: {
    address: "0x5FbDB2315678afecb367f032d93F642f64180aa3", // Replace with actual address
    abi: require("../foundry/out/Counter.sol/Counter.json").abi,
  },
};
export default contracts;
```

📌 **Step 2: Create a frontend component to interact with the contract**  

Inside `packages/nextjs/components/Counter.tsx`, add:  

```tsx
import { useScaffoldContractRead, useScaffoldContractWrite } from "~~/hooks/scaffold-eth";

const Counter = () => {
  const { data: count } = useScaffoldContractRead({
    contractName: "Counter",
    functionName: "count",
  });

  const { writeAsync: increment } = useScaffoldContractWrite({
    contractName: "Counter",
    functionName: "increment",
  });

  return (
    <div>
      <h2>Counter: {count?.toString()}</h2>
      <button onClick={() => increment()}>Increment</button>
    </div>
  );
};

export default Counter;
```

📌 **Step 3: Add the component to the main page**  

Modify `packages/nextjs/pages/index.tsx` and add:  

```tsx
import Counter from "~~/components/Counter";

export default function Home() {
  return (
    <div>
      <h1>My Foundry DApp</h1>
      <Counter />
    </div>
  );
}
```

📌 **Step 4: Start the frontend**  

```bash
pnpm dev
```

✅ **Open `http://localhost:3000` to see the DApp with an interactive Counter!**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **How to install and configure ScaffoldETH2 with Foundry.**  
✔ **How to deploy a Foundry contract and integrate it with a frontend.**  
✔ **How to use wagmi hooks to interact with a contract in React.**  
✔ **How to run a local DApp with ScaffoldETH2 and Anvil.**  

✅ **Now you can build full-stack DApps using Foundry and ScaffoldETH2!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **ScaffoldETH2 provides a pre-configured frontend for smart contracts.**  
2. **Modify `package.json` to use Foundry instead of Hardhat.**  
3. **Deploy contracts using Foundry scripts (`forge script`).**  
4. **Use wagmi hooks in React to interact with the contract.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Modify the `Counter` contract to allow decrementing and update the UI.**  
2. **Deploy another contract and add it to ScaffoldETH2’s config.**  
3. **Customize the frontend layout to match your project’s design.**  

📌 **Experiment with different contract interactions and UI components!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will learn how to interact with contracts using Cast.**  

🚀 **See you there!**  