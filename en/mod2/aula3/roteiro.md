# **Lesson 3: Local Forks with Anvil**  

## **1. Introduction**  

👋 Welcome to **Module 2, Lesson 3** of the **Foundry 101** course!  

In this lesson, we will learn how to **fork the Ethereum mainnet or testnets** locally using **Anvil**. This allows us to test our contracts **against real blockchain data** without deploying them on the mainnet.  

📌 **What we will cover today:**  
1️⃣ What is a blockchain fork, and why use it?  
2️⃣ Creating a local fork with Anvil.  
3️⃣ Using Cast to interact with real contracts in a fork.  
4️⃣ Testing smart contracts in a forked environment.  

✅ **By the end of this lesson, you will know how to create a local fork and test transactions against real blockchain data!**  

---

## **2. What Is a Blockchain Fork?**  

A **fork** is a copy of the blockchain at a specific point in time.  

📌 **Why fork the blockchain?**  
✅ **Test transactions with real contract data** without spending real ETH.  
✅ **Simulate interactions with DeFi protocols** like Uniswap, Aave, or Compound.  
✅ **Debug and analyze smart contracts** before deploying to mainnet.  

✅ **Anvil allows you to fork the blockchain locally using real Ethereum state.**  

---

## **3. Creating a Local Fork with Anvil**  

📌 **To fork Ethereum Mainnet, run:**  

```bash
anvil --fork-url https://mainnet.infura.io/v3/YOUR_INFURA_API_KEY
```

✅ **This forks the Ethereum blockchain using Infura as an RPC provider.**  

📌 **To fork Sepolia (testnet), use:**  

```bash
anvil --fork-url https://sepolia.infura.io/v3/YOUR_INFURA_API_KEY
```

✅ **Now Anvil simulates the real blockchain locally.**  

---

## **4. Using Cast to Interact with Real Contracts**  

📌 **Get the latest block number of the forked chain:**  

```bash
cast block-number --rpc-url http://127.0.0.1:8545
```

✅ **This should return the latest block from the Ethereum network.**  

📌 **Check the balance of a real Ethereum address:**  

```bash
cast balance 0x742d35Cc6634C0532925a3b844Bc454e4438f44e --rpc-url http://127.0.0.1:8545
```

✅ **This shows the balance of an Ethereum whale address.**  

---

### **📌 Impersonating an Account**  

We can impersonate a real Ethereum address and send transactions **without having the private key**.  

📌 **Example: Sending ETH as an impersonated address**  

```bash
cast send --rpc-url http://127.0.0.1:8545 --from 0x742d35Cc6634C0532925a3b844Bc454e4438f44e --value 1ether 0xRecipientAddress
```

✅ **This sends 1 ETH from the impersonated account without needing its private key.**  

📌 **Enable account impersonation in a Foundry test:**  

```solidity
vm.prank(0x742d35Cc6634C0532925a3b844Bc454e4438f44e);
contractInstance.someFunction();
```

✅ **This allows us to test functions as if they were executed by a real Ethereum address.**  

---

## **5. Testing Smart Contracts in a Forked Environment**  

### **📌 Example: Testing a Real ERC-20 Token**  

📌 **Check the balance of a real DAI holder:**  

```bash
cast call 0x6B175474E89094C44Da98b954EedeAC495271d0F "balanceOf(address)(uint256)" 0x742d35Cc6634C0532925a3b844Bc454e4438f44e --rpc-url http://127.0.0.1:8545
```

✅ **This queries the DAI balance of a real Ethereum whale address.**  

---

### **📌 Example: Sending ERC-20 Tokens in a Fork**  

📌 **Send 100 DAI from a whale account to another address:**  

```bash
cast send 0x6B175474E89094C44Da98b954EedeAC495271d0F "transfer(address,uint256)" 0xRecipientAddress 100000000000000000000 --from 0x742d35Cc6634C0532925a3b844Bc454e4438f44e --rpc-url http://127.0.0.1:8545
```

✅ **This transfers 100 DAI using impersonation.**  

---

### **📌 Writing a Foundry Test for a Forked Environment**  

📌 **Example: Testing Uniswap Swap on a Fork**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract ForkTest is Test {
    address uniswapRouter = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address weth = 0xC02aaa39b223FE8D0A0E5C4F27eaD9083C756Cc2;

    function setUp() public {
        vm.createSelectFork("https://mainnet.infura.io/v3/YOUR_INFURA_API_KEY");
    }

    function testSwapEthForDai() public {
        vm.prank(0x742d35Cc6634C0532925a3b844Bc454e4438f44e); // Impersonate an address

        IUniswapV2Router02 router = IUniswapV2Router02(uniswapRouter);new address[](2);
        path[0] = weth;
        path[1] = dai;

        router.swapExactETHForTokens{value: 1 ether}(0, path, address(this), block.timestamp + 15);
    }
}
```

📌 **To run this test:**  

```bash
forge test --fork-url https://mainnet.infura.io/v3/YOUR_INFURA_API_KEY
```

✅ **This executes a Uniswap swap using a forked mainnet state.**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **What a blockchain fork is and why it’s useful.**  
✔ **How to create a local fork with Anvil.**  
✔ **How to interact with real Ethereum contracts using Cast.**  
✔ **How to test smart contracts using forked data.**  

✅ **Now you can simulate mainnet interactions without spending real ETH!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **Use `anvil --fork-url` to create a forked blockchain.**  
2. **Use `cast balance`, `cast call`, and `cast send` to interact with real contracts.**  
3. **Impersonate accounts using `vm.prank()` in Foundry tests.**  
4. **Write and execute smart contract tests using forked mainnet data.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Fork the Ethereum blockchain locally using Anvil.**  
2. **Query the balance of a real Ethereum whale address.**  
3. **Impersonate an account and execute a transaction.**  
4. **Write a Foundry test that interacts with Uniswap or Aave on a forked network.**  

📌 **Experiment and analyze real contract interactions!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will explore debugging smart contracts using Foundry and Anvil.**  

🚀 **See you there!**  