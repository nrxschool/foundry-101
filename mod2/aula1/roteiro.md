# Aula 1: **CLI, Criando Projeto, Configuração e Executando Projeto**

## **1. Abertura**

Olá! Seja bem-vindo à nossa aula do curso **Foundry 101**. Hoje vamos mergulhar nas bases práticas de como usar o Forge e configurar seu ambiente de desenvolvimento com o Foundry. Esta é uma aula cheia de prática, onde criaremos e configuraremos um projeto do zero.

Vamos seguir a seguinte programação:

1. Principais comandos da CLI
2. Criar novo projeto
3. Configurações úteis
4. Executar projeto

Então, prepare-se, porque hoje é a hora de colocar a mão na massa! Vamos começar entendendo os principais comandos da CLI do Forge.

## Principais comandos da CLI `forge`

Vamos começar conhecendo os principais comandos da **CLI do Forge**. A linha de comando (CLI) é onde você vai interagir diretamente com o Forge e realizar ações como criar, compilar, testar e fazer deploy de contratos.

Aqui estão os comandos mais importantes:

- **`forge init`**: Inicia um novo projeto.
- **`forge build`**: Compila os contratos no seu projeto.
- **`forge test`**: Roda os testes unitários para os contratos.
- **`forge install`**: Instala dependências externas (como bibliotecas).
- **`forge create`**: Faz o deploy de um contrato diretamente na blockchain.
- **`forge script`**: Executa scripts personalizados, como scripts de deploy.

---

## Criando um novo projeto

Agora que já conhecemos os comandos principais da CLI, vamos criar um **novo projeto** para colocar tudo isso em prática.

### 1. Criando um projeto chamado **Counter**.

No terminal, digite:

```
forge init counter
```

Isso vai criar a estrutura básica do projeto, com pastas como `src/` para seus contratos, `test/` para seus testes, e o arquivo `foundry.toml`, que contém as configurações do projeto.

- Vamos estudar sobre a **estrutura básica do projeto** na próxima aula.

### 2. Entender o projeto e o contrato **Counter**

O forge vai criar um contrato simples para o nosso projeto chamdo Counter.

### 3. Compilando o projeto

Depois de escrevermos nossos contratos, o comando **`forge build`** vai compilar os contratos:

```
forge build
```

---

## Configurações úteis do projeto

Agora que o projeto está criado, vamos dar uma olhada nas **configurações úteis** que podemos ajustar no arquivo `foundry.toml`.

Abrindo o arquivo `foundry.toml`, você verá configurações importantes como:

- **Versão do Solidity**: Aqui você define qual versão do Solidity será usada no projeto.

Por exemplo, para definir a versão do Solidity, podemos ajustar da seguinte forma:

```toml
[profile.default]
solc_version = '0.8.24'
```

---

## Executando Projeto

Agora que criamos e compilamos nosso contrato, vamos fazer o **deploy** usando o comando **`forge create`**, que facilita a implantação do contrato diretamente na blockchain simulada pelo Anvil ou até em redes reais.

### 1 Rodar a blockchain local

Primeiro, vamos iniciar o **Anvil**, que simula uma blockchain local minerando blocos a cada 2 segundos:

```
anvil -b 2
```

Veja que o `anvil` fornece algumas chaves com saldo em ETH para usarmos no ambiente de teste, vamos usar essa:

```
0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

### 2 Deploy do contrato

Agora, com o Anvil rodando, podemos usar o **`forge create`** para fazer o deploy do nosso contrato. Certifique-se de que o contrato foi compilado e rode o seguinte comando:

```
forge create \
    src/Counter.sol:Counter \
    --rpc-url http://127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

Esse comando vai:

- Especificar o contrato que queremos implantar (`src/Counter.sol:Counter`).
- Usar a URL da blockchain local criada pelo Anvil (`http://127.0.0.1:8545`).
- Usar sua chave privada para assinar a transação. (`0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80`)

Se tudo estiver correto, o contrato será implantado e o endereço do deploy será exibido no terminal.

### 3 Interagir com o contrato

Agora, vamos interagir com o contrato usando o **Cast**.

**Primeiro vamos LER da blockchain qual o valor atual de `number`**

```
cast call \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "number()(uint256)" \
    --rpc-url http://127.0.0.1:8545
```

**Agora vamos ESCREVER na blockchain usando a fução `setNumber` e LER o valor alterado**

```
cast send \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "setNumber(uint256)()" 42 \
    --rpc-url http://127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

```
cast call \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "number()(uint256)" \
    --rpc-url http://127.0.0.1:8545
```

E pronto! Conseguimos fazer o deploy do contrato e interagir com ele usando as ferramentas do Foundry.

---

## **6. Conclusão**

Nesta aula, vimos como trabalhar com os **principais comandos da CLI do Forge**, incluindo o comando **`forge create`** para deploy de contratos. Criamos um projeto do zero, ajustamos o arquivo `foundry.toml` para otimização, e fizemos um **deploy completo** usando o **Anvil** e interagindo com o contrato através do **Cast**.

Essa prática te deu uma base sólida para desenvolver, compilar e implantar seus contratos de forma eficiente.

---

## **7. Recapitulação**

1. **CLI do Forge**: Exploramos comandos como `forge init`, `forge build`, e `forge create` para o deploy.
2. **Criando projeto**: Iniciamos um novo projeto e criamos um contrato simples.
3. **Configurações úteis**: Ajustamos o `foundry.toml` para otimizar o projeto.
4. **Deploy completo**: Usamos o `forge create` para fazer o deploy no Anvil e interagimos com o contrato via Cast.

---

## **8. Lição de casa**

Sua lição de casa para hoje é:

1. Criar um novo projeto com o Forge.
2. Criar um contrato simples, que salve outras informações e interagir com ele.
3. Ajustar o `foundry.toml` para usar versões antigas do solidity.
4. Fazer o deploy do contrato no Anvil usando o comando **`forge create`**.
5. Interagir com o contrato via **Cast** para definir e ler valores.

---

## **9. Próxima aula**

(🔜 Antecipação da próxima aula)

Na próxima aula, vamos aprender **explorar a estrutura básica de um projeto**, **como instalar dependências** com `forge` e **como criar um Token ERC20**. Não perca! Até lá, continue praticando e nos vemos na próxima aula! 👋
