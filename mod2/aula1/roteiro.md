# **Aula 1: CLI, Configuração e Criando Projeto**

## 1. **Abertura**

Olá, bem-vindo à nossa próxima aula do curso **Blockchain Focado em Foundry**! Hoje vamos colocar a mão na massa e iniciar um projeto do zero usando o **Forge**, a ferramenta principal dentro do ecossistema Foundry. Nessa aula, vamos passar por três etapas fundamentais:

### Programação:

1. **CLI do Forge**: vamos aprender os principais comandos que você vai usar no dia a dia.
2. **Configuração inicial**: como preparar o ambiente do Forge corretamente.
3. **Criando um projeto**: vamos iniciar e estruturar um projeto desde o começo.

Se você seguiu a lição de casa da última aula, já deve ter instalado o Foundry. Agora, vamos ver como essa ferramenta vai funcionar na prática!

---

## 2. **CLI do Forge**

(👨‍💻 Tom explicativo com exemplos práticos)

Vamos começar falando sobre a **CLI** do Forge. A CLI, ou **linha de comando**, é onde você vai interagir diretamente com o Forge. É aqui que você vai compilar seus contratos, rodar testes, fazer deploys e muito mais.

Os principais comandos que você vai usar são:

- **`forge init`**: para iniciar um novo projeto.
- **`forge build`**: para compilar seus contratos.
- **`forge test`**: para rodar os testes unitários.
- **`forge install`**: para instalar dependências.
- **`forge script`**: para rodar scripts de deploy ou interação com contratos.

Vamos começar criando um projeto. Abra o terminal e rode:

```
forge init meu-projeto
```

Esse comando vai inicializar um novo projeto do Forge com uma estrutura básica. Você verá que ele já cria uma pasta com alguns arquivos e diretórios importantes, como `src/` (onde você colocará seus contratos) e `test/` (onde ficarão seus testes). Isso já te dá uma base inicial para trabalhar sem precisar configurar tudo manualmente.

Agora, vamos compilar os contratos. Como acabamos de criar um projeto novo, ele já vem com um contrato básico de exemplo. Para compilar, tudo o que você precisa fazer é rodar:

```
forge build
```

E pronto! Ele compila os contratos em questão de segundos.

Esses são os comandos principais que você vai usar com frequência, então é importante se familiarizar com eles.

---

## 3. **Configuração inicial**

(🔧 Tom mais técnico com foco na configuração)

Agora que já vimos a CLI básica, vamos falar sobre a **configuração** do Forge. O Forge usa um arquivo chamado **`foundry.toml`**, que é o coração da configuração do seu projeto.

Vamos abrir esse arquivo para ver o que ele já traz por padrão. Dentro do arquivo `foundry.toml`, você vai encontrar configurações como:

- O **compiler** usado para compilar os contratos, normalmente o **solc** (Solidity Compiler).
- **Paths** que definem onde os contratos e testes estão localizados.
- Outras opções como **optimizations** para deixar seus contratos mais eficientes.

Você pode personalizar esses valores de acordo com as necessidades do seu projeto. Um exemplo comum é ajustar a versão do Solidity que você está usando. No `foundry.toml`, basta editar a linha `solc_version` para a versão que você quer, como por exemplo:

```
[profile.default]
solc_version = '0.8.19'
```

Outra configuração interessante é o **optimizador**. Para habilitar o otimization e reduzir o custo de gas, você pode adicionar:

```
optimizer = true
optimizer_runs = 200
```

Essas são apenas algumas das configurações que você pode ajustar, mas o importante é entender que o arquivo `foundry.toml` controla como o Forge se comporta.

---

## 4. **Criando um projeto**

(👨‍💻 Tom prático com exemplo)

Agora que configuramos o ambiente, vamos **criar um contrato** para ver o Forge em ação.

Abra o arquivo `src/Contract.sol` que foi criado automaticamente quando iniciamos o projeto. Ele já vem com um contrato simples de exemplo. Vamos substituir esse contrato por algo mais prático. Por exemplo, um contrato que armazena e recupera um número:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 private storedData;

    function set(uint256 x) public {
        storedData = x;
    }

    function get() public view returns (uint256) {
        return storedData;
    }
}
```

Esse é um contrato super simples. Ele tem duas funções:

- Uma função **set()** para armazenar um número.
- Uma função **get()** para recuperar o número armazenado.

Agora que criamos o contrato, vamos compilá-lo rodando novamente o comando:

```
forge build
```

Se tudo estiver certo, o contrato será compilado rapidamente. E pronto! Criamos nosso primeiro contrato no Forge.

Agora, para testar esse contrato, podemos criar um teste na pasta `test/`. No arquivo `test/Contract.t.sol`, você pode escrever um teste simples para verificar se o contrato está funcionando:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract SimpleStorageTest is Test {
    SimpleStorage simpleStorage;

    function setUp() public {
        simpleStorage = new SimpleStorage();
    }

    function testSetAndGet() public {
        simpleStorage.set(42);
        uint256 result = simpleStorage.get();
        assertEq(result, 42);
    }
}
```

Esse teste cria uma instância do contrato e verifica se a função `set()` e `get()` estão funcionando corretamente. Agora, rodamos o teste:

```
forge test
```

E se tudo estiver certo, você verá uma saída no terminal mostrando que o teste passou com sucesso.

---

## 5. **Conclusão**

(🎯 Amarrar os tópicos)

Então, nesta aula, aprendemos três coisas fundamentais:

1. Como usar os principais comandos da **CLI do Forge** para iniciar, compilar e testar projetos.
2. Vimos a **configuração inicial** no arquivo `foundry.toml` e como ajustar opções como a versão do Solidity e a otimização de contratos.
3. E, por fim, criamos um projeto simples, com um contrato básico e um teste para garantir que ele funciona como esperado.

Agora você já tem tudo o que precisa para começar seus próprios projetos no Forge. Com essa base, você pode construir, compilar e testar contratos de forma rápida e eficiente.

---

## 6. **Recapitulação**

(📝 Resumo rápido)

Vamos recapitular os principais pontos:

1. **CLI do Forge**: Aprendemos comandos como `forge init`, `forge build` e `forge test`.
2. **Configuração inicial**: Ajustamos o arquivo `foundry.toml` para configurar o ambiente.
3. **Criando projeto**: Iniciamos um projeto, criamos um contrato simples e rodamos testes.

---

## 7. **Lição de casa**

(📚 Instruções práticas)

Agora é sua vez! Sua lição de casa para hoje é:

1. Criar um novo projeto usando o Forge.
2. Criar um contrato simples de sua escolha (pode ser algo como um contador ou um contrato de armazenamento).
3. Escrever um teste básico para garantir que ele funciona.
4. Testar tudo rodando `forge test`.

Essa prática vai te ajudar a solidificar o que aprendemos hoje!

---

## 8. **Próxima aula**

(🔜 Antecipação da próxima aula)

Na próxima aula, vamos explorar **instalando dependências** no Forge e entender a estrutura completa de um projeto. Vamos ver como adicionar bibliotecas e trabalhar com pacotes externos, algo essencial para projetos maiores e mais complexos. Até lá, continue praticando, e nos vemos na próxima aula! 👋

---

Esse roteiro foi escrito para ser lido em um teleprompter, garantindo um fluxo natural e uma explicação clara dos conceitos.
