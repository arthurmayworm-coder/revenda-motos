# 🏍️ Revenda de Motos - Arthur

Sistema de gerenciamento de uma **revenda de motos** desenvolvido em **PostgreSQL**.  
O projeto organiza **clientes, funcionários, motos, acessórios e vendas**, com tabelas normalizadas e relacionamentos bem definidos.  


## 🚀 Funcionalidades

- 📋 Cadastro de **clientes**  
- 🏍️ Cadastro de **motos** com controle de estoque  
- 👨‍💼 Cadastro de **funcionários** com cargo e salário  
- 💰 Registro de **vendas** (ligando cliente, funcionário e motos vendidas)  
- 🛠️ Cadastro de **acessórios** para motos  
- 🔗 Relacionamentos completos entre entidades  
- 👀 **Views prontas** para relatórios:
  - `vw_vendas_completo` → mostra vendas detalhadas  
  - `vw_motos_estoque` → mostra motos disponíveis no estoque  


## 🗂️ Estrutura do Banco

### Principais Tabelas
- `Clientes`  
- `Motos`  
- `Funcionarios`  
- `Vendas`  
- `Moto_Acessorios`  
- `Venda_Motos`  

### Relacionamentos
- **Um cliente** → pode ter **muitas vendas**  
- **Um funcionário** → pode realizar **muitas vendas**  
- **Uma venda** → pode ter **várias motos** (tabela intermediária `Venda_Motos`)  
- **Acessórios** → cadastrados de forma independente  






<img width="674" height="784" alt="arthur (1)" src="https://github.com/user-attachments/assets/b73b4b43-830d-4bbf-abe5-02b41ca05262" />

