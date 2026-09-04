# Rokuzen Mobile

Projeto Integrador Interdisciplinar · TTI206 · 2026-2 · Instituto Mauá de Tecnologia
Parceiro: **Rokuzen — Clínica de Terapia**

Aplicativo multiplataforma (iOS/Android) em Flutter que complementa — sem substituir — o
sistema desktop já usado pela secretaria da Rokuzen, dando ao terapeuta uma visão móvel
da sua rotina de atendimentos.

## Módulos

| # | Módulo | O que entrega |
|---|--------|---------------|
| 1 | Visão do Terapeuta | Agenda diária e semanal dos atendimentos do profissional |
| 2 | Gestão de Pacientes | Cadastro simplificado e histórico básico de sessões |
| 3 | Atendimentos Particulares | Terapeuta sinaliza e gerencia seus horários próprios |
| 4 | Integração | Sincronização com o sistema interno da secretaria |

O escopo detalhado será fechado nas reuniões com o parceiro.

## Stack

| Camada | Tecnologia | Por quê |
|--------|-----------|---------|
| Front-end | Flutter / Dart | Exigido pela disciplina (Desenvolvimento Multiplataforma) |
| Autenticação | Firebase Auth | Pronto, sem escrever gestão de senha/token |
| Banco | Cloud Firestore (NoSQL) | NoSQL é o desejável nas regras do TTI206 |
| Back-end | Cloud Functions (Python) | Apenas para regras que não podem viver no cliente |
| CI | GitHub Actions | `flutter analyze` + `flutter test` em todo PR |

## Como rodar

Pré-requisitos: Flutter estável (`flutter --version`), Node 20+ (Firebase CLI), conta no
Firebase com acesso ao projeto.

O projeto Flutter ainda não existe no repositório. Para criá-lo, uma única vez:

```bash
./scripts/bootstrap.sh
```

Depois disso, no dia a dia:

```bash
cd app
flutter pub get
flutterfire configure          # gera lib/firebase_options.dart (não versionado)
flutter run
```

Para rodar contra os emuladores locais, sem tocar em dados reais:

```bash
firebase emulators:start
flutter run --dart-define=USE_EMULATOR=true
```

## Estrutura

```
app/          aplicativo Flutter (código do produto)
functions/    Cloud Functions em Python (back-end)
scripts/      utilitários de setup
.github/      templates de issue/PR e workflows de CI
```

## Como contribuir

Leia [CONTRIBUTING.md](CONTRIBUTING.md) antes do primeiro commit. Regra curta: ninguém
faz push na `main`, todo trabalho nasce de uma issue e entra por Pull Request com uma
revisão de outro integrante.

## Equipe

| Nome | GitHub | Papel |
|------|--------|-------|
| Guilherme Tomaz Gomes | @guit953 | |
| | | |
| | | |
| | | |
| | | |
| | | |

Professor responsável: _a preencher_ · Contato Rokuzen: _a preencher_
