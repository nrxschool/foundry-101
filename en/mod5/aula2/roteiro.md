# **Lesson 2: Advanced Usage of Chisel**  

## **1. Introduction**  

👋 Welcome to **Module 5, Lesson 2** of the **Foundry 101** course!  

In this lesson, we will explore **advanced features of Chisel**, including generating different types of contracts, customizing templates, and integrating with Foundry.  

📌 **What we will cover today:**  
1️⃣ Generating advanced contract templates with Chisel.  
2️⃣ Customizing Chisel-generated contracts.  
3️⃣ Using Chisel with Foundry to improve workflow.  
4️⃣ Best practices for structuring smart contract projects.  

✅ **By the end of this lesson, you will know how to maximize Chisel’s capabilities to accelerate smart contract development!**  

---

## **2. Generating Advanced Contract Templates**  

### **📌 Generating an ERC-721 (NFT) Contract**  

📌 **To create an ERC-721 (NFT) contract, run:**  

```bash
chisel new erc721 MyNFT
```

✅ **This generates an NFT contract named `MyNFT.sol`** in the `src/` folder.  

📌 **Example contract structure (`src/MyNFT.sol`):**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    uint256 private _tokenIdCounter;

    constructor() ERC721("MyNFT", "MNFT") {}

    function mint(address to) public onlyOwner {
        _tokenIdCounter++;
        _safeMint(to, _tokenIdCounter);
    }
}
```

✅ **This contract allows the owner to mint NFTs and transfer ownership.**  

📌 **Compile the contract:**  

```bash
forge build
```

✅ **Now the NFT contract is ready for deployment!**  

---

## **3. Customizing Chisel-Generated Contracts**  

📌 **Let’s add a metadata base URI to `MyNFT.sol`:**  

```solidity
string private _baseTokenURI;

function setBaseURI(string memory baseURI) public onlyOwner {
    _baseTokenURI = baseURI;
}

function _baseURI() internal view override returns (string memory) {
    return _baseTokenURI;
}
```

✅ **Now the contract supports metadata storage for NFTs.**  

📌 **Recompile the contract:**  

```bash
forge build
```

✅ **You can now deploy and test your customized NFT contract.**  

---

## **4. Using Chisel with Foundry to Improve Workflow**  

### **📌 Automatically Generate Test Files**  

📌 **When generating a contract, Chisel also creates a test file:**  

```bash
chisel new erc20 Token
```

✅ **Generates:**  
- `src/Token.sol` (ERC-20 contract).  
- `test/Token.t.sol` (Pre-configured Foundry test file).  

📌 **Example of an auto-generated test file (`test/Token.t.sol`):**  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Token.sol";

contract TokenTest is Test {
    Token token;

    function setUp() public {
        token = new Token();
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1000000 * 10 ** token.decimals());
    }
}
```

✅ **Chisel simplifies test writing, ensuring best practices from the start.**  

📌 **Run the tests:**  

```bash
forge test
```

✅ **This validates that the generated contract functions correctly.**  

---

## **5. Best Practices for Structuring Smart Contract Projects**  

📌 **Organize your project using a clean folder structure:**  

```
my-project/
├── src/              # Smart contracts
│   ├── Token.sol
│   ├── MyNFT.sol
├── script/           # Deployment scripts
│   ├── DeployToken.s.sol
├── test/             # Solidity tests
│   ├── Token.t.sol
│   ├── MyNFT.t.sol
├── foundry.toml      # Foundry configuration
└── lib/              # External dependencies
```

✅ **A well-structured project improves readability and maintainability.**  

---

## **6. Conclusion**  

📌 **Today we learned:**  
✔ **How to generate advanced contract templates with Chisel.**  
✔ **How to customize Chisel-generated contracts to add new functionality.**  
✔ **How to integrate Chisel with Foundry for efficient testing.**  
✔ **Best practices for structuring smart contract projects.**  

✅ **Now you can use Chisel to automate smart contract development and testing!**  

---

## **7. Summary**  

📌 **Today's key takeaways:**  
1. **Use `chisel new erc721 MyNFT` to generate an NFT contract.**  
2. **Modify generated contracts to fit project requirements.**  
3. **Leverage Foundry’s `forge test` to validate contract functionality.**  
4. **Organize contract files into `src/`, `script/`, and `test/` for better project management.**  

---

## **8. Homework**  

✏ **Practice Exercises:**  
1. **Generate a new ERC-1155 contract using Chisel.**  
2. **Modify the contract to include a supply cap per token type.**  
3. **Write and execute test cases for the modified contract.**  
4. **Deploy the contract and verify functionality on a local Anvil blockchain.**  

📌 **Experiment with different contract templates and explore Chisel’s full potential!**  

---

## **9. Next Lesson**  

📅 **In the next module, we will explore security best practices and contract optimizations in Solidity.**  

🚀 **See you there!**  