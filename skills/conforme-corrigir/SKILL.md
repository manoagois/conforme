---
name: conforme-corrigir
description: Aplica correções de conformidade jurídica no código sem quebrar a aplicação. Protocolo de linha de base de testes, diff mínimo, migration reversível, feature flag quando muda comportamento de cobrança ou dados, teste de regressão por achado e verificação final. Use depois de uma auditoria conforme, ou para "corrige esses achados", "aplica a correção", "implementa o arrependimento/cancelamento/banner de cookies sem quebrar nada", "fix compliance issues safely".
---

# Conforme: correção segura

Objetivo: corrigir o achado e provar que nada que funcionava parou de funcionar. Se não der para provar, não aplique: entregue o diff e diga o que falta.

## Antes de tocar no código

1. **Leia o achado e o código inteiro envolvido**: a função, quem chama (`grep` pelo nome), testes existentes, tipos, migrations relacionadas.
2. **Descubra os comandos de verificação** do projeto: `test`, `build`, `typecheck`, `lint`, CI em `.github/workflows`. Se não houver nenhum, diga ao usuário e combine o mínimo (ao menos build e um teste novo).
3. **Rode a linha de base** e guarde o resultado. Teste que já falhava antes não é culpa sua, mas precisa constar no relatório.
4. **Confira o estado do Git.** Trabalhe numa branch própria (`conforme/<id-do-achado>`) ou worktree se houver outras sessões. Não misture alteração alheia no seu commit.

## Regras da alteração

- **Um achado por commit.** Mensagem com o id: `fix(conforme): CF-012 aviso prévio de renovação`.
- **Diff mínimo**, no padrão do projeto: mesmo estilo, mesma camada, mesmas libs. Nada de dependência nova para poucas linhas.
- **Preserve** validação, tratamento de erro, acessibilidade e segurança existentes.
- **Teste de regressão** para cada correção de lógica: um teste que falharia antes e passa depois.
- **Texto e UI**: altere o texto exato, mantenha classes e tokens do design system, confira contraste e tamanho de fonte quando a lei exige (preço à vista, fonte mínima 12 na Lei 10.962 art. 2º, III; contrato de adesão no CDC art. 54, § 3º).

### Mudanças que pedem cuidado extra

| Tipo | Como fazer sem quebrar |
|---|---|
| Banco de dados | Migration nova e aditiva (coluna nullable, tabela nova). Nunca apague coluna ou dado na mesma entrega. Escreva o rollback. Rode em base de teste antes. |
| Cobrança e assinatura | Atrás de feature flag ou por data de corte. Não reprocessar cobranças antigas sem decisão do usuário. Estorno automático só com dry-run e lista revisada. |
| Exclusão e anonimização de dados | Dry-run com contagem primeiro. Backup ou soft delete antes do hard delete. Respeite guarda obrigatória (Marco Civil art. 15: 6 meses de registros de acesso; obrigações fiscais). |
| Logs com PII | Mascarar na origem (helper único), não apagar logs antigos sem decisão. |
| Cookies e rastreamento | Bloquear scripts até o consentimento sem remover a tag; o time de marketing precisa saber o impacto. |
| Fluxo de autenticação ou permissões | Teste para cada papel. Nunca afrouxe regra existente para "fazer funcionar". |

## Depois da alteração

1. Rode de novo todos os comandos da linha de base. Compare.
2. Se algo quebrou: corrija ou reverta. Não entregue vermelho.
3. Atualize `.conforme/relatorio.md`: marque o achado como corrigido, com commit e comandos rodados.
4. Atualize documentação que a mudança afeta (README, política, termos, changelog).
5. Relate em uma linha por achado: corrigido, testado com quais comandos, e o que ficou pendente.

## Nunca

- Push, deploy, merge ou publicação sem pedido explícito do usuário.
- Apagar dados de produção.
- Desligar teste, lint ou checagem de tipo para passar.
- Afirmar que testou sem ter rodado.
