# ADR-0001 — Cloud Firestore (NoSQL) como banco de dados

- **Data:** 2026-__-__
- **Status:** proposto
- **Participantes:** equipe

## Contexto

As regras do Projeto Integrador para CIC/SIN/ICD dizem que **é desejável o uso de banco
não relacional (NoSQL)**, e que a escolha de um banco relacional precisa ser justificada
tecnicamente na documentação. Nenhum integrante do grupo trabalhou com NoSQL antes.

O produto é um app móvel usado por terapeutas dentro de unidades em shoppings, onde a
conectividade varia. Os dados são majoritariamente lidos: o terapeuta abre a agenda do dia
muitas vezes e escreve pouco (cadastra um paciente, marca um horário particular).

## Alternativas consideradas

| Alternativa | A favor | Contra |
|-------------|---------|--------|
| Cloud Firestore | Atende o "desejável" das regras; SDK oficial para Flutter; cache offline automático; atualização em tempo real; sem servidor para hospedar ou manter | Modelagem por documentos é nova para o time; consultas com múltiplos filtros exigem índices; agregações são limitadas |
| MongoDB Atlas | Também NoSQL; modelo de documentos mais próximo de SQL na consulta | Exige uma API própria entre app e banco — mais código para escrever, hospedar e quebrar |
| PostgreSQL | Modelo de agenda/pacientes é naturalmente relacional; time já conhece | Contraria o desejável das regras; exige API, hospedagem, autenticação e migrações escritas por nós |

## Decisão

Usar **Cloud Firestore** como banco principal, com **Firebase Auth** para autenticação.

A curva de NoSQL, no nosso caso, é menor do que parece: o escopo tem poucas entidades
(terapeuta, paciente, atendimento, disponibilidade) e as consultas são simples e
previsíveis — "os atendimentos deste terapeuta entre duas datas". É exatamente o formato
em que o Firestore é fácil. O custo que estaríamos evitando com Postgres — familiaridade —
é menor que o custo que ele traria: escrever e hospedar uma API inteira, com autenticação
própria, num semestre.

## Consequências

- Não temos JOIN. Dados que aparecem juntos na tela são **desnormalizados** no documento
  (o atendimento carrega `pacienteNome`, não só `pacienteId`). Isso é decisão consciente,
  não descuido — precisa estar escrito na modelagem.
- Consultas com mais de um filtro pedem índice composto. O Firestore avisa no console e
  gera o índice; guardamos os índices em `firestore.indexes.json`.
- Regras de segurança (`firestore.rules`) passam a ser código crítico: são elas que
  impedem um terapeuta de ler a agenda de outro. Entram na revisão de PR como código.
- Offline funciona de graça no app, o que resolve o problema de conectividade nas unidades.
