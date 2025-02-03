# Aula 2: Estrutura do Framework, Instalando Dependências e Criando um Token

## 1. Abertura

Olá! Seja bem-vindo à nossa segunda aula do curso **Foundry 101**. Hoje, vamos dar mais um passo importante no desenvolvimento com o Foundry. Nesta aula, vamos aprender a:

### Programação

1. Estrutura básica de um projeto
2. Com instalar dependências externas
3. Criar um token ERC20 usando a biblioteca **Solady**.
4. Deploy e interação com nosso token

Ao final desta aula, você terá uma visão completa de como estruturar seu projeto, instalar bibliotecas externas e usar essas dependências para criar um contrato poderoso de forma eficiente.

Vamos começar entendendo como o Foundry organiza a estrutura dos projetos.

---

## Estrutura Básica do Framework

Quando você inicia um novo projeto no Foundry, ele já te entrega uma estrutura básica e bem organizada. Vamos dar uma olhada no que cada diretório e arquivo representa.

Depois de rodar `forge init meu-projeto`, você verá a seguinte estrutura:

```
meu-projeto/
├── lib/
├── src/
│   └── Contract.sol
├── test/
├── script/
└── foundry.toml
```

Aqui está o que cada pasta faz:

- **`lib/`**: Onde ficam as dependências externas que instalamos. Isso é super importante porque é onde o Foundry vai colocar bibliotecas como o **Solady**, que vamos instalar em breve.
- **`src/`**: Aqui é onde seus contratos principais ficam. É o coração do seu projeto.
- **`test/`**: Essa pasta armazena todos os testes unitários para os seus contratos. É aqui que você escreve seus testes para garantir que tudo está funcionando corretamente.
- **`script/`**: Aqui você coloca scripts de deploy e interações com contratos. Vamos explorar isso em mais detalhes nas próximas aulas.
- **`foundry.toml`**: O arquivo de configuração do projeto, que já vimos na aula anterior. É aqui que você define a versão do compilador Solidity, ativação de otimizadores, e outros parâmetros.

O Foundry segue essa estrutura para que o desenvolvimento seja organizado e escalável. Conforme seu projeto cresce, você pode dividir contratos em subpastas, instalar novas dependências e manter tudo bem gerenciado.

Agora que entendemos a estrutura básica, vamos aprender como instalar bibliotecas externas.

---

## 3. Instalando Dependências Externas

Uma das melhores partes do Foundry é a facilidade com que podemos instalar e usar bibliotecas externas em nossos projetos. Hoje, vamos instalar a biblioteca **Solady**, que traz otimizações e implementações eficientes para contratos Solidity.

Para instalar uma dependência no Foundry, usamos o comando **`forge install`**. Vamos fazer isso agora instalando a **Solady**. No terminal, dentro do diretório do seu projeto, execute:

```
forge install Vectorized/solady
```

Isso vai baixar a biblioteca **Solady** e colocá-la dentro da pasta `lib/` do projeto. Assim, podemos acessar os contratos da Solady e reutilizar suas implementações em nossos próprios contratos.

Vamos abrir o contrato da Solady que vamos usar para criar nosso token. O Solady oferece implementações otimizadas de vários padrões ERC, incluindo o **ERC20**, que é o padrão mais comum para tokens fungíveis.

Agora que a dependência está instalada, vamos utilizá-la para criar nosso token ERC20.

---

## Criando um Token ERC20 com Solady

Vamos criar nosso primeiro **token ERC20** usando a biblioteca **Solady**. A implementação que a Solady fornece para o ERC20 é muito mais leve e eficiente em termos de gas, o que é ideal para projetos que vão interagir com a mainnet.

Abra o arquivo `src/Token.sol` e vamos começar a escrever nosso contrato.

Primeiro, vamos importar o contrato **ERC20** da biblioteca Solady:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "solady/tokens/ERC20.sol";

