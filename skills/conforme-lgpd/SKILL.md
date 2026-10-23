---
name: conforme-lgpd
description: Revisão de LGPD no nível do código para qualquer projeto brasileiro. Encontra dado pessoal em log, segredo no repositório, dado de cartão salvo, CPF sem proteção, coleta além do necessário, ausência de endpoint de direitos do titular (acesso, correção, exclusão, portabilidade, prazo de 15 dias), consentimento sem registro ou sem revogação, compartilhamento com terceiros sem aviso (STJ REsp 1.758.799/MG), retenção sem prazo, controle de acesso fraco e falta de trilha para incidente (Res. CD/ANPD 15/2024, 3 dias úteis). Use para "LGPD no código", "dados pessoais", "vazamento", "estou seguro com dados?", "PII", "direito de exclusão". Para documentos, use conforme-documentos.
---

# Conforme: LGPD no código

Normas em `../conforme/references/legislacao.md`. Precedentes em `../conforme/references/jurisprudencia.md`.

Foco: o que o código faz com dados pessoais. Documentos (política de privacidade, termos, contrato de operador, registro de operações, relatório de impacto, teste de legítimo interesse, comunicação de incidente) ficam com `conforme-documentos`, que redige a partir dos fatos levantados aqui.

## Onde procurar

Schemas e migrations (Prisma, SQL, Supabase, ORM), handlers de API, logs e monitoramento (Sentry, Datadog, console), filas e webhooks, integrações de terceiros, buckets de arquivos, `.env.example`, seeds e fixtures, CI.

## Checklist

### Segurança (art. 46)
- [ ] Nenhum segredo no repositório nem no front-end. Chave encontrada: aponte arquivo e linha, mascare o valor no relatório e recomende **rotacionar** a chave, não só apagar.
- [ ] Dado pessoal fora de logs, mensagens de erro, analytics e URLs. Procure `console.log(user)`, `logger.info(req.body)`, query string com e-mail ou CPF.
- [ ] Número de cartão e CVV não armazenados.
- [ ] Senhas com hash forte (bcrypt, scrypt, argon2). MD5, SHA1 ou texto puro é CRÍTICA.
- [ ] Autorização no servidor em todo endpoint que lê dado de outro usuário (IDOR). RLS ativo em Supabase com políticas que filtram pelo dono.
- [ ] Buckets de arquivos com documento ou foto privados, com URL assinada.
- [ ] Dados de produção fora de seeds, fixtures e ambientes de teste.

### Necessidade e finalidade (art. 6º)
- [ ] Cada campo pessoal coletado tem uso no código. Campo nunca lido é coleta excessiva.
- [ ] CPF só quando há motivo (nota fiscal, crédito, antifraude) e dito ao usuário.
- [ ] Dados sensíveis (art. 11) identificados e com base legal própria.

### Direitos do titular (arts. 18 e 19)
- [ ] Caminho para acesso, correção, exclusão, portabilidade e revogação de consentimento, na interface ou por canal do encarregado.
- [ ] Resposta completa em até **15 dias** (art. 19, II); o sistema registra data do pedido e da resposta.
- [ ] Exclusão alcança cópias (réplicas, buscas, analytics, CRM, provedores), respeitando guarda obrigatória (art. 16).

### Consentimento e compartilhamento
- [ ] Consentimento registrado com finalidade, data, versão do texto e meio; revogação tão fácil quanto dar (art. 8º, § 5º).
- [ ] Compartilhamento ou venda de base a terceiros só com base legal e aviso ao titular. Sem comunicação prévia, STJ reconhece dano moral presumido (REsp 1.758.799/MG, a conferir; CDC art. 43, § 2º).
- [ ] Terceiros que recebem dados listados (SDKs, CRMs, LLMs, e-mail).

### Retenção (arts. 15 e 16)
- [ ] Prazo definido por tipo de dado, com job de expurgo ou anonimização.
- [ ] Guarda obrigatória respeitada: registros de acesso por 6 meses (Marco Civil art. 15), documentos fiscais pelo prazo tributário.

### Incidente (art. 48; Res. CD/ANPD 15/2024)
- [ ] Logs de auditoria de acesso a dados pessoais suficientes para saber o que vazou, de quem e quando.
- [ ] Contato do encarregado divulgado (art. 41).
- [ ] Registro de incidentes mantido por 5 anos; comunicação à ANPD e titulares em 3 dias úteis quando houver risco relevante.
- Vazamento de dado comum não gera dano moral presumido segundo a 2ª Turma do STJ (AREsp 2.130.619/SP, a conferir), mas o dever de segurança e as sanções administrativas continuam.

## Correções frequentes

- Helper `mask()` e serializer de log que remove campos pessoais por padrão, com teste.
- Mover chave para variável de ambiente, adicionar ao `.gitignore`, rotacionar no provedor (passo do usuário).
- Política RLS `auth.uid() = user_id` com teste de acesso cruzado.
- Rota `GET /me/export` (JSON) e `DELETE /me` com soft delete e expurgo agendado.

Aplique com `conforme-corrigir`.
