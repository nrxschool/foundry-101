# **Lesson 3: Managing Accounts with Cast**  

## **1. Introduction**  

👋 Welcome to **Module 4, Lesson 3** of the **Foundry 101** course!  

In this lesson, we will explore how to **manage Ethereum accounts using Cast**, including generating wallets, importing private keys, and sending transactions securely.  

📌 **What we will cover today:**  
1️⃣ Creating and managing Ethereum wallets with Cast.  
2️⃣ Importing and exporting private keys securely.  
3️⃣ Sending and signing transactions.  
4️⃣ Impersonating accounts for testing.  

✅ **By the end of this lesson, you will be able to create, manage, and interact with Ethereum accounts using Cast!**  

---

## **2. Creating and Managing Wallets with Cast**  

### **📌 Generating a New Wallet**  

📌 **To create a new Ethereum wallet:**  

```bash
cast wallet new --save
```

✅ **Example output:**  

```
New wallet generated!
Address: 0x1234567890abcdef1234567890abcdef12345678
Keystore: ~/.foundry/keystore
```

📌 **The wallet’s private key is securely stored in the keystore.**  

---

### **📌 Listing Stored Wallets**  

📌 **To see all wallets saved in Cast Wallet:**  

```bash
cast wallet list
```

✅ **This displays all available accounts stored in the keystore.**  

---

### **📌 Importing an Existing Private Key**  

📌 **If you already have a private key, import it into Cast Wallet:**  

```bash
cast wallet import 0xYourPrivateKey
```

✅ **The private key will be securely stored and available for signing transactions.**  

---

### **📌 Exporting a Stored Private Key**  

📌 **To retrieve a private key from a stored wallet:**  

```bash
cast wallet export 0xYourWalletAddress
```

✅ **You will be prompted for a password before the private key is revealed.**  

🚨 **Never expose your private key! Keep it securely stored.**  

---

## **3. Sending and Signing Transactions with Cast**  

### **📌 Sending ETH to Another Address**  

📌 **Example: Sending 1 ETH from a stored wallet to another address:**  

```bash
cast send --wallet 0x1234567890abcdef1234567890abcdef12345678 0xRecipientAddress --value 1ether --rpc-url http://127.0.0.1:8545
```

✅ **This securely signs and sends the transaction using Cast Wallet.**  

📌 **Example Output:**  

```
Transaction submitted: 0xabc123...
```

---

### **📌 Signing a Message with a Stored Wallet**  

📌 **To sign a message for authentication purposes:**  

```bash
cast wallet sign --wallet 0x1234567890abcdef1234567890abcdef12345678 "This is a test message"
```

✅ **Example Output:**  

```
Signature: 0xabcdef123456...
```

📌 **This signature can be used for on-chain authentication or message verification.**  

---

### **📌 Verifying a Signature**  

📌 **To check if a signature is valid:**  

```bash
cast wallet verify "This is a test message" 0xabcdef123456...
```

✅ **Returns `true` if the signature is valid and matches the original message.**  

📌 **Example Output:**  

```
Valid: true
```

---

## **4. Impersonating Accounts for Testing**  

📌 **When testing on a forked network, we can impersonate real Ethereum addresses.**  

📌 **Example: Enabling impersonation for an account:**  

```bash
cast rpc anvil_impersonateAccount 0x742d35Cc6634C0532925a3b844Bc454e4438f44e --rpc-url http://127.0.0.1:8545
```

✅ **This allows transactions to be sent from the impersonated address without its private key.**  

📌 **Example: Sending ETH as an impersonated account:**  

```bash
cast send --from 0x742d35Cc6634C0532925a3b844Bc454e4438f44e 0xRecipientAddress --value 1ether --rpc-url http://127.0.0.1:8545
```

✅ **Now the transaction will be executed as if sent from the impersonated account.**  

📌 **To stop impersonation:**  

```bash
cast rpc anvil_stopImpersonatingAccount 0x742d35Cc6634C0532925a3b844Bc454e4438f44e --rpc-url http://127.0.0.1:8545
```

✅ **This restores normal behavior on the forked network.**  

---

## **5. Conclusion**  

📌 **Today we learned:**  
✔ **How to create and manage Ethereum wallets using Cast.**  
✔ **How to securely import, export, and store private keys.**  
✔ **How to send ETH and sign messages with stored wallets.**  
✔ **How to impersonate accounts for testing on forked networks.**  

✅ **Now you can manage Ethereum accounts efficiently using Cast!**  

---

## **6. Summary**  

📌 **Today's key takeaways:**  
1. **Use `cast wallet new --save` to create a new wallet.**  
2. **Use `cast wallet import` to securely store an existing private key.**  
3. **Use `cast send --wallet` to send ETH from a stored wallet.**  
4. **Use `cast wallet sign` and `cast wallet verify` for message authentication.**  
5. **Use `cast rpc anvil_impersonateAccount` to test with real Ethereum addresses.**  

---

## **7. Homework**  

✏ **Practice Exercises:**  
1. **Generate a new wallet using Cast and list it.**  
2. **Import a private key and sign a message with `cast wallet sign`.**  
3. **Send ETH from a stored wallet using `cast send --wallet`.**  
4. **Impersonate an account on a forked network and send a transaction.**  

📌 **Experiment with different Cast account management features!**  

---

## **8. Next Lesson**  

📅 **In the next lesson, we will explore agile smart contract development using Chisel.**  

🚀 **See you there!**  