# Requisitos

> Esqueleto. Preencher na Sprint 1, a partir da proposta do parceiro e da primeira reunião.
> Todo requisito precisa de origem rastreável: proposta, ata de reunião, ou decisão da equipe.

## Requisitos funcionais

| ID | Requisito | Módulo | Prioridade | Origem |
|----|-----------|--------|-----------|--------|
| RF01 | O terapeuta autentica-se no app com credenciais próprias | auth | Alta | equipe |
| RF02 | O terapeuta visualiza sua agenda do dia | agenda | Alta | proposta |
| RF03 | O terapeuta visualiza sua agenda da semana | agenda | Alta | proposta |
| RF04 | O terapeuta cadastra um paciente com dados essenciais | pacientes | Alta | proposta |
| RF05 | O terapeuta consulta o histórico de sessões de um paciente | pacientes | Alta | proposta |
| RF06 | O terapeuta sinaliza horários disponíveis para atendimento particular | particulares | Alta | proposta |
| RF07 | O terapeuta gerencia (edita/remove) seus horários particulares | particulares | Média | proposta |
| RF08 | Os atendimentos criados na secretaria aparecem no app | integracao | Alta | proposta |
| RF09 | | | | |

## Requisitos não funcionais

| ID | Requisito | Critério verificável |
|----|-----------|---------------------|
| RNF01 | O app roda em iOS e Android a partir de uma única base de código | build gerado nas duas plataformas |
| RNF02 | A agenda do dia continua legível sem conexão | cache offline do Firestore, testado em modo avião |
| RNF03 | Um terapeuta não acessa dados de outro | regras do Firestore com teste automatizado |
| RNF04 | Dados pessoais de paciente tratados conforme a LGPD | ver `05-arquitetura.md`, seção Privacidade |
| RNF05 | A agenda do dia carrega em menos de 2s em rede 4G | medição registrada no plano de testes |

## Fora de escopo

- Substituir o sistema desktop da secretaria.
- Visão administrativa ou financeira da clínica.
- Agendamento pelo paciente final.
