# **Lesson 4: Smart Contract Debugging in Foundry**  

## **1. Introduction**  

👋 Welcome to **Module 2, Lesson 4** of the **Foundry 101** course!  

Debugging is an essential skill in smart contract development. Foundry provides **powerful debugging tools** that allow us to analyze contract execution, inspect memory, and find errors efficiently.  

📌 **What we will cover today:**  
1️⃣ Why debugging is important in smart contracts.  
2️⃣ Using Foundry’s built-in debugger.  
3️⃣ Analyzing transactions with Cast.  
4️⃣ Inspecting stack traces, memory, and storage.  

✅ **By the end of this lesson, you will know how to debug smart contracts efficiently using Foundry and Anvil!**  

---

## **2. Why Is Debugging Important?**  

Unlike traditional applications, **smart contracts are immutable** once deployed. **A single bug can result in financial losses or contract failure.**  

📌 **Debugging allows us to:**  
✅ Identify **logic errors** before deploying to mainnet.  
✅ Analyze **failed transactions** and understand why they reverted.  
✅ Inspect **memory, storage, and execution flow** of a contract.  

✅ **Foundry offers built-in debugging tools that make this process easier.**  

---

## **3. Debugging Transactions in Foundry**  

### **📌 Running Tests with Debugging**  

📌 **To debug a failed test, run:**  

```bash
forge test -vvvv
```

✅ **This enables verbose logging, showing detailed stack traces.**  

📌 **Example output for a failed test:**  

```
[FAIL] testFail_DecrementBelowZero()
Transaction reverted: "Counter cannot go below zero"
Stack trace:
  - Counter.decrement() (src/Counter.sol:10)
  - CounterTest.testFail_DecrementBelowZero() (test/Counter.t.sol:15)
```

✅ **This helps locate the exact line where the error occurred.**  

---

## **4. Analyzing Transactions with Cast**  

### **📌 Checking Transaction Details**  

📌 **To inspect a transaction, run:**  

```bash
cast tx 0xTransactionHash --rpc-url http://127.0.0.1:8545
```

✅ **Returns details such as gas used, sender, and function called.**  

📌 **Example output:**  

```
Transaction Hash: 0xabc123...
From: 0xF39F...
To: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Gas Used: 21000
Function: increment()
```

✅ **This helps analyze what happened during a transaction.**  

---

### **📌 Inspecting Contract Storage**  

📌 **To check stored values in a contract:**  

```bash
cast storage 0xContractAddress 0 --rpc-url http://127.0.0.1:8545
```

✅ **Returns the stored value in the first storage slot.**  

📌 **Example:**  

```bash
cast storage 0x5FbDB2315678afecb367f032d93F642f64180aa3 0
```

✅ **If the contract stores a counter, this returns its current value.**  

---

## **5. Inspecting Stack Traces, Memory, and Storage**  

### **📌 Using `vm.load()` to Inspect Storage in Tests**  

📌 **Modify `test/Counter.t.sol` to inspect storage:**  

```solidity
function testInspectStorage() public {
    counter.increment();
    uint256 storedValue = vm.load(address(counter), bytes32(uint256(0)));
    assertEq(storedValue, 1);
}
```

✅ **This allows us to inspect contract storage directly in tests.**  

---

### **📌 Using `vm.expectRevert()` to Test Failures**  

📌 **Modify `test/Counter.t.sol` to check revert messages:**  

```solidity
function testExpectRevert() public {
    vm.expectRevert("Counter cannot go below zero");
    counter.decrement();
}
```

✅ **Ensures that the contract reverts with the expected error message.**  

---

### **📌 Debugging with `forge trace`**  

📌 **To trace contract execution, run:**  

```bash
forge trace --rpc-url http://127.0.0.1:8545
```

✅ **Displays function calls, memory state, and reverts.**  

📌 **Example output:**  

```
[TRACE] Counter.increment()
Gas Used: 21000
Stack Trace:
  - Counter.increment() (src/Counter.sol:8)
  - CounterTest.testIncrement() (test/Counter.t.sol:12)
```

✅ **Shows the execution flow of the contract.**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **How to debug failed tests using `forge test -vvvv`.**  
✔ **How to analyze transactions with `cast tx`.**  
✔ **How to inspect storage with `cast storage` and `vm.load()`.**  
✔ **How to trace execution flow using `forge trace`.**  

✅ **Now you can debug smart contracts efficiently using Foundry!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **Use `forge test -vvvv` for detailed error messages.**  
2. **Use `cast tx` to inspect transaction details.**  
3. **Use `cast storage` and `vm.load()` to inspect contract storage.**  
4. **Use `forge trace` to analyze function execution flow.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Modify the `Counter` contract** to include a custom error and test for it.  
2. **Use `forge test -vvvv` to debug a failing test.**  
3. **Write a test using `vm.expectRevert()` to check for a specific error message.**  

📌 **Experiment with debugging tools and improve your troubleshooting skills!**  

---

## **9. Next Lesson**  

📅 **In the next lesson, we will explore gas optimization techniques in Foundry.**  

🚀 **See you there!**  