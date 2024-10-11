# Aula 2: Uso avançado do Chisel

## Abertura

Bem-vindo à nossa segunda aula sobre o **Chisel**! Hoje, vamos aprender a manipular sessões no Chisel, utilizando comandos como `!load`, `!list`, `!clearcache` e `!export`. Além disso, exploraremos como executar contratos mais complexos dentro do ambiente interativo, incluindo o uso de **arrays**, **mappings**, **structs**, **enums**, **funções** e **eventos**. Por fim, veremos como salvar e recuperar sessões para que possamos trabalhar em projetos mais elaborados.

### Programa da aula:

1. Manipulando sessões no Chisel.
2. Usando arrays, mappings, structs e enums.
3. Usando funções, contratos e eventos no Chisel.
4. Depurando a memória da EVM com `!stackdump`, `!memdump` e `!rawstack`.

Com essas ferramentas, você será capaz de trabalhar de forma mais eficiente com o Chisel. Vamos começar!

---

## 1. Manipulando Sessões no Chisel

No Chisel, podemos trabalhar em várias sessões, salvá-las e carregá-las para continuar de onde paramos. Isso é útil ao desenvolver projetos complexos ou quando precisamos alternar entre diferentes experimentos.

### Listando e Carregando Sessões

Para ver todas as sessões salvas no Chisel, utilizamos o comando `!list`:

```bash
!list
```

Isso mostrará todas as sessões armazenadas em cache. Para carregar uma sessão específica, basta usar o comando `!load` seguido do ID da sessão:

```bash
!load 101
```

### Salvando e Limpando Sessões

Se você estiver no meio de um experimento e quiser salvar o progresso, use o comando `!save`:

```bash
!save 202
```

Se não fornecer um ID, o Chisel atribuirá automaticamente um número. Para limpar o cache de sessões, podemos usar o comando `!clearcache`, removendo todas as sessões armazenadas:

```bash
!clearcache
```

### Exportando Sessões

Ao trabalhar em um projeto mais longo ou complexo, você pode exportar uma sessão para usá-la como um script em seu projeto Foundry. O comando `!export` faz isso:

```bash
!export
```

Isso cria um arquivo no diretório `scripts/` do seu projeto, pronto para ser usado.

---

## 2. Usando Arrays, Mappings, Structs e Enums

### Arrays

Os arrays são estruturas de dados que armazenam uma coleção de elementos do mesmo tipo. Eles são úteis para armazenar listas de valores.

#### Criando um Array

```javascript
uint256[] public numeros;
```

#### Métodos Comuns de Arrays

**Adicionar um elemento**:

```javascript
numeros.push(10);
```

**Acessar um elemento**:

```javascript
uint256 primeiroNumero = numeros[0];
```

**Obter o comprimento do array**:

```javascript
uint256 tamanho = numeros.length;
```

### Mappings

Os mappings são usados para associar chaves a valores. Eles são muito úteis para criar dicionários.

#### Criando um Mapping

```javascript
mapping(address => uint256) public saldos;
saldos[address(0x22)] = 123;
saldos[address(0x22)]
saldos[address(0x22222)]
```

#### Limitações dos Mappings

- Os mappings não possuem comprimento.
- Não é possível iterar sobre os keys ou values diretamente.
- Os valores padrão são retornados para chaves não definidas (por exemplo, 0 para uint256).

### Structs

As structs permitem criar tipos de dados personalizados.

#### Criando um Struct

```javascript
struct Pessoa {
    string nome;
    uint256 idade;
}
Pessoa memory p = Pessoa("nome", 27);
```

### Enums

Os enums são tipos que podem ter um conjunto fixo de valores. Eles são úteis para representar estados ou categorias.

#### Criando um Enum

```javascript
enum Status {
    Ativo,
    Inativo,
    Suspenso
}
Status st = Status.Ativo
st == Status.Inativo
st == Status.Ativo
uint(st)
uint(Status.Inativo)
uint(Status.Suspenso)
```

---

## 3. Usando Funções, Contratos e Eventos no Chisel

### Função de Soma Simples

Vamos começar criando uma função de soma simples.

```javascript
function soma(uint256 a, uint256 b) public pure returns (uint256) {
    return a + b;
}

soma(2, 99)
```

### Criando um Contrato Counter

Agora, vamos criar um contrato simples que conta.

```javascript
contract Counter {
    uint256 public count;

    event Incc(uint256 indexed novoValor);

    function incc() public {
        count += 1;
        emit Incc(count);
    }
}

Counter c = new Counter();
c.incc();
c.incc();
c.incc();
uint x = c.count();
x
```

### Eventos e Decodificação

Os eventos são úteis para acompanhar ações em seu contrato. Para capturar os eventos precisamos habilitar o `traces` usando:

```bash
!traces
```

#### Executando o Contrato

```javascript
Counter c = new Counter();
c.incc();
```

#### Entendendo os traces

Foundry trabalha com traces em todo o seu ecosistema, eles podem ser acessados nos testes e scripts usando `-vvvv` já no chisel usamos `!traces`:

```javascript
!traces


```

---

## Conclusão

Nesta aula, aprendemos a manipular sessões no Chisel, usando **arrays**, **mappings**, **structs**, **enums**, e como criar funções e contratos simples. Também vimos como usar eventos e como decodificá-los para acompanhar a execução dos contratos.

---

## Lição de casa

- Crie um contrato que utilize arrays e mappings.
- Use eventos para acompanhar a execução do contrato e teste suas funcionalidades no Chisel.
- Salve sua sessão e recarregue-a para continuar o desenvolvimento posteriormente.

---

## Próxima Aula

Na próxima aula, vamos explorar como utilizar o Chisel para depurar contratos e entender melhor a memória e a pilha da EVM. Até lá!

---

Se precisar de mais alguma coisa, é só avisar!
