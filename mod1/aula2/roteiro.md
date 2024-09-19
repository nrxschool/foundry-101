### **Roteiro da Aula 2: Ecossistema Foundry**

---

## 1. **Abertura**

Olá, seja muito bem-vindo à nossa segunda aula do curso **Blockchain Focado em Foundry**! Hoje vamos explorar um pouco mais a fundo o **ecossistema Foundry**, uma das ferramentas mais modernas e poderosas para desenvolvimento na blockchain.

Na aula de hoje, vamos passar pelos seguintes tópicos:

1. A **história do Foundry**, para entender como e por que essa ferramenta foi criada.
2. O **Forge**, que é o coração do Foundry e a principal ferramenta de desenvolvimento.
3. O **Anvil**, que permite simular um ambiente blockchain local.
4. E, por fim, as ferramentas **Cast** e **Chisel**, que trazem ainda mais praticidade para o desenvolvimento e interação com contratos.

- **Se você não fez a lição de casa da aula 1 você não vai conseguir acompanhar essa aula ok!**

Então, sem mais delongas, vamos começar entendendo como o Foundry surgiu e sua importância no ecossistema de desenvolvimento na blockchain!

---

## 2. **História do Foundry**

O **Foundry** nasceu da necessidade de uma ferramenta mais rápida e flexível para desenvolvedores que trabalham com contratos inteligentes na EVM, o **Ethereum Virtual Machine**. Tradicionalmente, muitos desenvolvedores usavam ferramentas como **Truffle** ou **Hardhat**, que, apesar de populares, começaram a mostrar suas limitações em termos de performance e facilidade de uso, especialmente com projetos maiores.

Aqui entra o Foundry: criado para ser mais leve, rápido e integrado, ele se destaca por ser uma suíte completa de ferramentas, tudo em uma única plataforma. Isso significa que você pode realizar todas as etapas de um projeto – desde a compilação, testes, deploys, até a interação com contratos – tudo sem sair do Foundry.

Um exemplo prático: enquanto ferramentas como o Hardhat podem demorar alguns segundos para rodar testes, o Foundry pode fazer isso quase instantaneamente, economizando um tempo precioso para os desenvolvedores.

Então, o Foundry surgiu para resolver essas dores e proporcionar uma experiência muito mais fluida para quem trabalha com contratos inteligentes. Com ele, você não precisa ficar instalando várias dependências externas ou depender de ambientes pesados. Tudo é mais direto e rápido!

- Todo o ecosistema do Foundry é escrito em Rust.

---

## 3. **Forge**

Agora vamos falar sobre o **Forge**, que é a principal ferramenta dentro do Foundry. O Forge é o que você vai usar para **compilar**, **testar** e até **fazer deploy** dos seus contratos inteligentes. Pense o forge como o `npm` do javasript ou `poetry` do python ou o `cargo` do Rust.

Pra começar vamos ver quais são os comandos que o forge nos fornece que vou explicar um por um:

```bash
>>> forge
Build, test, fuzz, debug and deploy Solidity contracts

Usage: forge <COMMAND>

Commands:
  bind               Generate Rust bindings for smart contracts
  build              Build the project's smart contracts [aliases: b, compile]
  cache              Manage the Foundry cache
  clean              Remove the build artifacts and cache directories [aliases: cl]
  clone              Clone a contract from Etherscan
  completions        Generate shell completions script [aliases: com]
  config             Display the current config [aliases: co]
  coverage           Generate coverage reports
  create             Deploy a smart contract [aliases: c]
  debug              Debugs a single smart contract as a script [aliases: d]
  doc                Generate documentation for the project
  flatten            Flatten a source file and all of its imports into one file [aliases: f]
  fmt                Format Solidity source files
  geiger             Detects usage of unsafe cheat codes in a project and its dependencies
  generate           Generate scaffold files
  generate-fig-spec  Generate Fig autocompletion spec [aliases: fig]
  help               Print this message or the help of the given subcommand(s)
  init               Create a new Forge project
  inspect            Get specialized information about a smart contract [aliases: in]
  install            Install one or multiple dependencies [aliases: i]
  remappings         Get the automatically inferred remappings for the project [aliases: re]
  remove             Remove one or multiple dependencies [aliases: rm]
  script             Run a smart contract as a script, building transactions that can be sent onchain
  selectors          Function selector utilities [aliases: se]
  snapshot           Create a snapshot of each test's gas usage [aliases: s]
  soldeer            Soldeer dependency manager
  test               Run the project's tests [aliases: t]
  tree               Display a tree visualization of the project's dependency graph [aliases: tr]
  update             Update one or multiple dependencies [aliases: u]
  verify-bytecode    Verify the deployed bytecode against its source [aliases: vb]
  verify-check       Check verification status on Etherscan [aliases: vc]
  verify-contract    Verify smart contracts on Etherscan [aliases: v]

Options:
  -h, --help     Print help
  -V, --version  Print version

Find more information in the book: http://book.getfoundry.sh/reference/forge/forge.html
```

