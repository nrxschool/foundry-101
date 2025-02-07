# **Lesson 1: CLI and Running a Local Blockchain with Anvil**  

## **1. Introduction**  

👋 Welcome to **Module 2, Lesson 1** of the **Foundry 101** course!  

In this lesson, we will explore **Anvil**, Foundry’s built-in local blockchain, and learn how to use the **Cast CLI** to interact with it.  

📌 **What we will cover today:**  
1️⃣ What is Anvil, and why use it?  
2️⃣ Running a local blockchain with Anvil.  
3️⃣ Using Cast to interact with the blockchain.  
4️⃣ Querying account balances, transactions, and blocks.  

✅ **By the end of this lesson, you will know how to set up and interact with a local blockchain using Anvil!**  

---

## **2. What is Anvil?**  

📌 **Anvil is a fast and lightweight local blockchain for Ethereum development, included in Foundry.**  

🚀 **Why use Anvil?**  
✅ **Fast** – Starts in milliseconds.  
✅ **Lightweight** – No need for external dependencies like Ganache or Hardhat.  
✅ **Feature-rich** – Supports forking, impersonation, and custom RPC calls.  

📌 **Anvil is similar to Ganache but optimized for Foundry.**  

---

## **3. Running a Local Blockchain with Anvil**  

📌 **To start Anvil, run:**  

```bash
anvil
```

✅ **Expected output:**  

```
Available Accounts
==================
(0) 0xF39F... (10000 ETH)
(1) 0x7099... (10000 ETH)
...
```

📌 **Each address is pre-funded with 10,000 ETH (test ETH).**  

---

### **📌 Customizing Anvil**  

You can customize Anvil by using flags:  

- **Set a specific port:**  
  ```bash
  anvil --port 8546
  ```
- **Set a custom chain ID:**  
  ```bash
  anvil --chain-id 1337
  ```
- **Disable mining interval (instant transactions):**  
  ```bash
  anvil --no-mining
  ```

✅ **Customize Anvil according to your development needs!**  

---

## **4. Interacting with Anvil Using Cast**  

📌 **Cast is a CLI tool for querying blockchain data and sending transactions.**  

### **📌 Checking the Latest Block Number**  

```bash
cast block-number --rpc-url http://127.0.0.1:8545
```

✅ **Returns the latest block number in the chain.**  

---

### **📌 Checking an Account’s Balance**  

```bash
cast balance 0xF39F... --rpc-url http://127.0.0.1:8545
```

✅ **Returns the balance of the specified address.**  

📌 **To convert from Wei to ETH:**  

```bash
cast balance 0xF39F... --ether --rpc-url http://127.0.0.1:8545
```

---

### **📌 Sending a Transaction**  

```bash
cast send --private-key 0xYourPrivateKey 0xRecipientAddress --value 1ether --rpc-url http://127.0.0.1:8545
```

✅ **Sends 1 ETH from your account to another.**  

📌 **To check the transaction status:**  

```bash
cast tx 0xTransactionHash --rpc-url http://127.0.0.1:8545
```

✅ **Returns transaction details, including gas used and sender/receiver addresses.**  

---

## **5. Querying Blockchain Data with Cast**  

📌 **Check details of a block:**  

```bash
cast block latest --rpc-url http://127.0.0.1:8545
```

✅ **Returns block details, including timestamp, transactions, and miner.**  

📌 **Check a specific storage slot of a contract:**  

```bash
cast storage 0xContractAddress 0 --rpc-url http://127.0.0.1:8545
```

✅ **Returns the stored value in a contract’s storage slot.**  

📌 **Decode transaction calldata to understand function calls:**  

```bash
cast calldata-decode "transfer(address,uint256)" 0xa9059cbb...
```

✅ **Useful for analyzing contract interactions.**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **What Anvil is and why it’s useful for local development.**  
✔ **How to start and configure Anvil.**  
✔ **How to use Cast to query blockchain data.**  
✔ **How to send transactions and interact with contracts using Cast.**  

✅ **Now you can run a local blockchain and interact with it efficiently!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **`anvil` starts a local blockchain for development.**  
2. **`cast block-number` gets the latest block number.**  
3. **`cast balance` checks an account’s balance.**  
4. **`cast send` sends ETH between accounts.**  
5. **`cast storage` and `cast calldata-decode` help analyze contracts.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Start Anvil and create a new transaction.**  
2. **Use Cast to check the balance before and after the transaction.**  
3. **Analyze a transaction’s calldata using `cast calldata-decode`.**  

📌 **Try different Cast commands and explore blockchain data!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will deploy smart contracts locally using Anvil and Foundry.**  

🚀 **See you there!**  