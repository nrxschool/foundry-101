# **Lesson 3: Testing and Coverage in Foundry**  

## **1. Introduction**  

👋 Welcome to **Module 1, Lesson 3** of the **Foundry 101** course!  

Testing is a **fundamental** part of smart contract development. Foundry makes testing **faster and more efficient** because it supports **Solidity-native testing**, without requiring JavaScript or external frameworks.  

📌 **What we will cover today:**  
1️⃣ Why testing is important in smart contracts.  
2️⃣ Writing unit tests in Solidity with Foundry.  
3️⃣ Running tests and analyzing results.  
4️⃣ Measuring test coverage.  
5️⃣ Using `vm` cheatcodes to improve testing.  

✅ **By the end of this lesson, you will know how to write and execute tests effectively using Foundry!**  

---

## **2. Why Testing Is Important in Smart Contracts**  

Unlike traditional applications, smart contracts are **immutable** once deployed. **Any bug can cause irreversible financial losses.**  

📌 **A good testing strategy ensures:**  
✅ **Security** – Prevents vulnerabilities and exploits.  
✅ **Correctness** – Ensures the contract behaves as expected.  
✅ **Efficiency** – Helps optimize gas usage.  

✅ **In Foundry, all tests are written in Solidity and executed using `forge test`**.  

---

## **3. Writing Unit Tests in Foundry**  

📌 **Example: Writing a test for the `Counter` contract**  

### **Step 1: Create the contract**  

📌 **Modify `src/Counter.sol`:**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    uint256 public count;

    function increment() public {
        count += 1;
    }

    function decrement() public {
        require(count > 0, "Counter cannot go below zero");
        count -= 1;
    }
}
```

✅ **This contract has a counter that can be incremented and decremented, but cannot go below zero.**  

---

### **Step 2: Create a test file**  

📌 **Create `test/Counter.t.sol` and add:**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    Counter counter;

    function setUp() public {
        counter = new Counter();
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.count(), 1);
    }

    function testDecrement() public {
        counter.increment();
        counter.decrement();
        assertEq(counter.count(), 0);
    }

    function testFail_DecrementBelowZero() public {
        counter.decrement(); // ❌ Should fail because count is already 0
    }
}
```

📌 **Explanation:**  
✅ `setUp()` → Runs before each test to deploy the contract.  
✅ `testIncrement()` → Checks if `increment()` increases `count`.  
✅ `testDecrement()` → Checks if `decrement()` decreases `count`.  
✅ `testFail_DecrementBelowZero()` → **Tests a failure case** where the counter should not go below zero.  

---

## **4. Running Tests in Foundry**  

📌 **To run all tests, execute:**  

```bash
forge test
```

✅ **Expected output:**  

```
[PASS] testIncrement() (gas: 25000)
[PASS] testDecrement() (gas: 26000)
[PASS] testFail_DecrementBelowZero() (failed as expected)
```

📌 **To enable gas reporting:**  

```bash
forge test --gas-report
```

✅ **This provides insights into gas usage for each function.**  

---

## **5. Measuring Test Coverage**  

📌 **To measure test coverage, run:**  

```bash
forge coverage
```

✅ **Expected output:**  

```
| File        | Coverage |
|-------------|---------|
| Counter.sol | 100.0%  |
```

📌 **If the coverage is low, it means some parts of the contract are not tested.**  

✅ **Aim for high test coverage to ensure your contract is well tested.**  

---

## **6. Using `vm` Cheatcodes in Testing**  

Foundry provides a **powerful set of cheatcodes** to simulate different blockchain conditions.  

📌 **Common cheatcodes:**  
✅ `vm.prank(address)` → Simulates a transaction from another address.  
✅ `vm.expectRevert()` → Expects a transaction to fail.  
✅ `vm.warp(uint256)` → Changes the block timestamp.  

📌 **Example: Testing with `vm.prank()`**  

```solidity
function testOnlyOwnerCanCall() public {
    vm.prank(address(0x123)); // Simulates a call from another address
    counter.increment(); // This should fail if only the owner can call it
}
```

📌 **Example: Expecting a failure with `vm.expectRevert()`**  

```solidity
function testExpectRevert() public {
    vm.expectRevert("Counter cannot go below zero");
    counter.decrement();
}
```

✅ **Cheatcodes help create more advanced and realistic tests!**  

---

## **7. Conclusion**  

📌 **Today we learned:**  
✔ **How to write unit tests in Solidity using Foundry.**  
✔ **How to run tests and analyze gas consumption.**  
✔ **How to measure test coverage.**  
✔ **How to use `vm` cheatcodes to improve testing.**  

✅ **Now you can write, execute, and optimize tests for smart contracts using Foundry!**  

---

## **8. Summary**  

📌 **Today's key takeaways:**  
1. **Tests in Foundry are written in Solidity inside the `test/` folder.**  
2. **`forge test` runs all tests and provides gas reports.**  
3. **`forge coverage` helps measure test coverage.**  
4. **`vm` cheatcodes allow advanced test manipulation.**  

---

## **9. Homework**  

✏ **Practice Exercises:**  
1. **Modify the `Counter` contract** to allow setting a maximum value and write a test for it.  
2. **Use `vm.expectRevert()` to test failure scenarios.**  
3. **Analyze test coverage and improve it to 100%.**  

📌 **Experiment with different scenarios and document your findings!**  

---

## **10. Next Lesson**  

📅 **In the next lesson, we will explore how to work with local blockchain environments using Anvil.**  

🚀 **See you there!**  