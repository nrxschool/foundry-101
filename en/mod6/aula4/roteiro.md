# **Lesson 4: Gas Optimization in Solidity**  

## **1. Introduction**  

👋 Welcome to **Module 6, Lesson 4** of the **Foundry 101** course!  

Gas optimization is essential for making smart contracts **more efficient and cost-effective**. Writing gas-efficient Solidity code helps reduce transaction fees and improve scalability.  

📌 **What we will cover today:**  
1️⃣ Understanding gas costs in Solidity.  
2️⃣ Best practices for writing gas-efficient contracts.  
3️⃣ Measuring gas usage with Foundry.  
4️⃣ Comparing optimized vs. non-optimized implementations.  

✅ **By the end of this lesson, you will know how to optimize smart contracts for minimal gas usage!**  

---

## **2. Understanding Gas Costs in Solidity**  

📌 **Gas is the computational cost required to execute smart contract operations.**  

✅ **Key factors affecting gas usage:**  
- **Storage operations** → Writing to storage is the most expensive operation.  
- **Loops and iterations** → Repeated operations increase gas costs.  
- **Function visibility** → External vs. internal functions impact efficiency.  
- **Variable types** → Choosing the right data types reduces gas consumption.  

📌 **Every Solidity operation has a predefined gas cost.**  

Example:  
- **Writing to storage** → 20,000 gas per write.  
- **Reading from storage** → 2,100 gas per read.  
- **Calling an external contract** → 700 gas.  

✅ **Optimizing smart contracts helps save ETH on transaction fees.**  

---

## **3. Best Practices for Gas Optimization**  

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

### **2️⃣ Minimize Storage Writes**  

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

### **4️⃣ Use `uint256` Instead of Smaller Integers**  

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

✅ **Use `uint256` unless you need to pack variables for storage efficiency.**  

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

## **4. Measuring Gas Usage with Foundry**  

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

### **📌 Running a Gas Snapshot for Comparisons**  

📌 **To compare gas usage before and after optimizations:**  

```bash
forge snapshot
```

✅ **This records gas usage and allows you to compare improvements.**  

---

## **5. Comparing Optimized vs. Non-Optimized Implementations**  

📌 **Example: Optimizing an ERC-20 Transfer Function**  

❌ **Less efficient (multiple storage writes):**  

```solidity
function transfer(address to, uint256 amount) public {
    balanceOf[msg.sender] -= amount;
    balanceOf[to] += amount;
}
```

✅ **More efficient (only one storage write per balance update):**  

```solidity
function transfer(address to, uint256 amount) public {
    uint256 senderBalance = balanceOf[msg.sender];
    require(senderBalance >= amount, "Insufficient balance");
    unchecked {
        balanceOf[msg.sender] = senderBalance - amount;
    }
    balanceOf[to] += amount;
}
```

✅ **Optimized code minimizes storage updates and reduces gas costs.**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **How Solidity operations impact gas costs.**  
✔ **Best practices for writing gas-efficient contracts.**  
✔ **How to measure gas usage with Foundry’s `forge test --gas-report`.**  
✔ **How to optimize storage, loops, and arithmetic operations.**  

✅ **Now you can optimize Solidity contracts for minimal gas usage!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **Use `calldata` instead of `memory` for function parameters.**  
2. **Minimize storage writes by using memory variables first.**  
3. **Use `unchecked` for arithmetic when overflow checks aren’t needed.**  
4. **Pack smaller storage variables together to reduce slot usage.**  
5. **Measure gas usage with `forge test --gas-report` and compare optimizations with `forge snapshot`.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Optimize a Solidity function using `unchecked` and measure gas savings.**  
2. **Refactor an existing contract to reduce storage writes.**  
3. **Run `forge test --gas-report` before and after optimizations.**  
4. **Analyze the difference in gas usage using `forge snapshot`.**  

📌 **Try different optimizations and analyze the results!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will explore security best practices for Solidity smart contracts.**  

🚀 **See you there!**  