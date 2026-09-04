# Como trabalhamos

Regras curtas, feitas para um time de seis pessoas em um semestre. Se uma regra estiver
atrapalhando mais do que ajudando, abra uma issue e a gente muda — não a ignore em silêncio.

## Fluxo de trabalho

1. Todo trabalho começa por uma **issue** no Project board.
2. Você move a issue para *Em andamento* e cria uma branch a partir da `main`.
3. Commits pequenos e frequentes.
4. Abre **Pull Request** para a `main`, marcando `Closes #<numero>`.
5. Outro integrante revisa. **Ninguém aprova o próprio PR.**
6. CI verde + 1 aprovação → merge (squash).

A `main` é protegida: sem push direto, sem force push. Ela precisa estar sempre rodando,
porque é dela que sai a demo para o parceiro e para a banca.

## Branches

```
feat/agenda-semanal
fix/login-token-expirado
docs/requisitos-funcionais
chore/atualizar-dependencias
```

Formato: `<tipo>/<descricao-curta-em-kebab-case>`.
Tipos: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`.

## Commits

Conventional Commits, em português:

```
feat(agenda): exibir atendimentos da semana
fix(auth): tratar sessão expirada ao voltar do background
docs(adr): registrar escolha do Firestore
```

Escopos usuais: `agenda`, `pacientes`, `particulares`, `integracao`, `auth`, `ci`, `adr`.

## Pull Requests

- Título no mesmo formato do commit.
- Descreva **o que mudou e como testar**. Se mexeu em tela, coloque print ou GIF.
- PR grande demais para revisar em 15 minutos provavelmente deveria ser dois PRs.
- Revisor: rode a branch na sua máquina antes de aprovar. Aprovação sem rodar não vale.

## Código

- `flutter analyze` sem warnings antes de abrir PR.
- `dart format .` antes do commit.
- Organização por feature: `lib/features/<modulo>/{data,domain,presentation}`.
- Nada de credencial, chave ou dado real de paciente no repositório. Nunca. Isso vale
  também para prints em issues e para o material da apresentação.