PAREI AQUI
PAREI AQUI
PAREI AQUI
PAREI AQUI
PAREI AQUI
PAREI AQUI
PAREI AQUI
PAREI AQUI
PAREI AQUI
PAREI AQUI


---

## 4. **Anvil**

(👨‍🔬 Tom explicativo + exemplo prático)

Agora, vamos falar sobre o **Anvil**, que é essencial para simular uma blockchain local. O Anvil funciona como uma espécie de "sandbox", onde você pode testar contratos e transações sem ter que interagir com a mainnet ou uma testnet pública. Isso é extremamente útil quando você está desenvolvendo e quer testar rapidamente suas interações.

Para rodar o Anvil, você simplesmente usa o comando:

```
anvil
```

Isso vai levantar uma blockchain local na sua máquina. A partir daí, você pode fazer deploy de contratos, enviar transações, e até testar diferentes cenários, tudo localmente. Um exemplo seria testar o deploy de um contrato no Anvil e verificar como ele se comporta com diferentes valores de gas.

Se você está desenvolvendo um contrato complexo, é muito importante poder rodar esses testes localmente antes de fazer qualquer interação real com a blockchain. E o Anvil oferece exatamente esse ambiente seguro e rápido para fazer isso.

---

## 5. **Cast e Chisel**

(💬 Tom casual e prático)

Agora, vamos falar sobre o **Cast** e o **Chisel**, que são ferramentas auxiliares no ecossistema Foundry, mas não menos importantes.

O **Cast** é uma ferramenta de **linha de comando** que você vai usar para **interagir** com contratos já implantados. Digamos que você fez o deploy de um contrato no Anvil e agora quer chamar uma função desse contrato, como, por exemplo, verificar o saldo de um endereço. Com o Cast, basta usar um comando simples como:

```
cast call <endereço_contrato> "balanceOf(address)" <endereço>
```

Com isso, você recebe o saldo diretamente no terminal, sem a necessidade de uma interface gráfica.

Já o **Chisel** é uma ferramenta de **REPL** (Read-Eval-Print Loop), que permite a execução de comandos em tempo real. Com o Chisel, você pode "brincar" com os contratos e testar interações de maneira muito rápida e interativa. É como se fosse um playground onde você pode rodar snippets de código e ver os resultados instantaneamente.

---

## 6. **Conclusão**

(👨‍🏫 Tom mais conclusivo)

Então, para resumir: hoje vimos a **história do Foundry** e como ele surgiu para resolver as limitações de ferramentas mais antigas. Falamos sobre o **Forge**, que é o coração dessa suíte de ferramentas, o **Anvil**, que simula um ambiente blockchain local, e como o **Cast** e o **Chisel** facilitam a interação com contratos e a execução de comandos em tempo real.

Com tudo isso, você já tem uma visão completa do que é o ecossistema Foundry e de como ele pode transformar a forma como você desenvolve contratos inteligentes.

---

## 7. **Recapitulação**

(📝 Tom resumido)

Vamos fazer uma rápida recapitulação do que vimos hoje:

1. **História do Foundry**: Como o Foundry surgiu para resolver limitações do Hardhat e Truffle.
2. **Forge**: A principal ferramenta para compilar, testar e fazer deploy de contratos.
3. **Anvil**: Um simulador de blockchain local para testes rápidos e seguros.
4. **Cast e Chisel**: Ferramentas para interagir com contratos e testar código em tempo real.

---

## 8. **Lição de casa**

(📚 Tom direcionado)

Para fixar o que aprendemos hoje, a sua lição de casa é simples:

1. Instale o Foundry na sua máquina, se ainda não fez isso.
2. Crie um pequeno contrato inteligente em Solidity.
3. Use o **Forge** para compilar e testar o contrato.
4. Depois, levante o **Anvil** e tente fazer o deploy localmente.
5. Por fim, use o **Cast** para interagir com o contrato e testar algumas funções.

Anote suas dúvidas e teste à vontade!

---

## 9. **Próxima aula**

(🔜 Tom antecipando o futuro)

Na próxima aula, vamos nos aprofundar ainda mais no **Forge**, explorando em detalhes sua interface de linha de comando e a configuração inicial de um projeto. Vamos ver como iniciar e estruturar um projeto do zero, instalar dependências e preparar o ambiente de desenvolvimento. Não perca, vai ser uma aula cheia de exemplos práticos!

Nos vemos lá! 👋

---

Esse roteiro está pronto para ser usado em um teleprompter, mantendo o tom conversacional e exemplos práticos que ajudam a explicar os conceitos com clareza.
