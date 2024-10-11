# Aula 1: Introdução ao Chisel e Uso Básico

## Abertura

Bem-vindo à nossa primeira aula sobre **Chisel**, o REPL para Solidity da suíte Foundry. Nesta aula, vamos apresentar o Chisel e explorar seu ambiente interativo, que permite testar rapidamente trechos de código em Solidity. Com o Chisel, você pode iterar sobre suas ideias sem a necessidade de rodar testes completos. Vamos entender os principais comandos, como `!help`, `!source`, `!save`, e `!clear`, além de ver exemplos práticos de uso.

### Programa da aula:

1. O que é o Chisel e como funciona.
2. Principais comandos do Chisel.
3. Testando códigos simples no Chisel.
4. Exportando e integrando com Foundry.

Chisel facilita o desenvolvimento ágil de contratos Solidity. Vamos começar!

---

## 1. O que é o Chisel e como funciona

O **Chisel** é uma ferramenta que funciona como um REPL (Read-Eval-Print Loop) para **Solidity**, permitindo:

- Testar rapidamente pequenos trechos de código.
- Obter feedback imediato e ajustar erros ou melhorias.
- Testar expressões, variáveis e operações sem a necessidade de configurar um projeto completo.

### Vantagens do REPL

Ao contrário de um fluxo tradicional de deploy e teste, no Chisel você pode:

- **Executar snippets** sem precisar de um contrato completo.
- Receber feedback imediato sobre **funcionalidade e erros**.
- Iterar rapidamente ao longo do desenvolvimento, ajustando e testando o código em tempo real.

### Iniciando o Chisel

Para iniciar o Chisel, basta rodar o comando:

```bash
chisel
```

Uma vez aberto, você poderá digitar expressões ou blocos de código Solidity e receber uma resposta imediata. O Chisel permite rodar tanto em redes locais quanto em forks de redes reais, oferecendo flexibilidade no desenvolvimento.

---

## 2. Principais Comandos do Chisel

O Chisel possui uma série de comandos úteis para navegar no ambiente REPL, limpar sessões, salvar código e muito mais. Vamos explorar os comandos principais para entender como utilizá-los no dia a dia.

**`!help`**

```bash
# O comando `!help` exibe todos os comandos disponíveis no Chisel.
# Use-o para descobrir as funcionalidades que podem facilitar seu fluxo de trabalho:
!help
```

**`!source`**

```bash
# Esse comando exibe o código-fonte atual da sessão Chisel, que é gerado conforme você insere o código Solidity.
# Isso permite acompanhar o que já foi executado:
!source
```

**`!clear`**

```bash
# Para reiniciar sua sessão e limpar o ambiente, use `!clear`.
# Isso é útil quando você quer começar do zero ou remover código antigo:
!clear
```

**`!save`**

```bash
# O comando `!save` permite salvar o estado atual da sessão Chisel, para que você possa retomá-la mais tarde.
# Se não passar um ID, o Chisel gera um automaticamente:
!save 101
```

---

## 3. Testando Códigos Simples no Chisel

Agora que conhecemos os comandos, vamos explorar como testar variáveis e operações diretamente no Chisel.

### Definindo Variáveis e Tipos Numéricos

No Chisel, você pode definir variáveis e realizar operações matemáticas rapidamente:

```js
uint256 a = 42;
uint256 b = 58;
a + b;
```

Você também pode trabalhar com **operações booleanas**:

```js
bool isTrue = true;
bool isFalse = false;
isTrue && isFalse;
```

### Notações e Números com Ether

Em Solidity, trabalhamos frequentemente com unidades como **wei**, **gwei**, e **ether**. Você pode definir quantidades de ether e trabalhar com precisão no Chisel:

```js
1 ether == 1e18 wei;
0.5 ether;
```

### Perda de Precisão (`Precision Loss`)

Em Solidity, devemos prestar atenção à **perda de precisão** ao trabalhar com números decimais. Como Solidity não lida com números de ponto flutuante, as operações podem sofrer **truncamento** ou erros quando valores são muito pequenos:

```js
// Isso vai truncar o resultado
// uint256 x = 1 ether / 3;
// 
// Compiler errors:
// 
// Error (4486): Type rational_const 1000000000000000000 / 3 is not implicitly convertible to expected type uint256.
// Try converting to type ufixed256x59 or use an explicit conversion.

uint256 x = 1 ether / uint256(3);
```

### Operações Matemáticas

Chisel permite testar diferentes operações e verificar como elas são tratadas pela EVM:

```js
uint256 result = 2**10;
uint256 mod = 10 % 3;
```

Com o Chisel, você consegue visualizar instantaneamente como esses números são manipulados e como a precisão afeta os resultados.

---

## 4. Exportando e Integrando com Foundry

O Chisel é integrado ao Foundry, permitindo exportar suas sessões para scripts que podem ser utilizados em testes ou deploys futuros.

### Exportando Sessões com `!export`

```bash
# Você pode exportar o código da sessão para um script dentro do seu projeto Foundry
!export
```

Isso cria um arquivo script no diretório `scripts/` do seu projeto, facilitando a reutilização do código.

### Integração Completa com Foundry

Quando o Chisel é iniciado em um projeto Foundry, ele herda todas as configurações do projeto. Isso inclui dependências, versões de compilador e até o ambiente da rede, o que facilita a transição de um protótipo para um teste ou deploy.

---

## Conclusão

Hoje, conhecemos o **Chisel**, uma ferramenta ágil e poderosa para testes interativos de Solidity. Exploramos os principais comandos, testamos variáveis e operações matemáticas, e vimos como o Chisel pode se integrar diretamente com o Foundry para facilitar o desenvolvimento.

---

## Lição de casa

- Teste criar uma variável com valores em ether e faça algumas operações aritméticas.
- Utilize o comando `!save` para salvar sua sessão e tente recarregá-la usando `!load` em uma próxima execução do Chisel.

---

## Próxima Aula

Na próxima aula, vamos nos aprofundar no uso avançado do Chisel, incluindo depuração de código Solidity e como integrar contratos complexos em suas sessões. Até lá!
