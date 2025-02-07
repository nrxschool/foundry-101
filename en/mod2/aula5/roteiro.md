# **Lesson 5: Gas Optimization in Foundry**  

## **1. Introduction**  

👋 Welcome to **Module 2, Lesson 5** of the **Foundry 101** course!  

Gas optimization is crucial for **reducing transaction costs** and improving the **efficiency of smart contracts**. Foundry provides powerful tools to analyze gas usage and optimize Solidity code.  

📌 **What we will cover today:**  
1️⃣ Why gas optimization is important.  
2️⃣ Measuring gas consumption in Foundry.  
3️⃣ Best practices for optimizing Solidity code.  
4️⃣ Using Foundry’s gas reports to improve efficiency.  

✅ **By the end of this lesson, you will know how to analyze and optimize gas usage in your smart contracts!**  

---

## **2. Why Is Gas Optimization Important?**  

📌 **Gas optimization helps to:**  
✅ **Reduce transaction fees** – Users pay less for interacting with your contracts.  
✅ **Increase efficiency** – More operations can be executed with less gas.  
✅ **Improve scalability** – Optimized contracts consume fewer blockchain resources.  

✅ **In Foundry, we can measure gas usage and find optimization opportunities easily.**  

---

## **3. Measuring Gas Consumption in Foundry**  

### **📌 Running Tests with Gas Reports**  

📌 **To measure gas usage, run:**  

```bash
forge test --gas-report
```

✅ **Example output:**  

```
| Function     | Min   | Avg   | Max   | Calls |
|-------------|-------|-------|-------|-------|
| increment   | 21,000| 23,000| 25,000| 10    |
| decrement   | 19,000| 20,500| 22,000| 5     |
```

📌 **What this tells us:**  
✅ **Min, Avg, and Max gas** used for each function.  
✅ **Number of function calls** during testing.  

✅ **This helps identify expensive functions that need optimization.**  

---

## **4. Best Practices for Gas Optimization**  

### **1️⃣ Use `calldata` Instead of `memory` for Function Parameters**  

📌 **Avoid unnecessary memory allocations.**  

❌ **Less efficient (`memory` uses more gas):**  

```solidity
function setName(string memory _name) public {
    name = _name;
}
```

✅ **More efficient (`calldata` saves gas):**  

```solidity
function setName(string calldata _name) public {
    name = _name;
}
```

📌 **`calldata` is cheaper because it avoids memory allocation.**  

---

### **2️⃣ Use `uint256` Instead of Smaller Integers**  

📌 **Solidity’s EVM operates on 256-bit words, so using `uint8`, `uint16`, etc., can introduce extra gas costs due to padding.**  

❌ **Less efficient (`uint8` adds complexity):**  

```solidity
uint8 a = 255;
uint8 b = 100;
```

✅ **More efficient (`uint256` avoids extra operations):**  

```solidity
uint256 a = 255;
uint256 b = 100;
```

✅ **Use `uint256` unless packing variables into storage.**  

---

### **3️⃣ Use `unchecked` for Arithmetic When Safe**  

📌 **Since Solidity 0.8+, arithmetic overflow checks consume gas. Use `unchecked` to skip them when safe.**  

❌ **Less efficient (adds overflow checks):**  

```solidity
function increment() public {
    count += 1; // Includes overflow check
}
```

✅ **More efficient (`unchecked` removes the check):**  

```solidity
function increment() public {
    unchecked {
        count += 1;
    }
}
```

📌 **Only use `unchecked` when you are certain overflows won’t happen.**  

---

### **4️⃣ Minimize Storage Writes**  

📌 **Each write to `storage` is expensive. Minimize storage updates whenever possible.**  

❌ **Less efficient (multiple storage writes):**  

```solidity
function increment() public {
    count += 1;
    count += 1;
}
```

✅ **More efficient (only one storage write):**  

```solidity
function increment() public {
    uint256 newCount = count + 2;
    count = newCount;
}
```

✅ **Always prefer memory or stack variables over `storage` when possible.**  

---

### **5️⃣ Packing Storage Variables**  

📌 **Solidity stores variables in 32-byte slots. Packing multiple smaller variables into a single slot saves gas.**  

❌ **Less efficient (two separate storage slots):**  

```solidity
contract Example {
    uint128 a;
    uint128 b;
}
```

✅ **More efficient (packed into a single storage slot):**  

```solidity
contract Example {
    uint128 a;
    uint128 b;
}
```

✅ **Smaller types should be declared together to fit into the same slot.**  

---

## **5. Using Foundry’s Gas Reports to Improve Efficiency**  

### **📌 Running a Gas Snapshot for Comparisons**  

📌 **To compare gas usage before and after optimizations:**  

```bash
forge snapshot
```

✅ **This records gas usage and allows you to compare improvements.**  

---

### **📌 Configuring Gas Reports in `foundry.toml`**  

📌 **Enable gas reports by adding this to `foundry.toml`:**  

```toml
[profile.default]
gas_reports = ["*"]
```

📌 **To analyze specific contracts:**  

```toml
gas_reports = ["Counter"]
```

✅ **This ensures every test run includes gas analysis.**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **How to measure gas consumption using `forge test --gas-report`.**  
✔ **Best practices for writing gas-efficient Solidity code.**  
✔ **How to optimize storage, function parameters, and arithmetic.**  
✔ **How to use Foundry’s gas reports to track improvements.**  

✅ **Now you can analyze and optimize your contracts for better efficiency!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **Use `calldata` instead of `memory` for function parameters.**  
2. **Prefer `uint256` over smaller integers unless optimizing storage.**  
3. **Use `unchecked` for arithmetic when overflow checks aren’t needed.**  
4. **Minimize storage writes by using memory variables first.**  
5. **Pack smaller storage variables together to reduce slot usage.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Modify the `Counter` contract** to use `unchecked` and measure gas savings.  
2. **Compare storage costs before and after packing variables together.**  
3. **Use `forge snapshot` to track gas optimization improvements.**  

📌 **Try different optimizations and analyze the results!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will explore meta-transactions and gasless interactions in Solidity.**  

🚀 **See you there!**  