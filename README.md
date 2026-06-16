# 📦 Gestão de Estoque

Projeto desenvolvido por **Brenda Amanda da Silva Garcez** e **Rayane Custódio**

## 📌 Sobre o projeto
Sistema desenvolvido em Flutter para gerenciamento de estoque, permitindo o controle de fornecedores e produtos.

## 🚀 Funcionalidades
- Dashboard Dinâmica com contador de métricas e status geral.
- Cadastro, Listagem, Edição e Exclusão de Produtos, Clientes e Fornecedores.
- **Gestão de Estoque Completa**: Movimentações (Entrada/Saída) com vínculo opcional de clientes/fornecedores e Vendas.
- **Relatório de Estoque Gerencial**: Geração local e nativa de um arquivo Excel (`.xlsx`) com múltiplas abas rastreando movimentações e vendas.
- **Recursos Nativos Integrados**:
  - Acesso à **Câmera e Galeria** do dispositivo para anexar fotos e comprovantes.
  - Acesso ao **File System (Sistema de Arquivos)** do Android/iOS para gravar as planilhas localmente.
  - Abertura automática de visualizadores de planilha no dispositivo móvel.
- Interface intuitiva com suporte nativo a Tema Claro/Escuro (Light & Dark mode).
- Tratamento assíncrono rigoroso de erros na interface de usuário via SnackBar.

## 🛠️ Tecnologias e Padrões
- **Flutter & Dart**: Arquitetura padrão de mercado separando Views, ViewModels (Provider) e Repositories.
- **Consumo Direto de API Web HTTP**: Integração 100% via API REST pura usando `package:http`, com parsing JSON minucioso e tratamento robusto de exceções/status errors.
- **PocketBase (Backend)**: Banco de dados, API e Autenticação.

## ▶️ Como executar o projeto

### 1. Backend (PocketBase)

Veja o guia completo em [backend/README.md](backend/README.md).

Resumo:

1. Baixe o `pocketbase.exe` em [pocketbase.io/docs](https://pocketbase.io/docs/) e coloque na pasta `backend/`
2. Inicie o servidor:

```powershell
cd backend
.\pocketbase.exe serve
```

3. No painel admin (`http://127.0.0.1:8090/_/`), deixe as regras de API das coleções em branco (acesso público em desenvolvimento)

### 2. App Flutter

Em **outro terminal**, na raiz do projeto:

```bash
git clone https://github.com/RaayaneCustodio/gestao_estoque.git
cd gestao_estoque
flutter pub get
flutter run -d windows
```

O app conecta em `http://127.0.0.1:8090` (configurável em `lib/services/api_config.dart`). No celular via USB, use `adb reverse tcp:8090 tcp:8090`.

## 📂 Estrutura do projeto
lib/
 ├── app/
 ├── services/      # URL e cliente PocketBase
 ├── models/
 ├── repositories/  # CRUD no banco
 ├── viewsmodel/
 ├── views/
 ├── widgets/
 └── main.dart
backend/
 ├── pb_migrations/ # schema das coleções
 └── README.md

##📄 Licença
Este projeto é apenas para fins acadêmicos.

## Ideia
Construido o figma do zero
https://www.figma.com/design/eofQpAuNBrxFQRv6X09cq7/AppFluter?node-id=0-1&t=MXRztmJbW1p7ovUi-1
