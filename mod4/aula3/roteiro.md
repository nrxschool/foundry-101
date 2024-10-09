# Aula 3: Gerenciando Contas no Ethereum

## 1. Abertura

Bem-vindo à **Aula 3 do Módulo 4**! Hoje vamos entender de forma mais profunda como funciona o **Account Model** no Ethereum, seus tipos de contas e o armazenamento associado. Além disso, vamos explorar os comandos do **Cast** para consultar dados de contas e gerenciar carteiras, assinando transações e mensagens.

Nesta aula, cobriremos:

1. **Account Model e EOA**: Comparação com o modelo UTXO do Bitcoin e tipos de contas no Ethereum.
2. **Account Commands**: Como consultar saldos, nonce e dados de storage, explorando as limitações do modificador `private`.
3. **Wallet Commands**: Criando, gerenciando e assinando mensagens e transações com carteiras.
4. **Transaction** Assinar uma transação crua e enviar para blockchain.

Vamos mergulhar nesses tópicos e entender como o Ethereum lida com contas e transações!

---

## 2. **Account Model e Tipos de Contas no Ethereum**

O Ethereum usa o **Account Model**, que é diferente do modelo **UTXO (Unspent Transaction Output)** utilizado pelo Bitcoin.

### **UTXO vs. Account Model**

- **UTXO (Bitcoin)**: As transações são compostas por saídas não gastas de transações anteriores. Cada transação utiliza saídas como inputs, e novas saídas são criadas.
- **Account Model (Ethereum)**: No Ethereum, as contas têm um saldo e cada transação altera diretamente o saldo da conta. As transações são simplificadas em relação ao modelo UTXO, pois as contas têm estados e podem armazenar dados em contratos inteligentes.

### **Tipos de Contas no Ethereum**

O Ethereum possui dois tipos de contas:

1. **Externally Owned Accounts (EOAs)**: Contas controladas por chaves privadas. São usadas para enviar e receber transações. Cada EOA tem:
   - Um **saldo de ETH**.
   - Um **nonce** (número de transações enviadas).
2. **Contract Accounts**: Contas associadas a contratos inteligentes. Eles armazenam:
   - **Código**: Código do contrato que é executado quando a conta é chamada.
   - **Storage**: Dados do contrato armazenados em slots de armazenamento.

---

## 3. **Account Commands** no Cast: Consultando Dados e Storage

Agora que entendemos o modelo de contas do Ethereum, vamos usar o **Cast** para consultar dados de uma conta e do storage de um contrato.

### **Exemplo Prático**: Vault com senha privada

Vamos criar um contrato chamado **Vault** com um dado privado (uma senha), mas que não está realmente velado na blockchain. Aqui está o contrato:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Vault {
    address public owner;
    string private password;

    error Unauthorized();

    constructor(string memory pwd) {
        owner = msg.sender;
        password = pwd;
    }

    modifier onlyOwner() {
        if (owner != msg.sender) {
            revert Unauthorized();
        }
        _;
    }

    function set(string calldata pwd) external onlyOwner {
        password = pwd;
    }

    function get() external view onlyOwner returns (string memory) {
        return password;
    }
}
```

### **Deploy do Contrato e Consulta ao Storage**

O contrato armazena a **senha** como uma string privada. No entanto, o modificador **`private`** apenas impede o acesso direto ao valor dentro do código Solidity, mas **qualquer pessoa pode ler o storage** do contrato na blockchain.

1. **Deploy do contrato no Anvil**:

```bash
YOUR_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
forge create \
    ./src/Vault.sol:Vault \
    --rpc-url http://127.0.0.1:8545 \
    --private-key $YOUR_PRIVATE_KEY \
    --constructor-args "mySecretPassword"
```

2. **Consultar o storage** com o comando `cast storage`:

```bash
CONTRACT=
cast storage \
    $CONTRACT \
    --rpc-url http://127.0.0.1:8545
