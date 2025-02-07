# **Lesson 1: Reading and Writing with Cast**  

## **1. Introduction**  

👋 Welcome to **Module 4, Lesson 1** of the **Foundry 101** course!  

In this lesson, we will learn how to **read from and write to smart contracts** using **Cast**, Foundry's command-line interface (**CLI**). Cast allows us to interact with deployed contracts **without writing scripts**.  

📌 **What we will cover today:**  
1️⃣ What is Cast, and why use it?  
2️⃣ Reading contract data using Cast.  
3️⃣ Sending transactions and writing data to contracts.  
4️⃣ Verifying contract interactions.  

✅ **By the end of this lesson, you will know how to use Cast to interact with smart contracts efficiently!**  

---

## **2. What Is Cast and Why Use It?**  

📌 **Cast is Foundry’s CLI tool for interacting with Ethereum smart contracts.**  

🚀 **Why use Cast?**  
✅ **No need for JavaScript** – Interact directly with contracts.  
✅ **Faster than writing scripts** – Query data and send transactions instantly.  
✅ **Works with local and public networks** – Use it with Anvil, testnets, or mainnet.  

📌 **Cast simplifies contract interaction, making debugging and testing easier.**  

---

## **3. Reading Contract Data Using Cast**  

📌 **Example: Checking an Account Balance**  

```bash
cast balance 0xF39F... --rpc-url http://127.0.0.1:8545
```

✅ **This returns the ETH balance of the given address.**  

📌 **Example Output:**  

```
10.000000000000000000 ETH
```

---

### **📌 Reading a Public Variable from a Smart Contract**  

📌 **Example: Reading the `count` variable from a `Counter` contract**  

```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "count()(uint256)" --rpc-url http://127.0.0.1:8545
```

✅ **This queries the contract’s `count` variable and returns its value.**  

📌 **Example Output:**  

```
0
```

📌 **Explanation:**  
- `0x5FbDB...` → Contract address.  
- `"count()(uint256)"` → Function signature (`count()` returns a `uint256`).  
- `--rpc-url` → The blockchain endpoint to connect to.  

✅ **This works for any public view function in a Solidity contract.**  

---

## **4. Sending Transactions and Writing Data to Contracts**  

### **📌 Sending ETH to an Address**  

📌 **Example: Sending 1 ETH to another account**  

```bash
cast send --private-key 0xYourPrivateKey 0xRecipientAddress --value 1ether --rpc-url http://127.0.0.1:8545
```

✅ **This transfers 1 ETH securely.**  

📌 **Example Output:**  

```
Transaction submitted: 0xabc123...
```

🚨 **Never share your private key! Use Cast Wallet instead.**  

---

### **📌 Calling a Function That Modifies Contract State**  

📌 **Example: Calling `increment()` on a `Counter` contract**  

```bash
cast send --private-key 0xYourPrivateKey 0x5FbDB2315678afecb367f032d93F642f64180aa3 "increment()" --rpc-url http://127.0.0.1:8545
```

✅ **This executes `increment()`, increasing `count` by 1.**  

📌 **Verify the update by reading `count` again:**  

```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "count()(uint256)" --rpc-url http://127.0.0.1:8545
```

✅ **If `increment()` worked, the value should now be `1`.**  

---

## **5. Verifying Contract Interactions**  

### **📌 Checking Transaction Details**  

📌 **Example: Fetch transaction details**  

```bash
cast tx 0xTransactionHash --rpc-url http://127.0.0.1:8545
```

✅ **This returns the gas used, sender, recipient, and other transaction data.**  

📌 **Example Output:**  

```
Transaction Hash: 0xabc123...
From: 0xF39F...
To: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Gas Used: 21000
Function: increment()
```

✅ **This is useful for debugging failed transactions.**  

---

### **📌 Checking Smart Contract Storage Slots**  

📌 **Example: Inspecting the first storage slot of a contract**  

```bash
cast storage 0x5FbDB2315678afecb367f032d93F642f64180aa3 0 --rpc-url http://127.0.0.1:8545
```

✅ **This returns the value stored in slot `0`.**  

📌 **Example Output:**  

```
0x0000000000000000000000000000000000000000000000000000000000000001
```

✅ **This is useful for debugging contract storage layouts.**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **How to read smart contract data using `cast call`.**  
✔ **How to send transactions with `cast send`.**  
✔ **How to verify transactions using `cast tx`.**  
✔ **How to inspect smart contract storage with `cast storage`.**  

✅ **Now you can interact with Ethereum smart contracts efficiently using Cast!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **Use `cast call` to query smart contract data.**  
2. **Use `cast send` to execute transactions.**  
3. **Use `cast tx` to analyze transaction details.**  
4. **Use `cast storage` to inspect contract storage directly.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Deploy a simple contract and interact with it using Cast.**  
2. **Read the balance of an Ethereum address with `cast balance`.**  
3. **Send a transaction using `cast send` and verify it with `cast tx`.**  
4. **Inspect the contract’s storage using `cast storage`.**  

📌 **Experiment with different Cast commands and analyze the results!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will explore advanced Cast utilities for debugging and transaction simulation.**  

🚀 **See you there!**  