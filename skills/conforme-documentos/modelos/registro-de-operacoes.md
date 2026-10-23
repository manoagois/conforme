<!-- Modelo adaptado de goul4rt/lgpd-skills (MIT, Copyright (c) 2026 goul4rt), https://github.com/goul4rt/lgpd-skills. Ver THIRD_PARTY_NOTICES.md. -->
<!-- Campos entre chaves {...} são preenchidos com fato do código (.conforme/fatos.md) ou resposta do usuário. Campo sem fonte fica como [PREENCHER: ...]. Nunca invente. -->

# Registro de Operações de Tratamento de Dados Pessoais (ROPA)

**Controlador**: {razão social} | **CNPJ**: {nº} | **Endereço**: {endereço}
**Encarregado (DPO)**: {nome} | **Contato**: {e-mail / telefone}
**Versão**: v{N} | **Data**: {data} | **Próxima revisão**: {data + 6 meses}

## Changelog

- v1.0 ({data}): publicação inicial
- v1.1 ({data}): {alteração}

---

## I. Atividades como Controlador

### A001: {nome da atividade}

| Campo | Conteúdo |
|---|---|
| **Finalidade** | {específica, determinada, explícita} |
| **Base legal** | Art. {7º/11}, inciso {N} |
| **Categorias de titulares** | {ex.: usuários adultos; marcar se há adolescentes ou crianças} |
| **Categorias de dados comuns** | {campos encontrados no schema} |
| **Categorias de dados, sensíveis** | nenhum / {listar} |
| **Fonte dos dados** | coletado do titular / observado / inferido / terceiro |
| **Compartilhamento interno** | {times/empresas do grupo} |
| **Compartilhamento externo (operadores)** | {AWS, Datadog, ...} |
| **Transferência internacional?** | Não / Sim, ver `.conforme/documentos/ (cláusulas-padrão do operador)` |
| **Período de armazenamento** | {prazo}, critério: {legal/contratual/anonimização} |
| **Medidas de segurança** | {somente medidas conferidas no código ou na infraestrutura} |
| **Decisão automatizada?** | Não / Sim, ver `.conforme/documentos/relatorio-de-impacto-a001.md` |
| **Alto risco?** | Não / Sim: RIPD: `.conforme/documentos/relatorio-de-impacto-a001.md` |
| **Observações** | {qualquer informação relevante} |

### A002, ...

(Repetir para cada atividade)

---

## II. Atividades como Operador

### O001: {nome da atividade}

| Campo | Conteúdo |
|---|---|
| **Controlador** | {nome do cliente / parceiro} |
| **Contrato/DPA** | `.conforme/documentos/contrato-operador-{operador}.md` |
| **Finalidade (do controlador)** | {qual finalidade nos foi instruída} |
| **Categorias de dados** | {recebidas do controlador} |
| **Medidas de segurança aplicadas** | {idem} |
| **Sub-operadores autorizados** | {lista: Art. 39, § 1º} |
| **Devolução/eliminação ao fim** | {previsão contratual} |

---

## III. Resumo executivo

- **Total de atividades como controlador**: {N}
- **Total como operador**: {M}
- **Atividades com dados sensíveis**: {N}
- **Atividades com menores**: {N} (avaliação ECA Digital: ver `checklist ECA Digital da skill conforme-apps`)
- **Atividades de alto risco com RIPD**: {N}
- **Transferências internacionais ativas**: {N}
- **Operadores ativos com DPA assinado**: {N}/{M total}

## IV. Anexos

- Política de privacidade vigente: `.conforme/documentos/politica-de-privacidade.md`
- LIAs: `.conforme/documentos/`
- RIPDs: `.conforme/documentos/`
- DPAs: `.conforme/documentos/`
- Cláusulas-padrão Res. 19/2024: `.conforme/documentos/`
