# Formato de achado

Todo achado segue este formato. Achado sem arquivo e linha, ou sem norma, não entra no relatório.

````markdown
### CF-012 · ALTA · Assinatura renova sem aviso prévio

**Onde:** `src/billing/renew.ts:48`
**O que o código faz:** `renewSubscription()` cobra o cartão no vencimento sem e-mail prévio e sem opção de cancelar no mesmo fluxo.
**Por que é problema:** CDC art. 6º, III (informação) e art. 39, III (serviço sem solicitação, se o plano mudou). Cobrança indevida paga gera devolução em dobro (CDC art. 42, p.u.; STJ EAREsp 676.608/RS, Tema 929 pendente de acórdão).
**Risco concreto:** chargeback, Procon, ação com devolução em dobro.
**Correção proposta:**
```diff
- await charge(sub.customerId, sub.amount)
+ if (!sub.renewalNoticeSentAt) return scheduleRenewalNotice(sub)
+ await charge(sub.customerId, sub.amount)
```
**Como provar que não quebrou:** teste `renew.test.ts` cobre assinatura com e sem aviso; build e typecheck verdes.
**Confiança:** alta (lei) · média (aplicação do precedente ao caso)
````

## Severidade

| Nível | Quando |
|---|---|
| CRÍTICA | Expõe dados, permite fraude, cobra sem autorização, ou viola vedação expressa (ex.: loot box para menor, verificação de idade por autodeclaração em conteúdo adulto) |
| ALTA | Descumpre regra objetiva de lei com sanção ou dano provável (preço à vista ausente, arrependimento sem canal, renovação sem aviso, PII em log) |
| MÉDIA | Falta de informação ou evidência que enfraquece a defesa (sem registro de aceite, sem versão de termos) |
| BAIXA | Boa prática ligada a norma, sem risco imediato |

## Regras

- Cite o artigo. Precedente só se estiver em `jurisprudencia.md` ou conferido (`verificacao.md`).
- Separe fato (o que o código faz) de interpretação (por que é problema) e de recomendação.
- Diga "não encontrei" quando não encontrar. Nunca afirme que algo existe sem ter lido o arquivo.
- Achado de UI ou texto precisa do componente e do texto exato.
- Não é parecer jurídico. Em dúvida sobre a aplicação ao caso, marque confiança média e recomende revisão por advogado.

## Relatório

Grave em `.conforme/relatorio.md`:

```markdown
# Relatório Conforme

**Projeto:** nome · **Tipo:** e-commerce | SaaS | app | agente de IA · **Data:** AAAA-MM-DD
**Stack detectada:** ...
**Escopo lido:** pastas e arquivos (e o que ficou de fora)

## Resumo
| Severidade | Qtde |
|---|---|
| CRÍTICA | 0 |
...

## Achados
(um bloco por achado, do mais grave ao mais leve)

## Fora do alcance desta análise
Itens que dependem de documento, contrato ou operação, não de código.
```
