# Backend PocketBase

## 1. Baixar o PocketBase

1. Acesse [https://pocketbase.io/docs/](https://pocketbase.io/docs/)
2. Baixe o executável para **Windows** (arquivo `.zip`)
3. Extraia `pocketbase.exe` nesta pasta (`backend/`)

## 2. Subir o servidor

No terminal, dentro da pasta `backend`:

```powershell
cd backend
.\pocketbase.exe serve
```

Na primeira execução as migrações em `pb_migrations/` criam as coleções:
`products`, `suppliers`, `customers`, `sales`.

O painel admin fica em: **http://127.0.0.1:8090/_/**

## 3. Regras de API (desenvolvimento)

Para o app Flutter gravar e ler sem login, em cada coleção no admin defina as regras **List / View / Create / Update / Delete** como vazias (campo em branco = acesso público).

Isso é só para desenvolvimento. Autenticação virá em etapa posterior.

## 4. Rodar o Flutter

Em outro terminal, na raiz do projeto:

```powershell
cd ..
flutter pub get
flutter run -d windows
```

Mantenha o PocketBase rodando enquanto usa o app.
