# Aula 3: Integração ScaffoldETH2 com Forge

## Abertura

Nesta aula, vamos explorar a **integração do ScaffoldETH2 com o Forge**. Esta combinação permite construir dApps full-stack com facilidade, usando uma base robusta para o desenvolvimento e testes de contratos inteligentes. Abordaremos desde a **ABI**, essencial para a comunicação entre o frontend e os contratos, até o funcionamento prático do **ScaffoldETH2** e sua integração com o Forge.

### Programa da aula:

1. O que é ABI e sua importância para o frontend.
2. O que é o ScaffoldETH2.
3. O que é o FWT (Framework que une Foundry e ScaffoldETH2).
4. Exemplo prático.

---

## 1. O que é ABI e sua importância para o frontend

**ABI** (Application Binary Interface) é um conceito crucial no desenvolvimento de contratos inteligentes e frontend. Ela define como o frontend (ou qualquer cliente externo) pode interagir com um contrato inteligente. Basicamente, a ABI mapeia as funções do contrato e os tipos de dados que serão usados nas interações.

Sem a ABI, o frontend não consegue se comunicar com o contrato, tornando-a a ponte entre os contratos inteligentes (backend) e a interface que os usuários interagem.

### Exemplo de uma ABI:

```json
[
  {
    "inputs": [],
    "name": "storeData",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
]
```

Neste exemplo, a ABI descreve uma função chamada `storeData` que não recebe parâmetros, não retorna nada e altera o estado do contrato.

---

## 2. O que é o ScaffoldETH2

**ScaffoldETH2** é uma plataforma que facilita a construção de dApps na Ethereum, fornecendo uma infraestrutura base para o desenvolvimento de frontends conectados a contratos inteligentes. Ele foi projetado para ser um ponto de partida para desenvolvedores que desejam integrar facilmente seu frontend com contratos Solidity ou Vyper.

Ele inclui:

- **Templates** pré-configurados para dApps.
- Suporte para **desenvolvimento full-stack**.
- Ferramentas integradas para facilitar o desenvolvimento e testes.

Com o ScaffoldETH2, você pode rapidamente prototipar contratos e conectá-los ao frontend para testes e deploy.

---

## 3. O que é o FWT (Framework que une Foundry e ScaffoldETH2)

O **FWT** (Framework de Workflows Testing) é uma integração que conecta o **Foundry** e o **ScaffoldETH2**, unindo o poder dos testes automatizados e flexíveis do Foundry com a base de desenvolvimento full-stack do ScaffoldETH2.

### Benefícios do FWT:

- Testes completos de ponta a ponta (do contrato inteligente até o frontend).
- Integração simples entre desenvolvimento de contratos e dApp.
- Facilita a visualização e interação com contratos inteligentes.

---

## 4. Exemplo prático: ScaffoldETH2 + Forge

Neste exemplo, vamos criar um projeto básico usando o ScaffoldETH2 e integrá-lo com o Forge para compilar e testar contratos.

### Passo 1: Instalar o ScaffoldETH2

```bash
git clone https://github.com/olivmath/fwt.git
```

### Passo 2: Criar o contrato no Forge

Crie um contrato simples usando o Forge dentro do projeto ScaffoldETH2.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract SimpleStorage {
    uint256 public data;

    function storeData(uint256 _data) public {
        data = _data;
    }
}
```

### Passo 3: Executar o dApp

```bash
yarn dev
```

Abra o browser e veja o frontend interagir diretamente com o contrato que você acabou de criar e testar.

---

## Conclusão

Nesta aula, vimos como o ScaffoldETH2 e o Forge podem ser integrados para criar um ambiente de desenvolvimento full-stack para contratos inteligentes. A **ABI** atua como a ponte entre o contrato e o frontend, enquanto o **FWT** facilita o fluxo de trabalho entre testes e deploy. Finalizamos com um exemplo prático para consolidar os conceitos.

---

## Lição de Casa

1. Explore o ScaffoldETH2 e crie um contrato inteligente simples com ele.
2. Use o Forge para compilar e testar esse contrato.
3. Conecte-o ao frontend e veja o resultado.

---

## Próxima Aula

Na próxima aula, vamos abordar o suporte ao **Vyper** no Forge. Até lá!
