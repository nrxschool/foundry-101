Aqui está o roteiro da **Aula 5: Debug de Smart Contracts no Foundry** atualizado, corrigido e pronto para uso:

---

# Aula 5: Debug de Smart Contracts no Foundry

## 1. Abertura

Olá, seja bem-vindo à **quinta aula do curso Foundry 101**! Hoje vamos explorar um recurso extremamente poderoso: o **debug de smart contracts**. O debug é essencial para entender o comportamento do seu contrato na EVM (Ethereum Virtual Machine) e identificar falhas que podem não ser visíveis apenas ao rodar os testes.

Nesta aula, vamos cobrir os seguintes tópicos:

1. Entender o que são **opcodes**, a **stack** e a **memória da EVM**.
2. Como acessar o debugger com **scripts** e **tests** no Foundry.

Vamos direto ao ponto e começar com o acesso ao debugger.

---

## Entendendo Opcodes, Stack e Memória da EVM

A Ethereum Virtual Machine (EVM) executa contratos inteligentes usando **opcodes**, que são instruções de baixo nível que a EVM entende. Cada linha do código Solidity que você escreve é compilada em uma sequência de opcodes.

### O que são Opcodes?

- **Opcodes** são as instruções da máquina EVM. Cada opcode realiza uma ação específica, como **PUSH**, **MSTORE** ou **CALL**.
- Quando você depura um contrato, o **debugger** exibe os opcodes que estão sendo executados no topo da tela.

Exemplo de **opcodes** comuns:

- **PUSH**: Coloca um valor na stack.
- **MSTORE**: Armazena um valor na memória.
- **CALL**: Realiza uma chamada a outro contrato.

### Stack e Memória da EVM

- **Stack**: A EVM opera em um modelo de stack, onde os valores são empilhados e consumidos por instruções subsequentes. A stack tem um tamanho limitado, e é fundamental entender como ela funciona para depurar contratos.
- **Memória**: A memória da EVM é usada para armazenar dados temporários durante a execução de uma transação. Diferente do armazenamento (storage), a memória é volátil e é liberada após a execução do contrato.

Vamos ver um exemplo básico de stack e memória. Pra isso crie um contrato de Contador
Agora, rodamos um teste para definir e recuperar o valor:

```bash
forge debug ./src/Counter --sig "set(uint256)" 8
```

---

## Acessando o Debugger com Scripts e Tests

No Foundry, você pode acessar o **debugger** tanto para **scripts** quanto para **tests**. Esse recurso ajuda a rastrear a execução de cada parte do contrato diretamente na **EVM**, fornecendo insights detalhados sobre como o contrato se comporta durante a execução.

### Testando com `--debug`

Vamos começar depurando um teste. Para isso, podemos usar o comando `forge test` com a flag `--debug`, especificando a função que queremos depurar:

```bash
forge test --debug "testInitialAliceBalance()"
```

Este comando abre o debugger e carrega o teste específico para depuração. Se houver vários testes com o mesmo nome em diferentes contratos, podemos usar os filtros `--match-path` ou `--match-contract` para depurar o teste correto.

### Rodando scripts com `--debug`

Da mesma forma, podemos depurar um script. Vamos rodar o seguinte comando para debugar o **script de deploy**:

```bash
forge script script/Simples.s.sol:Deploy --debug
```

Isso abre o script no debugger, permitindo navegar pela execução, linha por linha.

### Debug mode

Também podemos executar uma função específica do contrato com o `forge debug`:

```bash
forge debug ./src/Counter.sol --sig "incc()"
```

Nesse caso, passamos o nome da função que queremos debugar com `--sig`, e caso a função receba algum parâmetro, usamos:

```bash
forge debug ./src/Counter.sol --sig "set(uint256)" 7
```

Agora que já sabemos como acessar o debugger, vamos entender alguns conceitos importantes sobre o que acontece dentro da EVM durante a execução de contratos.

---

## Conclusão

Hoje, exploramos o poderoso recurso de **debugging no Foundry**. Vimos como acessar o debugger com **scripts** e **tests**, entendemos os conceitos de **opcodes**, **stack** e **memória**.

---

## Recapitulação

- **Entendendo opcodes e memória**: Vimos como a EVM executa contratos com opcodes e armazena dados na stack e memória.
- **Acessando o debugger**: Usamos comandos para debugar scripts e tests.

---

## Lição de casa

1. Crie um contrato mais complexo e tente depurá-lo, observando o comportamento dos opcodes.
2. Experimente alocar diferentes tipos de dados na memória e use o debugger para entender como a EVM gerencia essas alocações.

---

## Próxima aula

Na próxima aula, vamos nos aprofundar em **boas práticas de otimização de gas**, usando o que aprendemos sobre opcodes e memória para melhorar a eficiência dos seus contratos. Até lá, continue praticando, e nos vemos na próxima aula! 👋
