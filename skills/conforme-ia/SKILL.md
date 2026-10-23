---
name: conforme-ia
description: Revisão jurídica do código de agentes de IA, chatbots, copilotos e decisões automatizadas no Brasil. Confere transparência de que é IA, dados pessoais enviados a provedores de LLM e transferência internacional, logs de conversa e retenção, revisão e explicação de decisões automatizadas (LGPD art. 20, STJ Súmula 550 e Tema 710), responsabilidade de chatbots pela tese do STF (Temas 987/533), ações do agente com efeito real (cobrança, cancelamento, envio), prompt injection como falha de segurança (LGPD art. 46) e uso por menores. Use para "revisa meu agente", "chatbot de atendimento", "WhatsApp com IA", "n8n/LangChain/OpenAI/Anthropic/Gemini", "score automático", "IA decide crédito ou bloqueio".
---

# Conforme: agentes de IA e decisões automatizadas

Normas em `../conforme/references/legislacao.md`. Precedentes em `../conforme/references/jurisprudencia.md`.

Não há lei de IA em vigor no Brasil. O PL 2.338/2023 está em tramitação: **não cite como lei**. A base é CDC, LGPD, Marco Civil e a tese do STF.

## Onde procurar

Chamadas ao provedor de LLM, montagem do prompt (o que entra de dado do usuário), ferramentas (tools) que o agente pode chamar, armazenamento de conversas, webhooks de WhatsApp ou chat, regras de decisão automática (aprovar, recusar, bloquear, precificar), telas onde a resposta aparece.

## Checklist

### Transparência
- [ ] O usuário sabe que fala com IA antes ou no início da conversa (CDC art. 6º, III; Temas 987/533 do STF exigem identificar bots).
- [ ] Caminho para atendimento humano quando o assunto é reclamação, cancelamento ou cobrança (Decreto 7.962 art. 4º, V; Decreto 11.034 para regulados).
- [ ] Resposta da IA sobre preço, prazo ou condição comercial **vincula** como oferta (CDC art. 30). Valores devem vir de fonte de verdade (banco, API), não da geração do modelo.

### Dados enviados ao modelo
- [ ] Só o necessário vai no prompt (LGPD art. 6º, III). CPF, cartão, saúde e senha não vão, ou vão mascarados.
- [ ] Provedor fora do Brasil é transferência internacional: base nos arts. 33 a 36 da LGPD e cláusulas-padrão da Res. CD/ANPD 19/2024. Provedor listado na política de privacidade.
- [ ] Opção de não treinar com dados do cliente ativada no provedor, quando existir, e documentada.
- [ ] Dados sensíveis (saúde, religião, biometria) só com base do art. 11.

### Conversas e logs
- [ ] Retenção definida para conversas, com exclusão automática (LGPD arts. 15 e 16).
- [ ] Logs sem segredo, token ou dado de cartão.
- [ ] Usuário pode pedir acesso e exclusão das conversas (LGPD art. 18).

### Decisões automatizadas
- [ ] Decisão que afeta interesse do titular (crédito, preço, bloqueio de conta, recusa de pedido, seleção) tem **revisão disponível** e explicação dos critérios quando pedida (LGPD art. 20).
- [ ] Score de crédito: sem consentimento, mas com esclarecimento de fontes e dados valorados (STJ Súmula 550 e Tema 710). Sem dados sensíveis ou excessivos no modelo.
- [ ] Registro de quais variáveis e qual versão do modelo decidiram, para responder pedido de revisão.

### Ações com efeito real
- [ ] Tools que cobram, estornam, cancelam, enviam mensagem ou apagam dados exigem confirmação do usuário ou regra determinística no back-end. O modelo não decide valor.
- [ ] Permissões das tools pelo princípio do menor privilégio; a tool confere identidade e tenant no servidor.
- [ ] Prompt injection tratada como falha de segurança (LGPD art. 46): conteúdo de terceiros (e-mail, página, documento) não pode disparar tool sensível sem confirmação.
- [ ] Limite de taxa e de custo por usuário.

### Conteúdo gerado
- [ ] Chatbot que publica ou distribui conteúdo: presunção de responsabilidade por conteúdo ilícito em "rede artificial de distribuição" (Temas 987/533, item 4). Filtro de saída e trilha de auditoria.
- [ ] Público com menores: ver `conforme-apps` (ECA Digital).

## Correções frequentes

- Função `redactPII(text)` única aplicada antes de toda chamada ao LLM, com teste por tipo de dado.
- Mensagem de abertura "Você está falando com um assistente virtual" e comando "falar com atendente".
- Tool de cobrança que recebe `orderId`, busca o valor no banco e pede confirmação, em vez de receber `amount` do modelo.
- Job de expurgo de conversas após o prazo de retenção, com dry-run.

Aplique com `conforme-corrigir`.
