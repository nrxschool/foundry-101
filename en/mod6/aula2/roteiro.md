# **Lesson 2: Storing Keys with Cast Wallet**  

## **1. Introduction**  

👋 Welcome to **Module 6, Lesson 2** of the **Foundry 101** course!  

In this lesson, we will explore how to **securely store and manage private keys** using **Cast Wallet**. This prevents exposing private keys in scripts or command-line interactions.  

📌 **What we will cover today:**  
1️⃣ Why use Cast Wallet to store private keys?  
2️⃣ Creating and managing wallets with Cast Wallet.  
3️⃣ Signing transactions without exposing private keys.  
4️⃣ Best security practices for handling private keys.  

✅ **By the end of this lesson, you will know how to securely manage and use private keys in Foundry!**  

---

## **2. Why Store Keys with Cast Wallet?**  

📌 **Advantages of using Cast Wallet:**  
✅ **Prevents exposing private keys** in scripts and commands.  
✅ **Enables signing transactions without manually copying keys.**  
✅ **Easily integrates with Foundry scripts and tools.**  

📌 **Instead of storing your private key in plaintext, Cast Wallet encrypts it securely.**  

---

## **3. Creating and Managing Wallets**  

### **📌 Generating a New Wallet**  

📌 **Run the following command to create and save a new wallet:**  

```bash
cast wallet new --save
```

✅ **Example output:**  

```
New wallet generated!
Address: 0x1234567890abcdef1234567890abcdef12345678
Keystore: ~/.foundry/keystore
```

📌 **The encrypted wallet file is stored at `~/.foundry/keystore`.**  

---

### **📌 Listing Stored Wallets**  

📌 **To see all stored wallets, run:**  

```bash
cast wallet list
```

✅ **This displays all private keys securely stored by Cast Wallet.**  

---

### **📌 Importing an Existing Private Key**  

📌 **If you already have a private key, import it into Cast Wallet:**  

```bash
cast wallet import 0xYourPrivateKey
```

✅ **The private key will be securely stored in the keystore.**  

---

### **📌 Exporting a Stored Private Key**  

📌 **To retrieve a stored private key:**  

```bash
cast wallet export 0xYourWalletAddress
```

✅ **You will be prompted for a password before the private key is revealed.**  

🚨 **Never expose or share your private key!**  

---

## **4. Signing Transactions with Cast Wallet**  

### **📌 Sending ETH Using a Stored Wallet**  

📌 **Instead of providing a private key manually, use Cast Wallet:**  

```bash
cast send \
    --wallet 0x1234567890abcdef1234567890abcdef12345678 \
    0xRecipientAddress \
    --value 0.1ether \
    --rpc-url http://127.0.0.1:8545
```

✅ **This securely signs and sends the transaction using the stored wallet.**  

---

### **📌 Signing a Message with a Stored Wallet**  

📌 **To sign a message for authentication:**  

```bash
cast wallet sign --wallet 0x1234567890abcdef1234567890abcdef12345678 "This is a signed message"
```

✅ **Example output:**  

```
Signature: 0xabcdef123456...
```

📌 **This signature can be verified in smart contracts or dApps.**  

---

### **📌 Verifying a Signature**  

📌 **To check if a signature is valid:**  

```bash
cast wallet verify "This is a signed message" 0xabcdef123456...
```

✅ **Returns `true` if the signature is valid.**  

📌 **Example output:**  

```
Valid: true
```

✅ **This is useful for implementing signed authentication in DApps.**  

---

## **5. Best Security Practices**  

🚨 **Avoid These Common Mistakes:**  
❌ **Do not store private keys in plain text files.**  
❌ **Do not copy private keys manually into scripts.**  
❌ **Do not share private keys in public repositories.**  

✅ **Best Practices:**  
🔹 **Use `cast wallet` to manage keys securely.**  
🔹 **Store private keys in encrypted keystores instead of plain text.**  
🔹 **Always use `--wallet` instead of `--private-key` in transactions.**  

✅ **Following these practices helps prevent unauthorized access and key leaks.**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **How to create, import, and export wallets using Cast Wallet.**  
✔ **How to sign transactions securely without exposing private keys.**  
✔ **How to sign and verify messages with Cast Wallet.**  
✔ **Best security practices for managing private keys.**  

✅ **Now you can securely manage and use private keys with Foundry!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **Use `cast wallet new --save` to generate a new wallet securely.**  
2. **Use `cast wallet list` to view stored wallets.**  
3. **Use `cast send --wallet` to sign transactions without exposing keys.**  
4. **Follow best security practices to protect private keys.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Create a new wallet using Cast Wallet and list it.**  
2. **Import an existing private key and sign a message with it.**  
3. **Send a transaction using `cast send --wallet` instead of `--private-key`.**  
4. **Try verifying a signed message using `cast wallet verify`.**  

📌 **Experiment with secure key storage and transactions!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will integrate ScaffoldETH2 with Forge to build decentralized applications efficiently.**  

🚀 **See you there!**  