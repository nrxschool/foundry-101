# Aula 1: Leitura e Escrita com Cast

## 1. Abertura

Olá e bem-vindo à **Aula 1 do Módulo 4**! Neste módulo, vamos nos aprofundar no **Cast**, a ferramenta de linha de comando (CLI) do **Foundry** para interagir com contratos inteligentes e realizar chamadas RPC diretamente do terminal. Se você já usou o Cast em aulas anteriores, agora vamos explorar seus recursos de maneira mais detalhada.

Nesta aula, abordaremos:

1. Uma introdução mais profunda ao **Cast** e sua interface de linha de comando.
2. **Leitura de dados na blockchain** usando o Cast.
3. Como **escrever transações** na blockchain.

Vamos começar conhecendo melhor o **Cast** e sua CLI!

---

## 2. Conhecendo o Cast um pouco mais a fundo

O **Cast** é uma ferramenta poderosa para realizar chamadas e interações com contratos inteligentes, enviar transações e recuperar informações da blockchain, tudo diretamente da linha de comando.

### Como usar o Cast

O Cast funciona através de comandos e subcomandos que executam uma variedade de funções na blockchain. A estrutura básica para usar o Cast é:

```bash
cast
```

### Principais subcomandos

- **`cast call`**: Faz uma chamada de leitura a um contrato.
- **`cast send`**: Envia uma transação para a blockchain.
- **`cast estimate`**: Estima o custo de gas de uma transação.
- **`cast balance`**: Retorna o saldo de uma conta em wei ou ether.
- **`cast nonce`**: Exibe o nonce de uma conta.
- **`cast gas-price`**: Mostra o preço atual do gas.

Ao longo deste módulo, vamos explorar esses subcomandos em detalhes.

---

## 3. Tudo sobre Leituras na Blockchain

Uma das principais funcionalidades do Cast é a capacidade de realizar leituras na blockchain. Vamos ver como utilizar o **Cast** para fazer leituras eficientes e recuperar dados úteis de contratos e contas.

### **`cast call`**: Fazendo chamadas de leitura em contratos

O subcomando `cast call` permite realizar chamadas de leitura sem publicar transações na blockchain. Isso é muito útil para obter dados de contratos inteligentes sem gastar gas.

**Exemplo**: Vamos recuperar o saldo de tokens de uma conta em um contrato ERC20:

```bash
CONTRACT=0x6b175474e89094c44da98b954eedeac495271d0f
cast call \
    $CONTRACT \
    "balanceOf(address)(uint256)" \
    0x1234567890abcdef1234567890abcdef12345678 \
    --rpc-url http://127.0.0.1:8545
```

### **`cast balance`**: Consultando o saldo de uma conta

Com `cast balance`, podemos consultar o saldo de qualquer conta em wei (a menor unidade do ether), ou diretamente em ether com o flag `--ether`:

```bash
cast balance \
    0x1234567890abcdef1234567890abcdef12345678 \
    --rpc-url http://127.0.0.1:8545
```

Para mostrar o saldo diretamente em ether:

```bash
cast balance \
    0x1234567890abcdef1234567890abcdef12345678 \
    --ether \
    --rpc-url http://127.0.0.1:8545
```

### Outros comandos úteis de leitura

**`cast gas-price`**

```bash
# Mostra o preço atual do gas.
cast gas-price --rpc-url http://127.0.0.1:8545
```

**`cast block-number`**

```bash
# Retorna o número do bloco mais recente.
cast block-number --rpc-url http://127.0.0.1:8545
```

**`cast code`**

```bash
# Obtém o bytecode de um contrato.
CONTRACT=0x1234567890abcdef1234567890abcdef12345678
cast code \
    $CONTRACT \
    --rpc-url http://127.0.0.1:8545
```

Esses comandos fornecem as informações mais essenciais ao interagir com contratos e contas. Agora que já sabemos como fazer leituras, vamos aprender a enviar transações para a blockchain.

---

## 4. Tudo sobre Escrita na Blockchain

Escrever na blockchain envolve a criação e envio de transações que alteram o estado dos contratos. O **Cast** facilita isso com o comando **`cast send`**.

### **`cast send`**: Enviando transações

O comando `cast send` permite enviar ether ou chamar funções que alteram o estado em um contrato inteligente.

**Exemplo**: Vamos enviar 0.1 ether para uma conta específica:

```bash
YOUR_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
cast send \
    --private-key $YOUR_PRIVATE_KEY \
    0x1234567890abcdef1234567890abcdef12345678 \
    --value 0.1ether \
    --rpc-url http://127.0.0.1:8545
```

Aqui, usamos a chave privada para assinar a transação localmente. Para contratos, podemos invocar funções diretamente.

### Enviando uma transação para um contrato inteligente

Você também pode interagir com contratos enviando dados específicos:

```bash
YOUR_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
CONTRACT=0x6b175474e89094c44da98b954eedeac495271d0f
cast send \
    --private-key $YOUR_PRIVATE_KEY \
    $CONTRACT \
    "transfer(address,uint256)" \
    0x1234567890abcdef1234567890abcdef12345678 1000000000000000000 \
    --rpc-url http://127.0.0.1:8545
```

Neste exemplo, estamos enviando 1 token ERC20 (10^18 wei) para um endereço usando a função `transfer`.

### Outras opções importantes de `cast send`

- **`--gas-limit`**: Define o limite de gas para a transação.
- **`--gas-price`**: Define o preço do gas, ou o valor máximo de gas para transações EIP1559.
- **`--nonce`**: Define o nonce para a transação.

Por exemplo, se quisermos definir um limite de gas e preço para nossa transação:

```bash
YOUR_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
CONTRACT=0x6b175474e89094c44da98b954eedeac495271d0f
cast send \
    --private-key $YOUR_PRIVATE_KEY \
    0x1234567890abcdef1234567890abcdef12345678 \
    --value 0.1ether \
    --gas-limit 21000 \
    --gas-price 100gwei \
    --rpc-url http://127.0.0.1:8545
```

---

## 5. Conclusão

Nesta primeira aula sobre **Cast**, abordamos:

- Uma introdução à CLI do Cast.
- Como fazer leituras na blockchain com comandos como `cast call` e `cast balance`.
- Como enviar transações e interagir com contratos inteligentes usando `cast send`.

Agora você está mais familiarizado com a leitura e escrita na blockchain usando o Cast. Na próxima aula, vamos nos aprofundar nas **ferramentas de ABI** e aprender mais sobre **conversões** e **interações avançadas com a blockchain**.

---

## 6. Recapitulação

- O Cast é uma ferramenta poderosa para interagir com a blockchain diretamente do terminal.
- **Leitura**: `cast call`, `cast balance`, `cast gas-price`.
- **Escrita**: `cast send`, permitindo enviar ether e interagir com contratos inteligentes.

---

## 7. Lição de casa

1. Tente usar o `cast call` para interagir com um contrato ERC20 e verificar o saldo de uma conta.
2. Envie uma pequena quantia de ether para um endereço usando `cast send`.

---

## 8. Próxima aula

Na próxima aula, vamos aprender tudo sobre **utilidades de ABI**, como **decodificar** e **encodar transações**, e explorar comandos de conversão no **Cast**.
