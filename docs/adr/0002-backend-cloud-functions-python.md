# ADR-0002 — Back-end em Cloud Functions com Python

- **Data:** 2026-__-__
- **Status:** proposto
- **Participantes:** equipe

## Contexto

As regras da disciplina permitem back-end em **Python, Dart ou Node.js**. Com o Firestore
como banco (ADR-0001), o app fala direto com o banco na maior parte das operações — mas
ainda existem regras que não podem viver no cliente: validar conflito de horário,
sincronizar com o sistema da secretaria, e qualquer rotina agendada.

## Alternativas consideradas

| Alternativa | A favor | Contra |
|-------------|---------|--------|
| API própria (FastAPI hospedada) | Controle total; back-end "visível" na documentação | Hospedagem, deploy, CORS, autenticação e monitoramento por nossa conta — muita superfície para quebrar na véspera da banca |
| Cloud Functions em Python | Permitido pelas regras; deploy por um comando; autenticação já resolvida pelo Firebase Auth; só escrevemos a regra de negócio | Cold start; menos controle sobre o ambiente |
| Cloud Functions em Node.js | Mesmas vantagens | Time tem mais familiaridade com Python |

## Decisão

Usar **Cloud Functions for Firebase em Python** para a lógica de servidor, mantendo em
`functions/` um módulo por responsabilidade.

Vale registrar o que isso **não** significa: não é ausência de back-end. A camada de
servidor existe, é versionada, testada e documentada — ela apenas não carrega o peso de
hospedagem e autenticação, que não são o que a disciplina quer nos ver aprendendo.

## Consequências

- O que roda no servidor é uma escolha explícita, não um acidente. Critério: se a regra
  protege integridade de dados ou toca o sistema da secretaria, é Function; se é só
  apresentação, é app.
- Precisamos de um plano de teste local com o **emulador do Firebase**, para não depender
  de deploy a cada mudança.
- A integração com o sistema desktop da secretaria fica isolada em um único módulo
  (`functions/integracao/`), o que permite trocar o mecanismo sem mexer no app — importante
  porque ainda não sabemos o que a Rokuzen consegue expor.
