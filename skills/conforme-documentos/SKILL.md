---
name: conforme-documentos
description: Redige as minutas que a lei exige a partir do que o código realmente faz. Política de privacidade, termos de uso, contrato controlador e operador (LGPD art. 39), registro de operações (art. 37), relatório de impacto (art. 38), teste de legítimo interesse (art. 10), comunicação de incidente à ANPD e ao titular (Res. CD/ANPD 15/2024) e página do encarregado (art. 41). Levanta dados coletados, provedores, países e prazos no próprio repositório, pergunta só as decisões de negócio e nunca inventa fato. Use para "redige a política de privacidade", "faz os termos de uso", "contrato de operador", "DPA", "ROPA", "RIPD", "LIA", "vazou dado, preciso comunicar a ANPD", ou quando a auditoria conforme apontar documento faltando.
---

# Conforme: documentos

Normas em `../conforme/references/legislacao.md`. Precedentes em `../conforme/references/jurisprudencia.md`. Modelos em `modelos/`.

O diferencial: o documento descreve o que o sistema **faz**, conferido no código, e não o que alguém lembra que ele faz. Política que promete o que o código não cumpre é publicidade enganosa (CDC art. 37) e falta de transparência (LGPD art. 6º, VI).

## Fluxo

### 1. Levantar fatos do código

Grave em `.conforme/fatos.md`, cada linha com a fonte (`arquivo:linha`):

| Fato | Onde achar |
|---|---|
| Dados pessoais coletados, por entidade | schemas, migrations, formulários, tipos |
| Dados sensíveis (art. 11) e de menores (art. 14) | campos de saúde, biometria, religião, data de nascimento |
| Finalidade de cada dado | onde o campo é lido |
| Provedores que recebem dados e o país | imports de SDK, chamadas HTTP, `.env.example`, webhooks (LLM, e-mail, analytics, pagamento, scraping, hospedagem) |
| Prazos de retenção | jobs de expurgo, TTL, soft delete; "nenhum" também é fato |
| Direitos do titular disponíveis | rotas de exportar, corrigir, excluir, revogar |
| Medidas de segurança | criptografia, RLS, hash de senha, controle de acesso, logs de auditoria |
| Cookies e rastreadores | scripts e SDKs carregados |
| Papel do produto | quem decide a finalidade: o produto (controlador) ou o cliente que o usa (produto como operador) |

Use também o relatório da auditoria (`.conforme/relatorio.md`) se existir.

### 2. Perguntar só o que o código não diz

Uma pergunta por vez, e só se mudar o documento:
- razão social, CNPJ, endereço, contato e encarregado;
- B2C, B2B ou os dois;
- base legal das atividades em que o código não deixa claro (ex.: busca de pessoas em redes sociais para mensagem fria);
- prazos de retenção que o controlador quer adotar quando o código não tem nenhum.

### 3. Redigir a partir dos modelos

| Documento | Modelo | Quando |
|---|---|---|
| Política de privacidade | `modelos/politica-de-privacidade.md` | sempre que há dado pessoal |
| Termos de uso | `modelos/termos-de-uso.md` | produto com conta, plano ou cobrança |
| Contrato controlador e operador | `modelos/contrato-operador.md` | SaaS B2B que trata dados dos clientes do cliente; e com cada operador do produto |
| Registro de operações | `modelos/registro-de-operacoes.md` | controlador e operador (art. 37) |
| Relatório de impacto | `modelos/relatorio-de-impacto.md` | alto risco: dados sensíveis, menores, decisão automatizada, larga escala, vigilância, ou legítimo interesse com pedido da ANPD (art. 10, § 3º) |
| Teste de legítimo interesse | `modelos/teste-legitimo-interesse.md` | toda atividade com base no art. 7º, IX |
| Comunicação à ANPD | `modelos/incidente-comunicacao-anpd.md` | incidente com risco ou dano relevante (Res. 15/2024, art. 5º), em 3 dias úteis |
| Comunicação ao titular | `modelos/incidente-comunicacao-titular.md` | mesmo caso, 3 dias úteis, linguagem simples (art. 9º) |

Página do encarregado: um bloco na política e no rodapé com nome e canal (art. 41, § 1º).

Grave cada minuta em `.conforme/documentos/<nome>.md`.

### 4. Regras de redação

- **Todo fato vem de `.conforme/fatos.md` ou de resposta do usuário.** Sem fonte, deixe `[PREENCHER: o que falta]`.
- **Toda norma citada** está em `legislacao.md` ou foi conferida na hora (`../conforme/references/verificacao.md`). O acervo ctresb-leis tem a legislação federal e estadual e os precedentes vinculantes; resoluções da ANPD se conferem no Diário Oficial (`in.gov.br`) ou em `gov.br/anpd`.
- **Não prometa o que o código não faz.** Se a política vai dizer "você pode excluir sua conta", a rota existe. Se não existe, a minuta diz o canal real e o achado vai para `conforme-corrigir`.
- Linguagem simples, frases curtas, cláusula que limita direito em destaque (CDC art. 54, § 4º).
- Primeira linha de toda minuta: `MINUTA gerada a partir do código em {data}. Revisar com advogado antes de publicar ou assinar.`
- Decisão de negócio não se resolve com texto. Se a atividade não tem base legal possível, diga isso no topo da minuta e no chat, em vez de inventar uma.

### 5. Coerência entre documentos e código

Antes de entregar, confira:
- cada operador da política está no registro de operações e tem contrato;
- cada prazo de retenção da política existe no código ou está marcado como pendente de implementação;
- cada direito prometido tem caminho real no produto.

Divergência vira achado no relatório, com severidade.

### 6. Fechamento

Termine com as quatro listas (`../conforme/references/formato-achado.md`): **atualizado** (minutas geradas), **testado** (coerência conferida), **pendente** (campos `[PREENCHER]`, decisões, código a corrigir) e **não verificado**.

## Limites

Minuta não é parecer. Publicar política, assinar contrato ou comunicar a ANPD é decisão do controlador, com revisão jurídica. Nunca envie a comunicação de incidente nem publique nada sem pedido explícito.

## Créditos

Os modelos de política, contrato de operador, registro de operações, relatório de impacto, teste de legítimo interesse e comunicações de incidente foram adaptados de [goul4rt/lgpd-skills](https://github.com/goul4rt/lgpd-skills) (MIT). Ver `THIRD_PARTY_NOTICES.md` na raiz do repositório.
