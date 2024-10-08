# Aula 2: Deploy Local

## 1. Abertura

Olá, seja bem-vindo à **segunda aula do Módulo 3** do nosso curso **Foundry 101**! Hoje vamos explorar como **fazer deploy de contratos localmente no Anvil**, salvando e carregando estados da blockchain, além de dicas úteis e logs que o Anvil oferece para facilitar o desenvolvimento.

Os tópicos que vamos cobrir são:

1. Como fazer deploy no **Anvil** e salvar o estado.
2. Entender os logs do **Anvil** e como utilizá-los de forma eficiente.
3. Como rodar testes com **Forge**, **Anvil** e **Cast**.

Vamos começar!

---

## Fazendo deploy no Anvil e salvando o estado

### Salvando deploy como um estado do Anvil

Fazer deploy de contratos no **Anvil** é muito simples e segue um fluxo semelhante ao de deploy em uma blockchain pública, mas de forma local.
Você já viu como isso funciona, mas o **Anvil** tem a capacidade de salvar o estado atual da blockchain e carregá-lo posteriormente.

Isso permite que você continue desenvolvendo a partir do ponto onde parou, sem precisar recriar o ambiente toda vez que reiniciar o **Anvil**.

Use a flag `--dump-state` para salvar o estado da blockchain em um arquivo JSON:

### Salvando o estado

```bash
anvil --state ./estado.json
```

O arquivo **estado.json** conterá o estado completo da blockchain, incluindo contas, contratos e balances.

### Carregar o estado

Quando você iniciar o **Anvil** novamente, pode carregar o estado salvo:

```bash
anvil --load-state ./estado.json
```

Isso restaura a blockchain exatamente como estava quando foi salva, permitindo que você continue testando a partir do mesmo ponto.

### Na prática

1. Execute o `anvil` com a flag `--dump-state`
2. Faça deploy de um contrato usando `forge`
3. Interaja com ele usando `cast`
4. Encerre o `anvil` com CTRL + C
5. Reinicie o `anvil` com a flag `--load-state`
6. Interaja com o contrato usando `cast`

---

## Logs do Anvil e sua utilidade

Os **logs** gerados pelo **Anvil** são muito úteis para depuração e entendimento do comportamento dos contratos. Eles mostram informações detalhadas sobre:

- Transações enviadas.
- Geração de blocos.
- Consumo de gas.
- Erros ou exceções durante a execução de contratos.

Ao rodar o **Anvil**, os logs são exibidos no terminal:

```bash
anvil
```

Exemplo de logs:

```bash
Transaction: 0x1ea6d93481d5c7bd34fe289ee77586772d21d18a099170b38d5568b3ac701b34
Contract created: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Gas used: 518240

Block Number: 1
Block Hash: 0xe97ab66e254a212c0893e92a75cabd1310601e5bb86ba84a81780f6303c1bed5
Block Time: "Fri, 4 Oct 2024 20:57:13 +0000"

```

### Dicas para usar os logs

- **Monitorar deploys e transações**: Use os logs para monitorar quando os contratos são implantados, quanto gas foi utilizado e se as transações foram bem-sucedidas.
- **Identificar falhas**: Se uma transação falhar, os logs podem fornecer informações úteis sobre o motivo do erro, como exceções ou falta de gas.

Se você precisar rodar o **Anvil** em modo silencioso (sem exibir logs), use a flag:

```bash
anvil --silent
```

---

## Executando Testes no Anvil e Usando Cast para Interagir

Você pode rodar seus testes usando o **Anvil** como backend. Isso é útil porque você pode manter o estado da blockchain e os contratos ativos após os testes, permitindo interações posteriores com o **Cast**.

Para rodar os testes no **Anvil**:

```bash
forge test --fork-url http://127.0.0.1:8545
```

Isso roda os testes e mantém o estado da blockchain no **Anvil**. Após os testes, os contratos ainda estarão disponíveis.

### Interagindo com contratos usando o Cast

Depois de rodar os testes, você pode usar o **Cast** para interagir diretamente com os contratos que foram implantados durante o teste. Suponha que o contrato **MyToken** tenha sido implantado. Você pode usar o **Cast** para chamar funções no contrato.

Exemplo de como chamar uma função para verificar o saldo de uma conta:

```bash
cast call <ENDEREÇO_CONTRATO> "balanceOf(address)" <ENDEREÇO_CONTA>
```

Se você quiser enviar uma transação, pode usar:

```bash
cast send <ENDEREÇO_CONTRATO> "transfer(address,uint256)" <DESTINATÁRIO> <VALOR>
```

O **Cast** permite interagir com os contratos em execução, simular transações e observar os resultados diretamente no **Anvil**.

---

## 6. Conclusão

Hoje, aprendemos como fazer **deploy de contratos no Anvil**, salvar e carregar estados da blockchain, além de dicas úteis para melhorar o ambiente de testes local. Também vimos como os **logs** são essenciais para monitorar transações e contratos, e como podemos rodar testes no **Anvil** e continuar interagindo com os contratos usando o **Cast**.

---

## Recapitulação

- **Deploy no Anvil**: Como implantar contratos localmente e salvar o estado da blockchain.
- **Testes Locais**: Dicas de configuração para personalizar o ambiente de testes.
- **Logs do Anvil**: Utilidade dos logs para monitoramento e depuração de transações e contratos.
- **Testes com Anvil**: Manter os contratos ativos após os testes e usar **Cast** para interagir com eles.

---

## Lição de casa

1. Faça o deploy de um contrato no **Anvil** e salve o estado da blockchain.
2. Carregue o estado salvo e continue os testes a partir do mesmo ponto.
3. Execute testes no **Anvil** e, depois, use o **Cast** para chamar funções nos contratos implantados.

---

## Próxima aula

Na próxima aula, vamos explorar o **deploy local e forked** com mais detalhes, configurando o **Anvil** para trabalhar com redes reais e simular transações complexas. Até lá, continue praticando e nos vemos na próxima aula! 👋

---

Esse roteiro cobre tudo o que você precisa para realizar deploys locais no **Anvil**, salvar e restaurar estados, usar logs para monitorar, e rodar testes com contratos persistentes.
