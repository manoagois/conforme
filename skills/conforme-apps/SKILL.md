---
name: conforme-apps
description: Revisão jurídica do código de aplicativos web e mobile no Brasil. Confere cookies e rastreamento antes do consentimento, permissões do celular, guarda de registros de acesso (Marco Civil art. 15), exclusão de conta dentro do app, conteúdo gerado por usuário com canal de denúncia e moderação conforme a tese do STF sobre o art. 19 do Marco Civil (Temas 987/533), ECA Digital para público infantil e adolescente (verificação de idade, supervisão parental, loot boxes, perfilamento), notificações de marketing e acessibilidade (LBI art. 63). Use para "revisa meu app", "rede social/comunidade/fórum", "app para crianças", "cookies", "React Native/Flutter/Expo/Next.js app conforme a lei".
---

# Conforme: aplicativos e plataformas

Normas em `../conforme/references/legislacao.md`. Precedentes em `../conforme/references/jurisprudencia.md`.

## Primeiro: quem usa e o que circula

Descubra pelo código e pelos textos do app, e pergunte só se não der:
- O app é **direcionado** a menores ou de **acesso provável** por eles (jogos, educação, redes, vídeos)? Se sim, ECA Digital inteiro.
- Usuários publicam conteúdo visível a outros? Se sim, bloco de conteúdo de usuário.
- Há conteúdo impróprio para menores de 18? Se sim, verificação de idade é obrigatória.

## Checklist

### Cookies, SDKs e rastreamento
- [ ] Scripts e SDKs de analytics e publicidade (GA, Meta Pixel, TikTok, Hotjar, Clarity, AppsFlyer, Firebase Analytics) **só carregam depois** do consentimento, quando a base é consentimento (LGPD art. 7º, I e art. 8º; Marco Civil art. 7º, IX; Guia de cookies da ANPD).
- [ ] Recusar é tão fácil quanto aceitar; revogar é possível depois (LGPD art. 8º, § 5º).
- [ ] Cookies estritamente necessários separados dos demais.
- [ ] App mobile: permissões (localização, contatos, câmera, microfone) pedidas no momento do uso, com finalidade dita, e o app funciona sem as não essenciais (LGPD art. 6º, I e III).

### Registros e conta
- [ ] Registros de acesso (data, hora, IP, porta de origem quando houver NAT) guardados por **6 meses**, sob sigilo e com acesso controlado (Marco Civil art. 15). Guardar demais também é problema (LGPD art. 6º, III).
- [ ] Exclusão de conta **dentro do app**, sem exigir e-mail ao suporte (LGPD art. 18, VI; Marco Civil art. 7º, X). As lojas Apple e Google também exigem.
- [ ] Notificações e e-mails de marketing com opt-out em um toque e separados dos transacionais.

### Conteúdo de usuário (STF, Temas 987/533)
- [ ] **Canal de notificação** acessível em cada conteúdo, com protocolo. Após notificação de conteúdo ilícito, há dever de agir (art. 21 do Marco Civil pela tese do STF).
- [ ] Fila de moderação com trilha de auditoria: quem decidiu, quando, por qual regra.
- [ ] **Remoção imediata** e prevenção para o rol de crimes graves da tese (terrorismo, abuso infantil, induzimento a suicídio etc.). Falha sistêmica gera responsabilidade.
- [ ] Conteúdo **pago ou impulsionado** e contas automatizadas tratados à parte: responsabilidade presumida sem notificação.
- [ ] Bots identificados como bots.
- [ ] Autor do conteúdo removido é avisado e pode contestar.
- [ ] Remover cópias de conteúdo já declarado ilícito por decisão judicial (hash ou similar).
- [ ] Conteúdo íntimo não consentido removido após notificação da vítima (Marco Civil art. 21).

### ECA Digital (Lei 15.211/2025), quando aplicável
- [ ] Configuração mais protetiva **por padrão** (art. 7º): perfil privado, sem mensagem de desconhecidos, sem geolocalização pública.
- [ ] Conteúdo adulto: verificação de idade confiável **a cada acesso**, sem autodeclaração (art. 9º, § 1º). "Tenho mais de 18 [sim]" é CRÍTICA.
- [ ] Dados da verificação de idade usados só para isso (art. 13).
- [ ] Contas de até 16 anos vinculadas à conta de um responsável (art. 24).
- [ ] Supervisão parental com aviso visível quando ativa (arts. 16 a 18).
- [ ] **Sem loot boxes** em jogos direcionados ou de acesso provável (art. 20).
- [ ] Sem perfilamento para publicidade a menores e sem perfil comportamental (arts. 22 e 26).
- [ ] Canal de denúncia e retirada de conteúdo que viole direitos de menores, com contestação (arts. 28 a 30).
- [ ] LGPD art. 14: consentimento específico de um dos pais para dados de criança.

### Acessibilidade (LBI art. 63)
- [ ] Imagens com texto alternativo, navegação por teclado e leitor de tela, contraste, foco visível, rótulos em campos de formulário. Use WCAG 2.2 AA como referência técnica.
- [ ] Símbolo de acessibilidade em destaque (art. 63, § 1º).

## Correções frequentes

- Gerenciador de consentimento que injeta scripts por categoria só após aceite, com teste que confere que nenhum pixel dispara antes.
- Tabela de `access_logs` com TTL de 6 meses e acesso restrito, em migration aditiva.
- Botão "Excluir conta" com confirmação, soft delete imediato e eliminação após o prazo de guarda.
- Endpoint `POST /reports` com protocolo, fila e notificação ao autor.

Aplique com `conforme-corrigir`.
