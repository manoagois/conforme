---
name: conforme-saas
description: Revisão jurídica do código de SaaS e produtos por assinatura no Brasil. Confere trial que vira cobrança, renovação automática e aviso, cancelamento pelo mesmo canal e sem barreira, cobrança após cancelamento (devolução em dobro, CDC art. 42 e STJ Tema 929), reajuste, multa de fidelidade, aceite e versão dos termos, contratos B2B e assinatura eletrônica, isolamento entre clientes, exportação e exclusão de dados ao encerrar a conta. Use para "revisa minha cobrança recorrente", "Stripe/Asaas/Pagar.me/Iugu/Mercado Pago assinatura", "cancelamento está ok?", "termos de uso", "SaaS B2B conforme LGPD".
---

# Conforme: SaaS e assinaturas

Normas em `../conforme/references/legislacao.md`. Precedentes em `../conforme/references/jurisprudencia.md`.

## Primeiro: B2C ou B2B?

Pergunte se não estiver claro no código ou no site. Com consumidor final, o CDC se aplica integralmente. Entre empresas, aplica-se o Código Civil e o contrato, mas o CDC pode alcançar pequena empresa vulnerável. A LGPD vale nos dois casos; no B2B o SaaS costuma ser **operador** dos dados do cliente.

## Onde procurar

Webhooks do gateway, jobs de renovação e cobrança, tela de planos e checkout, área de cobrança do cliente, fluxo de cancelamento, e-mails de aviso, modelo de dados de `subscription`, `invoice`, `tenant`, middleware de autorização, termos e aceite.

## Checklist

### Contratação e trial
- [ ] Preço, periodicidade, renovação automática e como cancelar ditos **antes** do pagamento (CDC art. 6º, III; Decreto 7.962 art. 4º, I).
- [ ] Trial que vira pago: data da primeira cobrança visível no aceite e lembrete antes dela. Sem lembrete é achado ALTA em B2C.
- [ ] Nenhum add-on, assento extra ou upgrade cobrado sem ação expressa do cliente (CDC art. 39, III; STJ Súmula 532 por analogia).
- [ ] Arrependimento de 7 dias para contratação online B2C (CDC art. 49), com reembolso integral.

### Renovação, reajuste e cobrança
- [ ] Job de renovação confere se a assinatura ainda está ativa **no momento** da cobrança (condição de corrida com cancelamento).
- [ ] Cancelamento interrompe cobranças futuras no gateway, não só no banco local. Procure `cancel` que atualiza status sem chamar a API do gateway.
- [ ] Cobrança indevida (após cancelamento, duplicada, valor errado) estornada automaticamente. Cobrança indevida paga gera devolução em dobro (CDC art. 42, p.u.; EAREsp 676.608/RS; Tema 929 do STJ com acórdão pendente).
- [ ] Reajuste com aviso prévio e índice previsto no contrato.
- [ ] Documento de cobrança com nome, endereço e CNPJ do fornecedor (CDC art. 42-A).
- [ ] Idempotência nos webhooks (mesmo evento não cobra nem estende duas vezes).

### Cancelamento
- [ ] Cancelar online se contratou online, sem exigir ligação ou chat obrigatório (Decreto 7.962 art. 4º, V; para serviços regulados, Decreto 11.034 art. 14, I: por todos os meios usados para contratar, com efeito imediato).
- [ ] Fluxo de retenção não pode virar barreira: no máximo uma oferta, botão de confirmar sempre visível (CDC art. 39 e art. 51, IV).
- [ ] Confirmação do cancelamento com protocolo, data e efeito.
- [ ] Multa de fidelidade proporcional ao tempo restante e prevista no contrato (CDC art. 39, V e art. 51).

### Termos e prova
- [ ] Termos versionados; aceite registrado com versão, data e hora, usuário e IP (CDC art. 6º, VIII inverte o ônus; o registro é a prova da empresa).
- [ ] Mudança relevante de termos exige novo aceite, não só aviso.
- [ ] B2B com cobrança judicial em vista: assinatura eletrônica adequada (Lei 14.063/2020; STJ REsp 1.495.920/DF, a conferir).

### Dados do cliente (B2B e B2C)
- [ ] Isolamento entre tenants testado: toda query filtra pelo tenant no back-end, ou RLS ativo. Vazamento entre clientes é CRÍTICA (LGPD art. 46).
- [ ] Exportação de dados do cliente em formato aberto (LGPD art. 18, V; também argumento comercial contra lock-in).
- [ ] Exclusão ao encerrar a conta, respeitando guarda obrigatória (LGPD art. 16; Marco Civil art. 15: 6 meses de registros de acesso; obrigações fiscais).
- [ ] Subprocessadores (hospedagem, e-mail, LLM, analytics) listados; dados fora do Brasil seguem LGPD arts. 33 a 36 e Res. CD/ANPD 19/2024.
- [ ] Rode também `conforme-lgpd`.

## Correções frequentes

- Guarda `if (sub.status !== 'active' || sub.cancelAtPeriodEnd) return` no job, com teste da corrida.
- `cancel()` que chama o gateway, grava `canceledAt`, envia protocolo e é idempotente.
- Tabela `terms_acceptance (user_id, terms_version, accepted_at, ip)` em migration aditiva.
- E-mail de lembrete D-3 antes da primeira cobrança pós-trial, atrás de feature flag.

Aplique com `conforme-corrigir`.
