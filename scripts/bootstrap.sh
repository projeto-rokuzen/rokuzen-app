#!/usr/bin/env bash
# Cria o projeto Flutter dentro de app/ e instala as dependências base.
# Rode uma vez, no início do projeto, a partir da raiz do repositório.
set -euo pipefail

if ! command -v flutter >/dev/null; then
  echo "Flutter não encontrado. Instale antes: https://docs.flutter.dev/get-started/install"
  exit 1
fi

echo "==> Criando o projeto Flutter em app/"
flutter create \
  --org br.edu.maua.rokuzen \
  --project-name rokuzen_terapeuta \
  --platforms=ios,android \
  app

cd app

echo "==> Adicionando dependências"
flutter pub add \
  firebase_core \
  firebase_auth \
  cloud_firestore \
  provider \
  intl \
  table_calendar

flutter pub add --dev flutter_lints mocktail

echo "==> Estrutura por feature"
mkdir -p lib/core/{theme,widgets,utils} \
         lib/features/{auth,agenda,pacientes,particulares}/{data,domain,presentation}

cat > lib/firebase_options.example.dart <<'EOF'
// Stub usado apenas pelo CI. O arquivo real (firebase_options.dart) é gerado
// por `flutterfire configure` e NÃO é versionado.
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => const FirebaseOptions(
        apiKey: 'stub',
        appId: 'stub',
        messagingSenderId: 'stub',
        projectId: 'stub',
      );
}
EOF

echo
echo "Pronto. Próximos passos:"
echo "  1. Crie o projeto no console do Firebase"
echo "  2. dart pub global activate flutterfire_cli"
echo "  3. cd app && flutterfire configure"
echo "  4. flutter run"