contract Token is ERC20 {
    constructor(uint256 amount) {
        _mint(msg.sender, amount * 1e18);
    }

    function name() public pure override returns (string memory) {
        return "My Token";
    }

    function symbol() public pure override returns (string memory) {
        return "TOKEN";
    }
}
```

### O que está acontecendo aqui:

- Estamos utilizando o contrato **ERC20** da **Solady** para criar nosso token.
- Na função **`constructor(uint256 amount)`**, usamos a função `_mint(msg.sender, amount)` de `ERC20` para cunhar (mintart) a quantidade passada como `amount` de tokens e atribuí-los ao criador do contrato, ou seja, o endereço que fez o deploy.

Com esse código simples, criamos um token ERC20 funcional e eficiente, aproveitando as otimizações da biblioteca Solady.

Agora, vamos compilar e fazer o deploy desse token na blockchain local usando o **Anvil** e o **forge create**.

---

## Deploy do Token e Interação

Agora que o nosso token está pronto, vamos fazer o **deploy** na nossa blockchain local e interagir com ele.

### Passo 1: Compilar o contrato

Primeiro, precisamos compilar o contrato. No terminal, dentro da pasta do projeto, execute:

```
forge build
```

Se tudo estiver certo, o contrato será compilado sem erros.

### Passo 2: Rodar o Anvil

Agora, vamos iniciar o **Anvil**, que vai simular uma blockchain local para testarmos o contrato:

```
anvil -b 2
```

O Anvil vai levantar uma blockchain local e exibir contas com suas respectivas chaves privadas que podemos usar para realizar transações.

### Passo 3: Deploy do Token

Agora, vamos fazer o deploy do contrato **MeuToken** usando o comando **`forge create`**:

```
forge create \
    src/Token.sol:Token \
    --constructor-args 100 "lucas" \
    --rpc-url http://127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

Aqui estamos:

- Fazendo o deploy do contrato **MeuToken**.
- Usando o Anvil como blockchain local (`http://127.0.0.1:8545`).
- Utilizando a chave privada de uma das contas que o Anvil nos deu.

Se tudo correr bem, você verá o endereço do contrato no terminal após o deploy ser concluído.

### Passo 4: Interagir com o Token

Com o contrato implantado, vamos interagir com ele usando o **Cast**. Primeiro, podemos verificar o saldo de tokens na conta do deployer (que deve ser 1 milhão de tokens):

```
cast call \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "balanceOf(address)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

Isso vai retornar o saldo de tokens da conta, que deverá ser **1.000.000 MTK**.

Para transferir tokens para outra conta, podemos usar:

```
cast send \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "transfer(address,uint256)" 0x0000000000000000000000000000000000000022 97000000000000000000 \
    --from 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

```
cast send \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "transfer(address,uint256)" 0x0000000000000000000000000000000000000022 97000000000000000000 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

Isso transfere **97 TOKEN** (`97 * 10^18`) para o endereço de destino.

Pronto! Você criou um token ERC20 e interagiu com ele diretamente na blockchain local.

---

## 6. Conclusão

Hoje, exploramos três coisas importantes:

1. A **estrutura do projeto** no Foundry, entendendo como organizar o código.
2. Vimos como **instalar dependências externas**, como o **Solady**, para otimizar nosso desenvolvimento.
3. Criamos um **token ERC20** eficiente usando o Solady
4. Fizemos o deploy desse token na blockchain local, interagindo com ele diretamente.

Com essas ferramentas, você pode começar a desenvolver seus próprios tokens e projetos mais complexos de forma eficiente e organizada.

---

## 7. Recapitulação

Vamos recapitular o que aprendemos hoje:

1. **Estrutura do framework**: Organização de pastas e arquivos no Foundry.
2. **Instalando dependências**: Como usar o comando `forge install` para adicionar bibliotecas externas, como o **Solady**.
3. **Criando um Token ERC20**: Usamos a biblioteca Solady para criar um token eficiente.
4. **Deploy e interação**: Fizemos o deploy do contrato com o `forge create` e interagimos com o token usando o Cast.

---

## 8. Lição de casa

Sua lição de casa para hoje:

1. Criar um novo projeto no Forge.
2. Instalar a biblioteca **Solady**.
3. Criar um token ERC20, ERC721 ou ERC1155 usando o Solady.
4. Fazer o deploy do token na blockchain local usando o Anvil.
5. Interagir com o token via Cast, verificando o saldo e fazendo transferências.

---

## 9. Próxima aula

Na próxima aula, vamos explorar o mundo dos **testes** no Foundry, entendendo como escrever testes eficazes para seus contratos e como gerar relatórios de cobertura para garantir que tudo está funcionando como deveria. Até lá, continue praticando, e nos vemos na próxima aula! 👋
