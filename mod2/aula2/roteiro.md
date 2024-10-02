# Aula 2: Estrutura do Framework, Instalando Dependências e Criando um Token

## 1. Abertura

Olá! Seja bem-vindo à nossa segunda aula do curso **Blockchain Focado em Foundry**. Hoje, vamos dar mais um passo importante no desenvolvimento com o Foundry. Nesta aula, vamos aprender a:

### Programação

1. Estrutura Básica do framework
2. Com instalar dependências externas
3. Criar um token ERC20 usando a biblioteca **Solady**.

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

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "solady/src/tokens/ERC20.sol";

contract MeuToken is ERC20 {
    constructor() {
        // Defina o nome do token e o símbolo.
        _initialize("MeuToken", "MTK", 18);
        // Vamos cunhar 1 milhão de tokens para o criador do contrato.
        _mint(msg.sender, 1_000_000 * 10 ** 18);
    }
}
```

### O que está acontecendo aqui:

- Estamos utilizando o contrato **ERC20** da **Solady** para criar nosso token.
- Na função **`constructor()`**, usamos a função `_initialize()` para definir o nome do token (**"MeuToken"**), seu símbolo (**"MTK"**) e o número de casas decimais (18, que é o padrão para tokens ERC20).
- Depois, usamos a função **`_mint()`** para cunhar 1 milhão de tokens e atribuí-los ao criador do contrato, ou seja, o endereço que fez o deploy.

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
anvil
```

O Anvil vai levantar uma blockchain local e exibir contas com suas respectivas chaves privadas que podemos usar para realizar transações.

### Passo 3: Deploy do Token

Agora, vamos fazer o deploy do contrato **MeuToken** usando o comando **`forge create`**:

```
forge create src/Token.sol:MeuToken --rpc-url http://127.0.0.1:8545 --private-key <sua-chave-privada>
```

Aqui estamos:

- Fazendo o deploy do contrato **MeuToken**.
- Usando o Anvil como blockchain local (`http://127.0.0.1:8545`).
- Utilizando a chave privada de uma das contas que o Anvil nos deu.

Se tudo correr bem, você verá o endereço do contrato no terminal após o deploy ser concluído.

### Passo 4: Interagir com o Token

Com o contrato implantado, vamos interagir com ele usando o **Cast**. Primeiro, podemos verificar o saldo de tokens na conta do deployer (que deve ser 1 milhão de tokens):

```
cast call <endereço_contrato> "balanceOf(address)" <endereço_deployer>
```

Isso vai retornar o saldo de tokens da conta, que deverá ser **1.000.000 MTK**.

Para transferir tokens para outra conta, podemos usar:

```
cast send <endereço_contrato> "transfer(address,uint256)" <endereço_destino> 1000000000000000000 --from <endereço_deployer>
```

Isso transfere **1 MTK** (1 \* 10^18) para o endereço de destino.

Pronto! Você criou um token ERC20 e interagiu com ele diretamente na blockchain local.

---

## 6. Conclusão

Hoje, exploramos três coisas importantes:

1. A **estrutura do projeto** no Foundry, entendendo como organizar o código.
2. Vimos como **instalar dependências externas**, como o **Solady**, para otimizar nosso desenvolvimento.
3. Criamos um **token ERC20** eficiente usando o Solady e fizemos o deploy desse token na blockchain local, interagindo com ele diretamente.

Com essas ferramentas, você pode começar a desenvolver seus próprios tokens e projetos mais complexos de forma eficiente e organizada.

---

## 7. Recapitulação

(📝 Resumo rápido)

Vamos recapitular o que aprendemos hoje:

1. **Estrutura do framework**: Organização de pastas e arquivos no Foundry.
2. **Instalando dependências**: Como usar o comando `forge install` para adicionar bibliotecas externas, como o **Solady**.
3. **Criando um Token ERC20**: Usamos a biblioteca Solady para criar um token eficiente.
4. **Deploy e interação**: Fizemos o deploy do contrato com o `forge create` e interagimos com o token usando o Cast.

---

## 8. Lição de casa

(📚 Instruções práticas)

Sua lição de casa para hoje:

1. Criar um novo projeto no Forge.
2. Instalar a biblioteca **Solady**.
3. Criar um token ERC20 usando o Solady.
4. Fazer o deploy do token na blockchain local usando o Anvil.
5. Interagir com o token via Cast

, verificando o saldo e fazendo transferências.

---

## 9. Próxima aula

(🔜 Antecipação da próxima aula)

Na próxima aula, vamos explorar o mundo dos **testes** no Foundry, entendendo como escrever testes eficazes para seus contratos e como gerar relatórios de cobertura para garantir que tudo está funcionando como deveria. Até lá, continue praticando, e nos vemos na próxima aula! 👋

---

Esse roteiro foi ajustado para incluir a instalação da biblioteca **Solady** e a criação de um token ERC20, seguindo o modelo proposto para as aulas e mantendo a clareza para ser lido em um teleprompter.
