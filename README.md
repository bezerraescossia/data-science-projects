# Data Analysis and Machine Learning Project (CRISP-DM)

Esta pasta centraliza os projetos de Data Science que estou desenvolvendo, todos organizados de acordo com a metodologia CRISP-DM (Cross-Industry Standard Process for Data Mining). Essa metodologia oferece uma abordagem estruturada e flexível para o processo de análise de dados, aplicável a diversas tarefas, como análise descritiva, inferência estatística e modelagem preditiva. A estrutura de pastas organizada abaixo facilita o desenvolvimento e a manutenção de todos os projetos, permitindo uma abordagem reprodutível e escalável. Além disso, esta pasta servirá como um repositório para showcase dos meus projetos, bem como para consulta pessoal, permitindo o acompanhamento contínuo e a evolução das minhas análises e modelos.

## Estrutura de Diretórios

### `/_analyzes`
Esta pasta contém arquivos e scripts dedicados à **análise dos dados**. Aqui, você encontrará notebooks e códigos relacionados ao processo de exploração dos dados e diferentes tipos de análise, como:

- **Análises Descritivas**: Exploração inicial dos dados, sumarização e visualização.
- **Análises Inferenciais**: Aplicação de testes estatísticos e inferências para tirar conclusões sobre os dados.
- **Modelagem Preditiva**: Construção de modelos de machine learning ou estatísticos para previsão e análise de tendências.

### `/_data`
A pasta `_data` armazena os arquivos brutos ou processados que são usados durante o processo de análise. Exemplos de dados incluem conjuntos de dados em formatos como CSV, Excel, JSON, entre outros.

### `/_envs`
Contém os arquivos de configuração do ambiente para garantir que as dependências do projeto sejam corretamente gerenciadas. Estes arquivos são usados para criar e manter ambientes específicos de trabalho, utilizando o Conda. Todos os ambientes possuem o mesmo nome do respectivo notebook, facilitando a organização e a consistência entre os projetos.

```bash
conda env create -f _envs/nome_do_ambiente.yml
```

### `/_models`
A pasta `_models` armazena os **modelos treinados**, sejam modelos de machine learning ou outros tipos de modelos estatísticos. Aqui, você encontrará modelos salvos que podem ser carregados para previsão ou análise posterior.

### `/_templates`
Os templates são arquivos base, como notebooks Jupyter ou scripts, que servem como ponto de partida para as análises e modelagens. Eles incluem o código padrão, como importação de dados, pré-processamento e treinamento de modelos.

## Data Mining Problem Types:

1. Data description and summarization
2. Segmentation
3. Concept descriptions
4. Classification
5. Prediction
6. Dependency analysis
7. 