```

Esse comando retorna o valor armazenado nos slots (no slot 1 está armazenada a string **password**). Porém, o valor está em formato hexadecimal. Para decodificá-lo:

3. **Converter o valor para ASCII** usando `cast to-ascii`:

```bash
VALUE=
cast to-ascii $VALUE
```

Isso exibe a string em texto legível, revelando que mesmo dados **privados** podem ser lidos diretamente do storage da blockchain.

### **Importância do Modificador `private`**

O modificador `private` no Solidity não esconde os dados da blockchain. Ele apenas restringe o acesso ao valor dentro do contrato. Para garantir que dados sensíveis não sejam revelados, você deve criptografar os dados **antes de armazená-los** no blockchain.

---

## 4. **Wallet Commands** no Cast

Agora vamos explorar os **Wallet Commands** do Cast para criar, gerenciar e assinar mensagens e transações com carteiras.

### **Criando uma nova chave privada com `cast wallet new`**

Você pode criar uma nova chave privada e o endereço correspondente com o comando:

```bash
cast wallet new
Private Key: 0x...
Address:     0x...
```

Se quiser salvar a chave em um **keystore** protegido por senha:

```bash
cast wallet new keystore --password
```

### **Convertendo uma chave privada para um endereço com `cast wallet address`**

Se já tiver uma chave privada, você pode convertê-la para um endereço Ethereum usando:

```bash
cast wallet address --private-key 0x...
Address: 0x1234567890abcdef1234567890abcdef12345678
```

### **Assinando mensagens com `cast wallet sign`**

Para assinar uma mensagem, você pode usar a chave privada ou um **keystore**:

**Exemplo**: Assinando uma mensagem com uma chave privada:

```bash
cast wallet sign --private-key 0x... "minha mensagem"
```

Isso gera uma assinatura que pode ser usada para verificar a autenticidade da mensagem.

Se preferir assinar com uma **Trezor** ou **Ledger**, use os comandos:

```bash
cast wallet sign --trezor "minha mensagem"
cast wallet sign --ledger "minha mensagem"
```

### **Gerenciando múltiplas contas e chaves**

Se você está gerenciando múltiplas contas, pode utilizar o **`cast wallet list`** para listar todas as contas no diretório de keystore padrão.

---

## 5. **Transações**: Assinar uma Transação Crua e Enviar para a Blockchain

Aqui, vamos passar pelo processo de criar e assinar uma transação crua, gerar o `calldata` manualmente e enviar para a blockchain usando o **Cast**.

### Passo 1: Gerar o `calldata`

O **calldata** é a parte da transação que contém os dados da função que queremos chamar. Para gerar o `calldata`, usamos o comando `cast calldata`:

```bash
cast calldata "set(string)" "newPassword123"
```

Este comando codifica a função `set(string)` com o argumento `"newPassword123"`. O resultado será uma string hexadecimal que representa o `calldata`.

### Passo 2: Assinar a Transação Crua

Assinamos a transação com nossa chave privada usando o comando `cast wallet sign`. Para isso, utilizamos o `calldata` e os outros parâmetros da transação:

```bash
cast mktx \
    --private-key $PRIVATE_KEY \
    $CONTRACT \
    $CALLDATA
```

Isso irá gerar uma assinatura da transação pronta para ser enviada.

### Passo 4: Enviar a Transação

Com a transação assinada, podemos enviá-la para a blockchain usando o comando `cast send`. Basta passar a transação assinada para o comando:

```bash
cast publish $SIGNED_TX
```

O **Cast** irá enviar a transação para a rede e você poderá acompanhar o hash da transação para verificar o status.

---

## 6. Conclusão

Hoje, cobrimos os conceitos fundamentais do **Account Model** no Ethereum e exploramos os diferentes tipos de contas (EOA e contratos). Também mostramos como usar **Account Commands** para consultar saldos, nonce e storage, destacando as limitações do modificador `private` em contratos inteligentes. Por fim, aprendemos a criar e gerenciar carteiras usando os **Wallet Commands** do Cast.

---

## 7. Lição de casa

1. Faça o deploy do contrato **Vault**, armazene uma senha e consulte o storage para verificar se a senha pode ser lida diretamente da blockchain.
2. Crie uma nova carteira com **`cast wallet new`**, e assine uma mensagem.
3. Explore outros comandos como **`cast nonce`** e **`cast storage`** para consultar dados de diferentes contas e contratos.

---

## 8. Próxima Aula

Na próxima aula, vamos ver sobre o **chisel**. Até lá!
