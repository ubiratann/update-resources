# Como usar

### get_resources_limit_requests.sh

Execute o script usando a seguinte linha de comando:

```bash
./get_resources_limit_requests $NOME_DO_DEPLOYMENT_CONFIG
```

### update_resources.sh

Execute o script usando a seguinte linha de comando:

```bash
./update_resources $NOME_DO_DEPLOYMENT_CONFIG
```

# Como funciona

O script `get_resources_limit_requests.sh <deployment_config>` escreve em um arquivo de variaveis os valores dos limits e requests do deployment config passado por parâmetro, quando o script `update_resources.sh <deployment_config` é chamado, ele utiliza os valores salvos no arquvio de variáveis gerado pelo script anterior para alterar as resources de um deployment config passado por parâmetro 