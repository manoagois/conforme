# Como conferir uma norma ou precedente na hora

Use quando for citar algo marcado **[conferir]**, algo fora das listas, ou quando o usuário pedir confirmação.

## 1. Acervo ctresb-leis (texto simples, rápido)

Repositório público com legislação e jurisprudência em Markdown, com cabeçalho YAML e link para a fonte oficial. Leia o arquivo cru:

```
https://raw.githubusercontent.com/leoparreira21/ctresb-leis/main/<caminho>
```

| O que | Caminho |
|---|---|
| Lei federal | `federal/leis-ordinarias/<ano>/lei-<numero>-<aaaa-mm-dd>.md` (ex.: `federal/leis-ordinarias/1990/lei-8078-1990-09-11.md`) |
| Lei complementar | `federal/leis-complementares/<ano>/...` |
| Decreto | `federal/decretos/<ano>/...` |
| Súmula STJ | `jurisprudencia/stj/sumulas/sumula-<n>.md` |
| Repetitivo STJ | `jurisprudencia/stj/repetitivos/tema-<n>.md` |
| Repercussão geral STF | `jurisprudencia/stf/repercussao-geral/tema-<n>.md` |
| Súmula vinculante | `jurisprudencia/stf/sumulas-vinculantes/sumula-vinculante-<n>.md` |
| Lei estadual | `estaduais/<UF>/leis-ordinarias/<ano>/...` |
| Ato de regulador | `reguladores/<orgao>/...` (ex.: `anpd`, `bcb`) |

Não clone o repositório: tem vários GB. Busque o arquivo pontual. Para descobrir o nome exato de uma lei, liste a pasta do ano pela API do GitHub:

```bash
gh api repos/leoparreira21/ctresb-leis/contents/federal/leis-ordinarias/2018 --jq '.[].name' | grep 13709
```

O acervo avisa que os textos são conversões e não substituem o Diário Oficial. Sempre leve o link `fonte:` do cabeçalho para o relatório.

## 2. Fontes oficiais

- Leis e decretos: `https://www.planalto.gov.br/ccivil_03/` (texto compilado)
- STJ: pesquisa de jurisprudência em `https://scon.stj.jus.br/SCON/` e precedentes qualificados em `https://processo.stj.jus.br/repetitivos/`
- STF: `https://portal.stf.jus.br/jurisprudencia/` e temas em `https://portal.stf.jus.br/jurisprudenciaRepercussao/`
- CNJ, Banco Nacional de Precedentes: `https://pangeabnp.pdpj.jus.br/`
- ANPD: `https://www.gov.br/anpd/`

## 3. O que registrar no achado

- Nome e número da norma ou precedente, artigo ou item da tese
- Link da fonte
- Data em que você conferiu
- Se a tese ainda está pendente de publicação, diga isso

Se não conseguir acessar nenhuma fonte, mantenha a citação só da lei já listada em `legislacao.md` e marque o precedente como "não conferido nesta execução".
