# Contribuindo

## Regras para leis e precedentes

1. **Fonte oficial obrigatória.** Planalto, STJ, STF, CNJ (Banco Nacional de Precedentes) ou ANPD. Blog e notícia não servem como fonte.
2. **Data da conferência.** Todo item novo diz quando foi conferido.
3. **Status honesto.** Se você não leu o texto integral, o item entra como "a conferir".
4. **Impacto em código.** Precedente sem efeito em tela, fluxo ou dado não entra: aqui não é repositório de jurisprudência geral.
5. **Tese pendente.** Se o acórdão não foi publicado, diga isso e mantenha a referência anterior.

Os arquivos são `skills/conforme/references/legislacao.md` e `skills/conforme/references/jurisprudencia.md`.

## Regras para skills

- `name` no frontmatter igual ao nome da pasta.
- `description` diz o que a skill faz e quando dispara, em até 1.000 caracteres.
- Checklist com artigo citado em cada item.
- Correção sugerida segue o protocolo de `conforme-corrigir`.

## Mapeador

Ao mudar `skills/conforme/scripts/scan.sh`, acrescente o caso em `tests/fixtures/` e a categoria esperada em `tests/run.sh`.

## Antes do pull request

```bash
bash tests/run.sh
shellcheck skills/conforme/scripts/scan.sh tests/run.sh
```

Atualize o `CHANGELOG.md`.
