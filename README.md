# Como usar

### get_resources_limit_requests.sh

Execute o script usando a seguinte linha de comando:

```bash
./get_resources_limit_requests <NOME_ARQUIVO>
```
Onde  `<NOME_ARQUIVO>` é o nome de um arquivo em texto plano que lista os deployments e seus namespaces usando a seguinte estrura:

```
<NOME_DEPLOYMENT_CONFIG>:<NAMESPACE>
<NOME_DEPLOYMENT_CONFIG_2>:<NAMESPACE_2>
```


### update_resources.sh

Execute o script usando a seguinte linha de comando:

```bash
./update_resources <NOME_ARQUIVO>
```
Onde  `<NOME_ARQUIVO>` é o nome de um arquivo em texto plano que lista os deployments que deseja atualizar as `resources` seus namespaces de origem e destino usando a seguinte estrura:

```
<NOME_DEPLOYMENT_CONFIG_DESTINO>:<NAMESPACE_ORIGEM>:<NAMESPACE_DESTINO>
<NOME_DEPLOYMENT_CONFIG_DESTINO_2>:<NAMESPACE_ORIGEM_2>:<NAMESPACE_DESTINO2>
```


# Como funciona

O script `get_resources_limit_requests.sh <deployment_config>` escreve em um arquivo de variaveis os valores dos limits e requests do deployment config passado por parâmetro, quando o script `update_resources.sh <deployment_config` é chamado, ele utiliza os valores salvos no arquvio de variáveis gerado pelo script anterior para alterar as resources de um deployment config passado por parâmetro 