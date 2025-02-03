# Aula 2: Deploy Local no Anvil

## 1. Abertura

Olá! Seja bem-vindo à **segunda aula do Módulo 3** do nosso curso **Foundry 101**! Hoje, vamos falar sobre **deploy local com o Anvil** e como salvar, carregar e gerenciar o estado da blockchain local. Vamos explorar as flags do Anvil que permitem a persistência do estado, trabalhar com logs e rodar testes.

Os tópicos que vamos abordar são:

1. Gerenciar estados da blockchain com **Anvil**.
2. Cenário prático de persistencia de estado.

Vamos direto ao ponto!

---

## 2. Explicação de como funcionam as flags no Anvil

O **Anvil** oferece várias opções para salvar, carregar e gerenciar o estado da blockchain local. Isso é extremamente útil para manter o progresso do seu ambiente de testes ou simular diferentes cenários sem perder dados.

### Flags principais

**`--dump-state`**:

```bash
# Quando o Anvil é encerrado ele salva o estado no json `./estado.json`. Isso inclui contas, contratos e balances.
anvil --dump-state ./estado.json
```

**`--load-state`**:

```bash
# Carrega um estado salvo anteriormente ao iniciar o Anvil.
anvil --load-state ./estado.json
```

**`--max-persisted-states <NUM>`**:

```bash
# Define o número máximo de estados persistentes no disco. (Rotation)
anvil --max-persisted-states 5
```

**`--preserve-historical-states`**:

```bash
# Preserva histórico de estados da blockchain.
anvil --preserve-historical-states
```

**`--state-interval <SECONDS>`**:

```bash
# Intervalo de tempo para persistir o estado no disco.
anvil --state-interval 60
```

**`--state <PATH>`**:

```bash
# Combina as funcionalidades de `--load-state` e `--dump-state`.
anvil --state ./estado.json
```

Essas flags são essenciais quando você está desenvolvendo contratos inteligentes e quer garantir que não perderá o estado da blockchain entre execuções do Anvil.

---

## 3. Prática: Deploy, Interação e Persistência do Estado

Agora, vamos colocar em prática o que aprendemos sobre as flags de estado do Anvil.

### Passo 1: Subir o Anvil com persistência de estado

Vamos subir o **Anvil** com a flag `--dump-state` para garantir que o estado da blockchain seja salvo quando o Anvil for encerrado.

```bash
anvil --dump-state ./estado.json
```

### Passo 2: Fazer deploy de um contrato

Vamos usar um contrato simples de token ERC20:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    uint256 count;

    function incc() external {
        count++;
    }

    function set(uint256 number) external {
        count = number;
    }

    function get() external view returns (uint256) {
        return count;
    }
}

```

Agora, faça deploy com `forge create`:

```bash
forge create \
    ./src/Counter.sol:Counter \
    --rpc-url http://127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

### Passo 3: Interagir com o contrato

Agora que o contrato foi implantado, vamos interagir com ele usando o **Cast**.

**Pegar o valor inicial**

```bash
CONTRACT_ADDRESS=0x5FbDB2315678afecb367f032d93F642f64180aa3
cast call \
    $CONTRACT_ADDRESS \
    "get()(uint256)"
```

**Editar o valor para `7889`**

```bash
CONTRACT_ADDRESS=0x5FbDB2315678afecb367f032d93F642f64180aa3
cast send \
    $CONTRACT_ADDRESS \
    "set(uint256)()" 7889 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

**Pegar o último valor**

```bash
CONTRACT_ADDRESS=0x5FbDB2315678afecb367f032d93F642f64180aa3
cast call \
    $CONTRACT_ADDRESS \
    "get()(uint256)"
```

### Passo 4: Reiniciar o Anvil e carregar o estado salvo

Depois de fazer o deploy e as interações, vamos encerrar o **Anvil**. Isso salvará o estado atual no arquivo **estado.json**. Para garantir que o estado persista após o reinício, carregue o estado salvo ao reiniciar o **Anvil**:

```bash
anvil --load-state ./estado.json
```

Agora, você pode interagir com o contrato novamente e validar que o último estado foi mantido (7889):

**Pegar o último valor**

```bash
CONTRACT_ADDRESS=0x5FbDB2315678afecb367f032d93F642f64180aa3
cast call \
    $CONTRACT_ADDRESS \
    "get()(uint256)"
```


---

## 6. Conclusão

Hoje, aprendemos como fazer deploy localmente usando o **Anvil**, salvar e carregar o estado da blockchain, e usar logs para monitorar transações e contratos. Também vimos como rodar testes com **Forge**, manter o estado da blockchain ativo e interagir com contratos usando o **Cast**.

---

## Recapitulação

- **Flags de estado do Anvil**: Vimos como usar `--dump-state`, `--load-state` e outras opções para salvar e restaurar o estado da blockchain.
- **Prática de deploy**: Fizemos deploy de um contrato, interagimos com ele, reiniciamos o Anvil e garantimos que o estado persistiu.

---

## Lição de casa

1. Faça o deploy de um contrato no **Anvil**, salve o estado da blockchain e verifique a persistência do estado após reiniciar o **Anvil**.
2. Explore os logs do **Anvil** para monitorar as transações e chamadas de contrato.

---

## Próxima aula

Na próxima aula, vamos aprofundar ainda mais em como usar o **Anvil** para testar e simular diferentes redes, incluindo forks de redes reais. Até lá, continue praticando e nos vemos na próxima aula! 👋
