# Modelagem de dados — Firestore

> Rascunho inicial, a validar com a Rokuzen na primeira reunião. Campos marcados com ⚠️
> dependem de confirmação do parceiro.

## Princípio

O Firestore não tem JOIN. Dados que aparecem juntos na mesma tela são **desnormalizados**
dentro do documento: a agenda do dia precisa mostrar o nome do paciente, então o
atendimento guarda `pacienteNome` além de `pacienteId`. A duplicação é intencional; o
custo dela é manter os dois em sincronia quando o paciente é renomeado (feito por uma
Cloud Function).

## Coleções

### `terapeutas/{terapeutaId}`

| Campo | Tipo | Notas |
|-------|------|-------|
| `nome` | string | |
| `email` | string | espelha o Firebase Auth |
| `unidades` | array\<string\> | ids das unidades onde atende ⚠️ um terapeuta atende em mais de uma? |
| `idExterno` | string | id do terapeuta no sistema da secretaria ⚠️ |
| `ativo` | bool | |

### `unidades/{unidadeId}`

`nome`, `endereco`. Golden Square (SBC), Grand Plaza (Santo André), Mooca Plaza, West Plaza.

### `pacientes/{pacienteId}`

| Campo | Tipo | Notas |
|-------|------|-------|
| `nome` | string | |
| `telefone` | string | |
| `dataNascimento` | timestamp | ⚠️ necessário? |
| `observacoes` | string | ⚠️ **cuidado:** anotação clínica é dado sensível (LGPD). Ver `docs/05-arquitetura.md` |
| `criadoPor` | string | terapeutaId |
| `criadoEm` | timestamp | |

⚠️ Decisão pendente: o paciente pertence à clínica ou ao terapeuta? Isso muda quem pode ler
o cadastro e é a primeira pergunta a fazer na reunião.

### `atendimentos/{atendimentoId}`

| Campo | Tipo | Notas |
|-------|------|-------|
| `terapeutaId` | string | |
| `pacienteId` | string | |
| `pacienteNome` | string | desnormalizado |
| `unidadeId` | string | |
| `inicio` / `fim` | timestamp | |
| `tipo` | string | `clinica` \| `particular` |
| `status` | string | `agendado` \| `realizado` \| `cancelado` \| `falta` |
| `origem` | string | `secretaria` \| `app` — de onde veio o registro |
| `anotacoes` | string | preenchido pelo terapeuta após a sessão |

**Consulta principal:** `where terapeutaId == X and inicio >= A and inicio < B order by inicio`
→ exige índice composto (`terapeutaId`, `inicio`).

### `disponibilidades/{disponibilidadeId}`

Horários que o terapeuta abre para atendimento particular.

`terapeutaId`, `inicio`, `fim`, `unidadeId`, `recorrencia` (⚠️ semanal? ou avulso?),
`status` (`livre` | `reservado`).

## Regras de segurança (esboço)

- Terapeuta lê e escreve apenas documentos onde `terapeutaId == request.auth.uid`.
- Ninguém escreve em `atendimentos` com `origem == "secretaria"` pelo app.
- `pacientes`: leitura conforme a decisão pendente acima.

As regras ficam em `firestore.rules` e são revisadas como código.

## Perguntas abertas para o parceiro

1. Um paciente é da clínica ou do terapeuta? Quem pode ver o cadastro?
2. O que a secretaria precisa enxergar do que o terapeuta faz no app?
3. Atendimento particular usa a sala da unidade? Precisa de aprovação da secretaria?
4. Que anotação o terapeuta guarda sobre a sessão — e quem mais pode lê-la?
5. O sistema desktop atual tem banco acessível, API, ou exportação de arquivo?
