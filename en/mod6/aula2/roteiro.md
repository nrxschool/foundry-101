# Aula 2: Guardando Chaves com Cast Wallet

## Abertura

Nesta aula, vamos aprender a gerenciar chaves privadas de maneira segura usando o **Cast Wallet**. O Cast permite importar, criar e utilizar carteiras, facilitando o gerenciamento de transações e deploys com segurança. Vamos também ver como proteger nossas chaves privadas com keystores, usando o formato criptografado JSON, que é amplamente utilizado no ecossistema Ethereum.

### Programa da aula:

1. Importação de chave privada via Cast Wallet.
2. Usando chaves para deploys e transações.
3. Protegendo chaves com **keystores**.
4. Boas práticas de segurança no gerenciamento de chaves.

---

## 1. Importação de Chave Privada via Cast Wallet

O primeiro passo para usar uma chave privada em scripts e deploys é importá-la. Usaremos o comando `cast wallet import` para importar a chave privada e protegê-la com uma senha.

### Importando uma chave:

1. **Crie um keystore protegido com senha**:

O comando abaixo solicitará sua chave privada e pedirá uma senha para protegê-la. A chave será criptografada e armazenada de forma segura no arquivo keystore.

```bash
cast wallet import --interactive
```

Ao executar este comando, você será solicitado a inserir a chave privada e uma senha. O keystore será gerado e armazenado no diretório padrão `~/.foundry/keystores`.

2. **Exemplo de saída ao importar uma chave privada**:

```bash
Enter your private key: ****************
Enter your password: ****************
Keystore successfully created at: ~/.foundry/keystores/my-wallet
```

---

## 2. Usando Chaves para Deploys e Transações

Depois de importar a chave privada, podemos usá-la para realizar deploys e enviar transações na blockchain. Ao invés de expor a chave diretamente, usamos o arquivo **keystore** com sua senha para desbloquear a chave durante a execução.

### Deploy com Cast usando um keystore:

Suponha que você tenha um contrato chamado `Lock.sol`. Podemos utilizar o comando `cast` para realizar o deploy desse contrato com a chave protegida.

```bash
forge script script/Deploy.s.sol --broadcast --rpc-url <RPC_URL> --account <NOME_DA_CONTA>
```

O Cast automaticamente usará a chave que foi importada no keystore e solicitará a senha para desbloqueá-la. Isso garante que a chave privada nunca fique exposta diretamente.

---

## 3. Protegendo Chaves com **Keystores**

Agora, vamos entender o que é um **keystore** e como ele protege sua chave privada.

### O que é um **Keystore**?

O **keystore** é um arquivo JSON que armazena a chave privada criptografada e protegida com uma senha. Este arquivo garante que a chave privada não seja exposta em texto plano, tornando o uso de chaves mais seguro.

Aqui está um exemplo de um keystore armazenado no seu sistema:

```bash
drwxr-xr-x  5 olivmath  staff   160B Oct 15 00:27 .
drwxr-xr-x  8 olivmath  staff   256B Sep 16 18:19 ..
-rw-r--r--  1 olivmath  staff   436B Sep 16 18:20 main
-rw-r--r--  1 olivmath  staff   436B Oct 15 00:27 my-net
-rw-r--r--  1 olivmath  staff   436B Oct  8 17:22 nova
```

### Explicação do conteúdo do Keystore:

```json
{
  "crypto": {
    "cipher": "aes-128-ctr",
    "cipherparams": { "iv": "0996e371ce75e28afacfa7d24f4df127" },
    "ciphertext": "33f3dc39b98f3996cdd869bb6cec90e1d18605de0c73844e81b949b380f2f696",
    "kdf": "scrypt",
    "kdfparams": {
      "dklen": 32,
      "n": 8192,
      "p": 1,
      "r": 8,
      "salt": "777f5c801d9810dff19a8cda8da05decf5b6c6e081843d636459eff4faff5d6d"
    },
    "mac": "789a9310dd9250c570497f9f16200cbebf0be992880215525fb59e112898d63f"
  },
  "id": "a12c3d32-fb8d-493b-adaf-6d3cebd2555e",
  "version": 3
}
```

### Campos Explicados:

- **crypto**: Contém todos os parâmetros criptográficos necessários para proteger e recuperar a chave privada.
  - **cipher**: O algoritmo usado para criptografar a chave (neste caso, `aes-128-ctr`).
  - **cipherparams**: Parâmetros adicionais, como o **IV** usado na criptografia.
  - **ciphertext**: A chave privada criptografada.
  - **kdf**: A função de derivação de chave usada (aqui, `scrypt`).
  - **kdfparams**: Parâmetros como **salt**, **n**, **p**, e **r** para derivar a chave de criptografia a partir da senha.
  - **mac**: Código de autenticação da mensagem, usado para garantir a integridade do keystore.

Ao usar um **keystore**, a chave privada é criptografada e protegida, oferecendo uma camada adicional de segurança. Para descriptografar e usar a chave, será necessário fornecer a senha usada durante a criação do keystore.

---

## 4. Boas Práticas de Segurança no Gerenciamento de Chaves

- **Use carteiras separadas para desenvolvimento e produção**: Nunca use sua carteira principal com fundos reais em desenvolvimento.
- **Proteja seu keystore**: Nunca compartilhe o arquivo keystore ou a senha.
- **Tenha cuidado com exposição de chaves**: Se você expuser uma chave privada online, considere-a comprometida e transfira os fundos imediatamente.
- **Usar carteiras de hardware**: Para maior segurança, carteiras de hardware como Ledger e Trezor podem ser usadas para assinar transações diretamente sem expor a chave privada.

---

## Conclusão

Nesta aula, aprendemos como importar e proteger chaves privadas usando **Cast Wallet**, além de como usar **keystores** para maior segurança. Também vimos como usar essas chaves para realizar deploys e enviar transações na blockchain. A segurança no gerenciamento de chaves é fundamental para evitar perdas de fundos, então sempre siga as melhores práticas.

---

## Lição de casa

1. Importe uma chave privada usando `cast wallet import --interactive` e proteja-a com uma senha.
2. Utilize o keystore gerado para fazer o deploy de um contrato simples na rede local usando `forge script`.

---

## Próxima Aula

Na próxima aula, vamos integrar o **ScaffoldETH2** com o **Foundry** para construir uma interface frontend interativa para nossos contratos. Até lá!
