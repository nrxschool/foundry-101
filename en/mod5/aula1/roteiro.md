# **Lesson 1: Introduction to Chisel**  

## **1. Introduction**  

👋 Welcome to **Module 5, Lesson 1** of the **Foundry 101** course!  

In this lesson, we will explore **Chisel**, a powerful tool for rapidly generating Solidity boilerplate code and scaffolding smart contracts.  

📌 **What we will cover today:**  
1️⃣ What is Chisel, and why use it?  
2️⃣ Installing and setting up Chisel.  
3️⃣ Generating smart contract templates.  
4️⃣ Customizing Chisel-generated contracts.  

✅ **By the end of this lesson, you will know how to use Chisel to speed up Solidity development!**  

---

## **2. What Is Chisel and Why Use It?**  

📌 **Chisel is a code generator for Solidity, designed to quickly scaffold contract structures and test files.**  

🚀 **Why use Chisel?**  
✅ **Saves time** – No need to manually create standard contract files.  
✅ **Follows best practices** – Generates optimized, secure contract templates.  
✅ **Integrated with Foundry** – Works seamlessly with `forge` and `cast`.  

📌 **Chisel is useful for setting up smart contracts, test cases, and deployment scripts in seconds.**  

---

## **3. Installing and Setting Up Chisel**  

### **📌 Installing Chisel**  

📌 **To install Chisel, run:**  

```bash
cargo install chisel
```

✅ **Chisel requires Rust’s package manager (`cargo`) to install.**  

📌 **Verify the installation:**  

```bash
chisel --version
```

✅ **This should display the installed Chisel version.**  

---

## **4. Generating Smart Contract Templates**  

📌 **To generate a basic ERC-20 token contract, run:**  

```bash
chisel new erc20 Token
```

✅ **This creates a new ERC-20 token contract named `Token.sol`.**  

📌 **Example output:**  

```
Generated contract: src/Token.sol
Generated test file: test/Token.t.sol
```

📌 **Example contract structure (`src/Token.sol`):**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor() ERC20("Token", "TKN") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}
```

✅ **This is a standard ERC-20 implementation ready for deployment!**  

---

## **5. Customizing Chisel-Generated Contracts**  

📌 **Modify `src/Token.sol` to add a burn function:**  

```solidity
function burn(uint256 amount) public {
    _burn(msg.sender, amount);
}
```

✅ **Now the contract allows users to burn their tokens.**  

📌 **Recompile the contract:**  

```bash
forge build
```

✅ **Chisel-generated contracts are fully compatible with Foundry!**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **What Chisel is and why it’s useful.**  
✔ **How to install and set up Chisel.**  
✔ **How to generate Solidity contract templates with Chisel.**  
✔ **How to customize Chisel-generated contracts.**  

✅ **Now you can use Chisel to speed up Solidity development and testing!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **Chisel automates Solidity contract generation.**  
2. **Use `chisel new erc20 Token` to create an ERC-20 contract.**  
3. **Modify the generated contract to add new functionality.**  
4. **Use `forge build` to compile and verify Chisel-generated contracts.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Generate an ERC-721 (NFT) contract using Chisel.**  
2. **Modify the contract to include a mint function.**  
3. **Compile and deploy the modified contract using Foundry.**  

📌 **Experiment with different contract templates and customizations!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will explore advanced Chisel usage and contract optimizations.**  

🚀 **See you there!**