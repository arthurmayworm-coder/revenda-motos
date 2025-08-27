# 🏍️ Revenda de Motos - Arthur

Sistema de gerenciamento de uma **revenda de motos** desenvolvido em **PostgreSQL**.  
Organiza **clientes, funcionários, motos, acessórios e vendas**, com tabelas normalizadas e relacionamentos claros.  

---

## 🚀 Funcionalidades

- 📋 Cadastro de **clientes**  
- 🏍️ Cadastro de **motos** com controle de estoque  
- 👨‍💼 Cadastro de **funcionários** com cargo e salário  
- 💰 Registro de **vendas** (ligando cliente, funcionário e motos vendidas)  
- 🛠️ Cadastro de **acessórios** para motos  
- 🔗 Relacionamentos completos entre entidades  
- 👀 **Views prontas** para relatórios:
  - `vw_vendas_completo` → vendas detalhadas  
  - `vw_motos_estoque` → motos disponíveis no estoque  

---

## 🗂️ Estrutura do Banco

### Principais Tabelas
- `clientes`  
- `motos`  
- `funcionarios`  
- `vendas`  
- `moto_acessorios`  
- `venda_motos`  

### Relacionamentos
- **Um cliente** → pode ter **muitas vendas**  
- **Um funcionário** → pode realizar **muitas vendas**  
- **Uma venda** → pode ter **várias motos** (`venda_motos`)  
- **Acessórios** → cadastrados de forma independente  

---

## 📘 Relatório de Execução – Banco `db_revenda_arthur`

### 1️⃣ Criação do Banco e Tabelas
- Criei o banco **db_revenda_arthur**  
- Configurei todas as tabelas, chaves primárias e estrangeiras  
- Criei **views** para relatórios detalhados  

### 2️⃣ Inserção de Dados
- Adicionei registros de exemplo: clientes, motos, funcionários, vendas e acessórios  

### 3️⃣ Atualização de Registros com NULL
- Atualizei várias colunas para **NULL** (nome, CPF, telefone, email, estoque, etc.)  
- Isso permitiu avaliar o impacto das consultas **JOIN**  

### 4️⃣ Criação de Usuários e Permissões
- **mayworm** → todas as permissões no banco ✅  
- **romeu** → apenas permissão de **leitura (SELECT)** ✅  

### 5️⃣ Execução das 12 Consultas com JOINs

#### Clientes × Vendas
- **INNER JOIN** → nenhum registro (IDs null)  
- **LEFT JOIN** → todos os clientes aparecem; colunas de vendas = NULL  
- **RIGHT JOIN** → todas as vendas aparecem; colunas de clientes = NULL  

#### Funcionários × Vendas
- **INNER JOIN** → nenhum registro  
- **LEFT JOIN** → todos os funcionários aparecem; colunas de vendas = NULL  
- **RIGHT JOIN** → todas as vendas aparecem; colunas de funcionários = NULL  

#### Vendas × Venda_Motos
- **INNER JOIN** → nenhum registro  
- **LEFT JOIN** → todas as vendas aparecem; colunas de venda_motos = NULL  
- **RIGHT JOIN** → todos os registros de venda_motos aparecem; colunas de vendas = NULL  

#### Motos × Venda_Motos
- **INNER JOIN** → nenhum registro  
- **LEFT JOIN** → todas as motos aparecem; colunas de venda_motos = NULL  
- **RIGHT JOIN** → todos os registros de venda_motos aparecem; colunas de motos = NULL  

✅ **Resumo:**  
- `INNER JOIN` → só retorna registros com correspondência  
- `LEFT JOIN` → preserva todos os registros da tabela da esquerda  
- `RIGHT JOIN` → preserva todos os registros da tabela da direita  

---

### 6️⃣ Execução das Views
- `vw_vendas_completo` → registros com campos NULL após update  
- `vw_motos_estoque` → nenhum registro (estoques atualizados para NULL)  

---

### 7️⃣ Comparação Antes × Depois do Update
| Situação | Resultado das consultas |
|-----------|------------------------|
| Antes     | Todos os dados completos; joins funcionavam normalmente |
| Depois    | Muitos registros aparecem como NULL; inner join retorna vazio; left e right join mostram impacto das chaves null |

---

### 8️⃣ Conclusão
- Alterar dados para NULL impacta os resultados das consultas  
- Tipos de JOIN se comportam de forma previsível:
  - **INNER JOIN** → restritivo, só mostra correspondência  
  - **LEFT JOIN** → preserva a tabela da esquerda  
  - **RIGHT JOIN** → preserva a tabela da direita  
- Permissões funcionaram corretamente:
  - **mayworm** → pode fazer tudo  
  - **romeu** → só pode ler  








<img width="674" height="784" alt="arthur (1)" src="https://github.com/user-attachments/assets/b73b4b43-830d-4bbf-abe5-02b41ca05262" />

