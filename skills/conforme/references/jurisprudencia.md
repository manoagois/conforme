# Jurisprudência de referência

Precedentes que mudam como software deve ser construído no Brasil. Cada item tem o grau de confirmação:

- **Conferido**: texto oficial lido no acervo [ctresb-leis](https://github.com/leoparreira21/ctresb-leis) (fonte: caderno de súmulas do STJ, dados abertos do STJ ou Banco Nacional de Precedentes do CNJ) em 2026-10-23.
- **Conferir**: precedente conhecido, mas o texto integral não foi lido nesta versão. Antes de citar em relatório, siga `verificacao.md`.

Regra dura: **não cite número de processo, súmula ou tema que não esteja nesta lista ou que você não tenha conferido na hora**. Se não houver precedente, diga que a recomendação se apoia só na lei.

## STF

### Tema 987 e Tema 533: art. 19 do Marco Civil (2025) · Conferido

Art. 19 da Lei 12.965/2014 é **parcial e progressivamente inconstitucional**. Até nova lei:

1. Provedor de aplicação responde, nos termos do **art. 21** do MCI (notificação extrajudicial), por conteúdo de terceiro em caso de crime ou ato ilícito. Vale também para contas denunciadas como inautênticas.
2. Crimes contra a honra continuam no regime do art. 19 (ordem judicial), sem impedir remoção por notificação.
3. Replicação de conteúdo já declarado ofensivo por decisão judicial: remover as cópias a partir de notificação, sem nova decisão.
4. **Presunção de responsabilidade** para conteúdo ilícito em **anúncios e impulsionamentos pagos** e em **redes artificiais de distribuição (chatbots ou robôs)**, independentemente de notificação. Afasta-se provando atuação diligente e em tempo razoável.
5. **Dever de cuidado**: falha sistêmica ao não remover de imediato um rol taxativo de crimes graves (atos antidemocráticos, terrorismo, induzimento a suicídio ou automutilação, discriminação, violência contra a mulher, crimes sexuais contra vulneráveis e contra crianças, tráfico de pessoas).

Itens seguintes da tese (marketplaces sob o CDC, serviços de e-mail e mensageria privada sob o art. 19, autorregulação com canal de notificação, devido processo e relatório anual, representante legal no Brasil, efeitos prospectivos): **conferir** no texto integral do STF, porque o registro do CNJ no acervo está truncado no item 5.3.

Impacto em código: canal de denúncia com protocolo e prazo, fila de moderação com trilha de auditoria, regra separada para conteúdo pago, bots identificados, aviso e contestação ao autor removido.

### Tema 786: direito ao esquecimento (2021) · Conferido

É incompatível com a Constituição um direito ao esquecimento entendido como o poder de impedir, pela passagem do tempo, a divulgação de fatos verídicos e licitamente obtidos. Abusos são analisados caso a caso.

Impacto em código: pedido de "apagar meu histórico público" não se resolve por esse fundamento. Pedido de eliminação de **dados pessoais** segue a LGPD (art. 18, VI e art. 16), que é outra coisa.

### ADIs 6387, 6388, 6389, 6390 e 6393 (2020) · Conferir

Referendo da suspensão da MP 954/2020 (compartilhamento de dados de telefonia com o IBGE). Marco do reconhecimento da proteção de dados como direito fundamental autônomo, depois positivado pela EC 115/2022 (art. 5º, LXXIX, CF).

## STJ: súmulas

| Súmula | Enunciado (resumo fiel) | Uso em software | Status |
|---|---|---|---|
| 297 | CDC se aplica às instituições financeiras | fintech, carteira digital, BNPL | Conferido |
| 359 | Cabe ao mantenedor do cadastro de proteção ao crédito notificar o devedor antes da inscrição | integração com birôs, negativação automática | Conferido |
| 385 | Anotação irregular não gera dano moral se havia inscrição legítima anterior, ressalvado o cancelamento | régua de cobrança | Conferido |
| 479 | Instituições financeiras respondem objetivamente por fortuito interno relativo a fraudes de terceiros em operações bancárias | antifraude, Pix, conta digital | Conferido |
| 532 | Enviar cartão de crédito sem prévia e expressa solicitação é prática abusiva, ilícito indenizável e sujeito a multa | por analogia: ativar produto, add-on ou plano sem pedido expresso (CDC art. 39, III) | Conferido |
| 550 | Score de crédito dispensa consentimento, mas o consumidor pode pedir esclarecimento sobre dados valorados e fontes | modelos de risco, decisões automatizadas (LGPD art. 20) | Conferido |
| 608 | CDC se aplica a planos de saúde, salvo autogestão | healthtech | Conferido |

## STJ: repetitivos e turmas

### Tema 710: credit scoring (2014) · Conferido

Score é lícito (Lei 12.414/2011), respeitados privacidade e máxima transparência. Sem consentimento, mas com dever de esclarecer fontes e informações valoradas quando solicitado. Uso de dados sensíveis ou excessivos, ou recusa indevida de crédito por dado incorreto, pode gerar dano moral.

Impacto: endpoint ou tela "por que recebi esta nota/decisão", sem dados sensíveis no modelo, trilha das variáveis usadas.

### Tema 929: repetição em dobro do art. 42 do CDC · Conferido (acórdão pendente)

Mérito julgado em **2026-09-15**; tese **aguardando publicação do acórdão** nos dados abertos do STJ em 2026-10-09. Até lá, a referência é o **EAREsp 676.608/RS** (Corte Especial, 2020) · Conferir: a devolução em dobro independe de má-fé e cabe quando a cobrança indevida contraria a boa-fé objetiva, com modulação para cobranças posteriores à publicação daquele acórdão.

Impacto: cobrança recorrente depois de cancelamento, renovação sem aviso e cobrança duplicada são o cenário típico. Corrigir no código e prever estorno automático.

### AREsp 2.130.619/SP (2ª Turma, 2023) · Conferir

Vazamento de dados pessoais **comuns** (não sensíveis) não gera dano moral presumido; o titular precisa provar o dano. Não reduz o dever de segurança (LGPD art. 46) nem as sanções administrativas.

### REsp 1.758.799/MG (3ª Turma, 2019) · Conferir

Disponibilizar ou comercializar dados pessoais de consumidor em banco de dados sem comunicação prévia (CDC art. 43, § 2º) gera dano moral presumido.

Impacto: venda ou compartilhamento de base, enriquecimento de leads, "data partners" sem aviso.

### REsp 1.495.920/DF (3ª Turma, 2018) · Conferir

Contrato eletrônico com assinatura digital certificada pode ser título executivo mesmo sem duas testemunhas.

Impacto: SaaS B2B que cobra contrato em atraso. Aceite por clique comum não tem a mesma força; guardar evidências do aceite (versão do termo, data, IP, usuário).

## Temas sem precedente consolidado

Use só a lei e declare a ausência de precedente:

- Arrependimento (CDC art. 49) para conteúdo digital já baixado ou consumido: divergência. Recomendação prudente: informar antes da compra e não negar sem fundamento.
- Responsabilidade de marketplace por produto de vendedor terceiro: decisões variam pela participação do marketplace na transação (pagamento, entrega, anúncio). Ver também o item da tese dos Temas 987/533 sobre marketplaces.
- Dark patterns: sem lei específica. Base no CDC arts. 6º, III e IV, 37 e 39.
- IA generativa e responsabilidade: sem lei (PL 2.338/2023 em tramitação). Base no CDC, LGPD art. 20 e Temas 987/533 item 4 (chatbots).

## Como manter esta lista

Abra uma issue com o template "Precedente novo ou desatualizado". Todo item novo entra com link para a fonte oficial e data da conferência.
