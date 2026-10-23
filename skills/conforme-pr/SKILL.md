---
name: conforme-pr
description: Revisa um pull request ou diff com olhar jurídico brasileiro e comenta linha a linha, com norma citada e sugestão de código aplicável. Foca só no que o diff muda (checkout, cobrança, cancelamento, dados pessoais, cookies, moderação, IA) e não repete problemas antigos fora do diff. Use para "revisa esse PR", "comenta o PR com o que fere a lei", "review jurídico do diff", "check this PR for brazilian compliance", ou em CI.
---

# Conforme: revisão de pull request

Normas e precedentes nas referências da skill `conforme` (`../conforme/references/`). Formato de achado em `../conforme/references/formato-achado.md`.

## Fluxo

1. **Obter o diff.**
   - PR no GitHub: `gh pr view <n> --json title,body,files,baseRefName,headRefName` e `gh pr diff <n>`.
   - Local: `git diff <base>...HEAD`.
2. **Classificar os arquivos** pelo domínio (e-commerce, SaaS, app, IA, dados pessoais) e ler as skills de domínio correspondentes.
3. **Ler o contexto**, não só as linhas alteradas: a função inteira e quem a chama. Um diff pequeno pode remover uma proteção que estava em outra linha.
4. **Comentar só o que o diff introduz ou piora.** Problema antigo fora do diff vai, no máximo, em um comentário geral com "pré-existente".
5. **Revisar cada achado** com `../conforme/references/revisao-independente.md`. Só confirmado vira comentário em linha. "Precisa validar" vira pergunta no comentário geral. Rejeitado não aparece.
6. **Escrever comentários** no formato abaixo.
7. **Publicar** só se o usuário pedir. Por padrão, mostre os comentários no chat.

## Formato do comentário

````markdown
**[conforme · ALTA] Preço à vista some na listagem**

Esta alteração mostra só o parcelado no card. A Lei 10.962/2004, art. 2º, III, exige o preço à vista junto à imagem do produto, com fonte de pelo menos 12.

```suggestion
<Price cash={product.priceCash} installments={product.installments} />
```
````

Use bloco `suggestion` só quando a troca for completa e segura nas linhas comentadas. Caso contrário, descreva a correção.

## Publicar no GitHub (com autorização do usuário)

Monte uma revisão única com todos os comentários em linha, para não gerar uma notificação por comentário:

```bash
gh api repos/{owner}/{repo}/pulls/{n}/reviews \
  -f event=COMMENT \
  -f body="Revisão Conforme: N achados (X altas). Detalhes nos comentários." \
  -F 'comments[][path]=src/components/ProductCard.tsx' \
  -F 'comments[][line]=42' \
  -F 'comments[][side]=RIGHT' \
  -F 'comments[][body]=@/tmp/comentario-1.md'
```

Use `event=COMMENT`. Não use `REQUEST_CHANGES` nem `APPROVE` sem pedido explícito.

## Regras

- Comentário sem norma citada não vai.
- Nada de elogio ou estilo de código: o foco é conformidade.
- Não cite precedente fora de `jurisprudencia.md` sem conferir.
- Nunca inclua segredo encontrado no texto do comentário; aponte a linha e mascare.
