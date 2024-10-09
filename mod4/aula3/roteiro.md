# Aula 3: Gerenciando Contas e Carteiras

## 1. Abertura

Bem-vindo à **Aula 3 do Módulo 4**! Hoje vamos aprender como **gerenciar contas e carteiras** usando o **Cast**. Essas operações são essenciais para qualquer desenvolvedor de smart contracts, permitindo a criação de novas chaves, manipulação de endereços e até o gerenciamento de carteiras mais avançado.

Nesta aula, vamos cobrir:

1. Account-Model Base e EOA.
1. **Account Commands**: Como consultar saldos, nonce e outros dados sobre contas.
1. **Wallet Commands**: Criando, gerenciando e assinando mensagens/transações com carteiras.
1. Explorando exemplos práticos para gerenciar contas de forma eficiente com o **Cast**.

Vamos direto ao conteúdo!

---

## Account-Model Base e EOA.

- Explicar o que é o accounte model em comparação com UTXO
- Falar sobre os tipos de contas do ethereum, EOA, e estorage associado a contas

## 2. **Account Commands** no Cast

Os **Account Commands** permitem interagir com contas de Ethereum de forma rápida e eficiente. Vamos explorar como consultar saldos, códigos de contrato, nonce e muito mais.

### **Verificando o saldo de uma conta com `cast balance`**

O comando **`cast balance`** permite verificar o saldo de uma conta em **wei** (a menor unidade de ETH). Você também pode usar **ether** para uma leitura mais fácil.

```bash
cast balance 0x1234567890abcdef1234567890abcdef12345678 \
    --rpc-url https://127.0.0.1:8545
```

Para mostrar o saldo diretamente em **ether**, use a flag `--ether`:

```bash
cast balance 0x1234567890abcdef1234567890abcdef12345678 --ether \
    --rpc-url https://127.0.0.1:8545
```

### **Consultando o código de um contrato com `cast code`**

Se você quiser obter o **bytecode** de um contrato já implantado, pode usar o comando **`cast code`**:

```bash
cast code 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 \
    --rpc-url https://127.0.0.1:8545
```

Isso retorna o código de implementação do contrato. Você também pode verificar o tamanho do bytecode com **`cast codesize`**:

```bash
cast codesize 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 \
    --rpc-url https://127.0.0.1:8545
```

### **Verificando o nonce de uma conta com `cast nonce`**

O **nonce** é um contador que representa o número de transações enviadas por uma conta. Ele é crucial para a execução de transações na blockchain.

```bash
cast nonce 0x1234567890abcdef1234567890abcdef12345678 \
    --rpc-url https://127.0.0.1:8545
```

### **Consultando o armazenamento de contratos com `cast storage`**

Você pode inspecionar um **slot de armazenamento** de um contrato específico. Isso é útil quando você precisa entender como os dados estão sendo armazenados on-chain.

```bash
cast storage 0x1234567890abcdef1234567890abcdef12345678 0 \
    --rpc-url https://127.0.0.1:8545
```

Este comando retorna o valor armazenado na primeira posição (slot `0`) do contrato.

---

## 3. **Wallet Commands** no Cast

Agora que sabemos como consultar informações sobre contas, vamos explorar as funcionalidades de **carteiras** no **Cast**. Isso inclui desde a criação de novos endereços até a assinatura de transações e mensagens.

### **Criando uma nova chave privada com `cast wallet new`**

Você pode criar uma nova chave privada com o comando **`cast wallet new`**. Isso gera uma nova chave privada e o endereço correspondente.

```bash
cast wallet new
Private Key: 0x...
Address:     0x...
```

Se você quiser salvar essa chave em um **keystore** protegido por senha, basta especificar o caminho:

```bash
cast wallet new keystore --password
```

### **Criando uma nova mnemonic com `cast wallet new-mnemonic`**

O **Cast** também permite criar uma nova **mnemonic phrase** (frase de recuperação), que pode ser usada para gerar várias contas.

```bash
cast wallet new-mnemonic --words 12
Phrase:
scene toward ... [12 palavras]

Accounts:
- Account 0:
Address:     0x1234567890abcdef1234567890abcdef12345678
Private key: 0x...
```

Você pode gerar mnemonics com 12, 15, 18, 21 ou 24 palavras, sendo 12 o padrão.

### **Convertendo uma chave privada para um endereço com `cast wallet address`**

Se você já possui uma chave privada e deseja obter o endereço correspondente, pode usar **`cast wallet address`**.

```bash
cast wallet address --private-key 0x...
Address: 0x1234567890abcdef1234567890abcdef12345678
```

### **Assinando mensagens com `cast wallet sign`**

O **Cast** também permite que você assine mensagens usando uma chave privada ou um **keystore**.

**Exemplo**: Assinando uma mensagem com uma chave privada:

```bash
cast wallet sign --private-key 0x... "minha mensagem"
```

Isso retorna a assinatura que pode ser verificada posteriormente.

Se você quiser assinar com uma carteira de hardware, como uma **Trezor** ou **Ledger**, pode usar os comandos:

```bash
cast wallet sign --trezor "minha mensagem"
cast wallet sign --ledger "minha mensagem"
```

### **Gerando endereços de vanity com `cast wallet vanity`**

Você também pode usar **`cast wallet vanity`** para gerar endereços que começam ou terminam com uma sequência específica.

```bash
cast wallet vanity --starts-with dead
```

Isso gera um endereço que começa com a sequência "dead". Esse processo pode demorar, dependendo da complexidade do padrão.

### **Importando chaves privadas com `cast wallet import`**

Se você tiver uma chave privada e quiser importá-la para um **keystore** protegido, pode usar o comando **`cast wallet import`**:

```bash
cast wallet import MyWallet --private-key 0x...
```

A chave será armazenada de forma segura e poderá ser usada para assinar transações no futuro.

---

## 4. Exemplos Práticos

Agora, vamos ver um exemplo completo de como usar os comandos de **wallet** para criar uma nova conta, assinar uma mensagem e verificar a assinatura.

1. **Forge create com cast wallet**:

---

## 5. Conclusão

Nesta aula, cobrimos os principais comandos para **gerenciar contas e carteiras** com o **Cast**. Vimos como:

- Consultar dados de contas, como saldo, código de contrato, nonce e armazenamento.
- Criar, importar e gerenciar carteiras.
- Assinar mensagens e transações usando chaves privadas ou keystores.
- Gerar endereços de vanity e proteger chaves com **keystores**.

Esses comandos são fundamentais para garantir a segurança e a eficiência ao trabalhar com contas e carteiras no ambiente Ethereum.

---

## 6. Lição de casa

1. Use o **`cast balance`** para verificar o saldo de uma conta testnet e tente consultar o **nonce** e o **código** de um contrato implantado.
2. Crie uma nova **wallet** com **`cast wallet new`** e assine uma mensagem. Depois, use **`cast wallet verify`** para verificar a assinatura.
3. Gere um endereço de **vanity** com **`cast wallet vanity`** e experimente as opções para começar ou terminar com uma sequência específica.

---

## 7. Próxima Aula

Na próxima aula, vamos mergulhar em tópicos avançados, como **escrita de transações na blockchain** e otimização de **gas**. Também exploraremos exemplos práticos de **deploy de contratos** e **execução de funções** em contratos já implantados. Nos vemos lá!
