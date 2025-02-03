# Aula 2: **História do EVM Tooling**

## 1. Abertura

Olá! Bem-vindo à primeira aula do curso Foundry 101. Hoje, vamos falar sobre a **História do EVM Tooling**, abordando as ferramentas que ajudaram a moldar o desenvolvimento de contratos inteligentes no Ethereum. Dividimos essa aula em quatro tópicos principais:

### Programação:

1. Introdução à EVM,
2. As primeiras ferramentas,
3. O impacto do Remix,
4. A era dos frameworks e o avanço com o Foundry.

---

## 2. Introdução à EVM

- [Docs Oficial](https://ethereum.org/pt-br/developers/docs/evm/#the-ethereum-state-transition-function)

Primeiro, precisamos entender o que é a **Ethereum Virtual Machine** (EVM). A EVM é o ambiente onde todos os contratos inteligentes no Ethereum são executados. Ela funciona como uma máquina virtual descentralizada que processa transações e executa contratos.

Como a EVM é uma máquina virtual teoricamente qualquer blockchain pode implementar ela. Quando uma blockchain é EVM-compatible ela deve suportar smartcontracts em solidity e qualquer linguagem que compila para solidity.

Sem a EVM, não seria possível criar contratos inteligentes ou DApps. E é justamente por isso que as ferramentas de desenvolvimento são tão importantes: elas facilitam o processo de interação e deploy desses contratos na EVM.

## 3. As Primeiras Ferramentas (2014-2017)

No início, as opções eram bem limitadas. O **Mist**, em 2014, foi uma das primeiras tentativas de criar um navegador para dApps e uma interface de desenvolvimento.  
Logo após, em 2015, surgiu o **Geth**, um nó Ethereum que permitia rodar um cliente e interagir com a blockchain usando uma CLI.

Outro marco importante foi a criação da linguagem **Solidity**, também em 2015, que possibilitou o desenvolvimento dos primeiros contratos inteligentes. No entanto, nessa fase inicial, havia uma grande dificuldade: os desenvolvedores precisavam escrever muitos scripts manuais para realizar tarefas básicas, como testar e implantar contratos. Era um começo promissor, mas ainda muito rudimentar.

## 4. Remix e a Revolução do IDE Web (2016-2018)

Então, em 2016, surge o **Remix**, que trouxe uma revolução no desenvolvimento de contratos inteligentes. Com o Remix, ficou muito simples para os desenvolvedores escreverem, testarem e implantarem contratos inteligentes diretamente do navegador, sem precisar de ferramentas externas complexas.

O Remix tornou o processo de desenvolvimento mais acessível, mas ele tinha limitações, especialmente em projetos maiores e na integração com outras ferramentas. Mesmo assim, ele marcou o início de uma nova era de IDEs voltados para a Ethereum.

## 5. Hardhat, Truffle e o Avanço com o Foundry (2018-presente)

Com o crescimento do ecossistema, frameworks mais completos como **Truffle** e **Hardhat** foram lançados. O **Truffle**, em 2018, foi um dos primeiros a oferecer um ciclo de desenvolvimento completo, com ferramentas como o **Ganache** para simulação de uma blockchain local. Já o **Hardhat**, lançado em 2020, trouxe mais modularidade, permitindo a criação de plugins e uma experiência de debugging avançada. Além disso temos as alternativas em Python que são **Brownie** e o mais recente **ApeWorx**.

Finalmente, temos o **Foundry**, lançado em 2021, que oferece uma abordagem mais rápida e eficiente, com menos dependência de JavaScript e maior integração com o EVM, sendo uma ferramenta moderna e robusta para o desenvolvimento de contratos inteligentes. Vamos explorá-lo mais a fundo nas próximas aulas.

- [Hardhat](https://hardhat.org)
- [Truffle](https://archive.trufflesuite.com)
- [Brownie](https://github.com/eth-brownie)
- [ApeWorx](https://apeworx.io)
- [Foundry](https://getfoundry.sh)

## 6. Conclusão

Hoje vimos como o tooling do EVM evoluiu desde as primeiras ferramentas como Mist e Geth até chegarmos ao Foundry. Cada nova ferramenta resolveu desafios específicos, tornando o desenvolvimento mais eficiente e acessível.
Qual dessas ferramentas você já utilizou? Qual foi sua experiência? Na próxima aula, vamos falar especificamente sobre o **Foundry** e como ele se diferencia das outras opções.

## 7. Recapitulação

1. Entendemos o que é a EVM,
2. Vimos as primeiras ferramentas como Mist e Geth,
3. Discutimos o impacto do Remix como um IDE Web,
4. Exploramos como frameworks como Truffle, Hardhat, e Foundry mudaram o jogo para os desenvolvedores.

## Lição de casa

Quero que você vá na documentação do Foundry e dê um lida por cima, vamos passar por vários daqueles pontos que estão lá e se você ler com antecedência vai conseguir absorver mais.

## 8. Próxima aula

Na próxima aula, vamos focar na **Ecossistema do Foundry**, entender suas origens, seus pontos fortes e seu ecosistema. Nos vemos lá!
