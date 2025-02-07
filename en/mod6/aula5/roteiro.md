# **Lesson 5: Vyper Support**  

## **Introduction**  

In this lesson, we will explore **Vyper**, a programming language for smart contracts, and how to set it up in **Foundry**. We will learn how to compile Vyper contracts, write tests and scripts, and interact with the contracts. The goal is to understand how Vyper can be used alongside Foundry to develop **secure and efficient** smart contracts.  

### **Lesson Overview**  

1️⃣ Introducing Vyper and its differences from Solidity.  
2️⃣ Setting up Foundry to compile Vyper.  
3️⃣ Writing a simple contract and tests in Vyper.  
4️⃣ Writing a script in Vyper and interacting with the contract.  

---

## **1. Introducing Vyper and Comparing It to Solidity**  

Vyper is a smart contract programming language that prioritizes **simplicity and security**. Unlike Solidity, which has more flexible syntax and complex features, Vyper takes a **restricted approach** to reduce vulnerabilities.  

### **Key Differences:**  

- **Simpler syntax** → Vyper has a more intuitive and readable syntax.  
- **No function overloading** → Each function must have a unique name.  
- **Security-focused design** → Vyper is built to prevent common vulnerabilities.  

---

## **2. Setting Up Foundry to Compile Vyper**  

To use Vyper in Foundry, we need to install it first. There are multiple installation methods, including **Docker** and **PIP**. Below are the instructions for setting it up:  

### **Installing Vyper**  

1. **Create a Python virtual environment**  

```bash
python3 -m venv .venv
source .venv/bin/activate
```

2. **Install Vyper**  

```bash
pip3 install vyper
which vyper
```

### **Configuring Foundry**  

Add the Vyper configuration to the `foundry.toml` file:  

```toml
[vyper]
path = "/path/to/vyper"
```

---

## **3. Writing and Testing a Vyper Contract**  

### **Simple Vyper Contract (Voting System)**  

```python
#pragma version >0.4.0

voted: public(HashMap[address, bool])
candidate: public(HashMap[address, uint256])

@external
def vote(candidate: address) -> bool:
    assert not self.voted[msg.sender], "You have already voted."

    self.voted[msg.sender] = True
    self.candidate[candidate] += 1

    return True
```

### **Testing the Contract**  

We will use Solidity to write the tests and deploy the contract.  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

contract VyperDeployer is Test {
    function deployContract(string memory fileName) public returns (address) {
        string;
        cmds[0] = "vyper";
        cmds[1] = string.concat("src/", fileName, ".vy");

        bytes memory bytecode = vm.ffi(cmds);
        address deployedAddress;
        assembly {
            deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        require(deployedAddress != address(0), "VyperDeployer could not deploy contract");
        return deployedAddress;
    }
}
```

### **Writing the Tests**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {VyperDeployer} from "./VyperDeploy.sol";

interface IVoting {
    function vote(address) external returns (bool);
    function voted(address) external returns (bool);
    function candidate(address) external returns (uint256);
}

contract VotingTest is VyperDeployer {
    VyperDeployer deployer;
    IVoting voting;
    address alice = address(0xaAaAaAaaAaAaAaaAaAAAAAAAAaaaAaAaAaaAaaAa);

    function setUp() public {
        deployer = new VyperDeployer();
        voting = IVoting(deployer.deployContract("Voting"));
    }

    function testVote() public {
        vm.prank(alice);
        voting.vote(alice);

        assertEq(voting.candidate(alice), 1);
        assertEq(voting.voted(alice), true);
    }

    function testVoteTwice() public {
        voting.vote(alice);
        vm.expectRevert("You have already voted.");
        voting.vote(alice);
    }
}
```

---

## **4. Deploying the Vyper Contract**  

### **Deploying with `forge create`**  

```bash
forge create \
    ./src/Voting.vy:Voting \
    --account my-net
```

### **Deploying with a Foundry Script**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "forge-std/console2.sol";
import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "../test/vyper/VyperDeploy.sol";

interface IVoting {
    function candidate(address) external returns (uint256);
    function voted(address) external returns (bool);
    function vote(address) external returns (bool);
}

contract Deploy is Script {
    VyperDeployer deployer;
    IVoting voting;

    function setUp() public {
        deployer = new VyperDeployer();
        voting = IVoting(deployer.deployContract("Voting"));
    }

    function run() external {
        vm.startBroadcast();
        vm.stopBroadcast();
    }
}
```

### **Interacting with the Contract Using `cast`**  

Run the following command to interact with the contract:  

**Voting**  

```bash
cast send \
    0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35 \
    "vote(address)(bool)" 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720 \
    --account my-net
```

**Checking the Vote**  

```bash
cast call 0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35 "voted(address)(bool)" 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720
cast call 0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35 "candidate(address)(uint256)" 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720
```

---

## **5. Conclusion**  

📌 **Today we learned:**  
✔ **What Vyper is and how it compares to Solidity.**  
✔ **How to configure Foundry to compile Vyper contracts.**  
✔ **How to write and test a Vyper smart contract.**  
✔ **How to deploy and interact with a Vyper contract using Foundry.**  

✅ **Now you can develop and test Vyper contracts with Foundry!**  

---

## **6. Homework**  

✏ **Practice Exercises:**  
1️⃣ **Create a Vyper contract that emits events and write tests to verify event emissions.**  
2️⃣ **Use `prank` to simulate different accounts interacting with your contract.**  
3️⃣ **Implement a function that fails and use `expectRevert` in tests to validate failures.**  

📌 **Experiment with different contract interactions to deepen your understanding!**  

---

## **7. Next Lesson**  

📅 **In the next lesson, we will explore advanced testing strategies in Foundry.**  

🚀 **See you there!**  