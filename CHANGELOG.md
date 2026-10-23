# Changelog

## 0.3.0 · 2026-10-23

- Nova skill **`conforme-documentos`**: levanta fatos no código (dados, provedores, países, prazos, direitos, segurança) em `.conforme/fatos.md` e redige minutas de política de privacidade, termos de uso, contrato controlador e operador, registro de operações, relatório de impacto, teste de legítimo interesse e comunicação de incidente à ANPD e ao titular. Confere coerência entre documento e código; divergência vira achado.
- Modelos adaptados de goul4rt/lgpd-skills (MIT), sem valores pré-preenchidos que pareçam fato. Créditos em `THIRD_PARTY_NOTICES.md`. Modelo de termos de uso próprio, com blocos B2C do CDC.
- Resolução CD/ANPD 15/2024 conferida no Diário Oficial (arts. 5º, 6º, 9º e 10) e incluída em `legislacao.md`.

## 0.2.0 · 2026-10-23

- **Revisão independente de achados** (`references/revisao-independente.md`): um revisor sem acesso ao raciocínio de quem encontrou tenta derrubar cada achado. Vereditos confirmado, precisa validar (vira pergunta ao usuário, sem severidade) e rejeitado (vai para `.conforme/rejeitados.md`). CRÍTICA e ALTA usam subagente novo; MÉDIA e BAIXA, segunda leitura do zero. Método inspirado na cloudflare/security-audit-skill.
- `conforme-corrigir` e `conforme-pr` só agem sobre achados confirmados.
- **Fechamento em quatro listas** no relatório e na correção: atualizado, testado, pendente, não verificado.
- Teste confere que todos os manifestos têm a mesma versão.

## 0.1.0 · 2026-10-23

Primeira versão.

- Orquestrador `conforme` com mapeador `scan.sh` (19 categorias de pontos quentes) e relatório em `.conforme/relatorio.md`.
- Skills de domínio: `conforme-ecommerce`, `conforme-saas`, `conforme-apps`, `conforme-ia`, `conforme-lgpd`.
- `conforme-corrigir` com protocolo de correção segura e `conforme-pr` para revisão de pull request.
- Referências de legislação (CDC, Decretos 7.962/2013 e 11.034/2022, Lei 10.962/2004, LGPD, Marco Civil, ECA Digital, LBI) e jurisprudência (STF Temas 987, 533 e 786; STJ Súmulas 297, 359, 385, 479, 532, 550 e 608; STJ Temas 710 e 929) conferidas contra o acervo ctresb-leis em 2026-10-23.
- Manifestos para Claude Code, Codex, Gemini CLI e Cursor.
