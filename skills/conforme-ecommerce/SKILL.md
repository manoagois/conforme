---
name: conforme-ecommerce
description: Revisão jurídica do código de lojas virtuais e marketplaces brasileiros. Confere preço à vista junto ao produto, parcelamento e desconto por meio de pagamento, identificação do fornecedor, resumo do pedido, arrependimento de 7 dias pelo mesmo canal com estorno, frete e prazo, oferta vinculante, avaliações, cupons e carrinho, dados de cartão, Pix e antifraude, com base no CDC, Decreto 7.962/2013, Lei 10.962/2004 e jurisprudência do STJ. Use para "revisa minha loja", "checkout está ok com a lei?", "Shopify/WooCommerce/VTEX/Nuvemshop/Next commerce", "política de troca", "direito de arrependimento".
---

# Conforme: e-commerce e marketplace

Normas em `../conforme/references/legislacao.md`. Precedentes em `../conforme/references/jurisprudencia.md`. Formato de achado em `../conforme/references/formato-achado.md`.

## Onde procurar

Página de produto e listagem, carrinho, checkout, confirmação do pedido, e-mails transacionais, minha conta e pedidos, rodapé e página "sobre", política de troca, integrações de pagamento, frete e antifraude, painel do vendedor (marketplace).

## Checklist

### Preço e oferta
- [ ] **Preço à vista** visível junto à imagem ou descrição, fonte de pelo menos 12 (Lei 10.962 art. 2º, III). Exibir só "12x de R$ X" sem o à vista é achado ALTA.
- [ ] Desconto por Pix, boleto ou prazo informado em local visível (Lei 10.962 art. 5º-A).
- [ ] "De/por" com preço anterior real. Preço de referência inventado é publicidade enganosa (CDC art. 37).
- [ ] Preço exibido é o cobrado. Divergência entre listagem, carrinho e checkout viola oferta (CDC arts. 30 e 35). Procure cálculos de preço duplicados no front e no back.
- [ ] Contadores de estoque ou urgência ligados a dado real. Timer que reinicia a cada visita é enganoso (CDC art. 37).
- [ ] Frete, taxas e seguros mostrados **antes** da finalização (Decreto 7.962 art. 2º, IV).

### Identificação e contrato
- [ ] Nome empresarial, CNPJ, endereço físico e eletrônico em local de destaque (Decreto 7.962 art. 2º, I e II). Em marketplace: identificar também o vendedor.
- [ ] Resumo do pedido antes de pagar, com chance de corrigir erros (Decreto 7.962 art. 4º, I e II).
- [ ] Confirmação imediata do pedido por e-mail ou tela (art. 4º, III), com dados do fornecedor (CDC art. 42-A em documentos de cobrança).
- [ ] Termos e política de troca acessíveis antes da compra; cláusula que limita direito em destaque (CDC art. 54, § 4º).
- [ ] Produto, garantia estendida ou seguro **não pré-marcados** (CDC art. 39, I e III; por analogia, STJ Súmula 532).

### Arrependimento e troca
- [ ] Direito de arrependimento de **7 dias** do recebimento informado de forma clara (CDC art. 49; Decreto 7.962 art. 5º).
- [ ] Exercível **pelo mesmo canal** da compra: botão em "meus pedidos", não só "ligue para o SAC" (art. 5º, § 1º).
- [ ] Ao registrar, comunicar de imediato o meio de pagamento para estorno (art. 5º, § 3º) e confirmar o recebimento do pedido (art. 5º, § 4º).
- [ ] Arrependimento cancela junto garantia estendida e seguro vendidos com o produto, sem ônus (Decreto 7.962 art. 5º, § 2º).
- [ ] Devolução integral, incluindo frete, monetariamente atualizada (CDC art. 49, p.u.). Código que desconta frete de ida no estorno é achado ALTA.
- [ ] Política de troca por vício não encurta os prazos legais de 30/90 dias (CDC art. 26) nem o prazo de 30 dias para sanar (art. 18).

### Pagamento e dados
- [ ] Número de cartão e CVV **nunca** salvos ou logados pela aplicação. Use tokenização do gateway (PCI DSS; LGPD art. 46). CVV salvo é CRÍTICA.
- [ ] Antifraude que bloqueia ou cancela pedido: critério explicável ao cliente quando pedido (LGPD art. 20; STJ Tema 710 por analogia).
- [ ] Cancelamento por fraude não deixa o cliente sem estorno nem informação.
- [ ] Pix: conferir valor e destinatário no back-end, não confiar no valor vindo do front.

### Marketplace
- [ ] Vendedor identificado na página do produto e no pedido.
- [ ] Canal de reclamação e mediação com histórico.
- [ ] Anúncios patrocinados identificados como tal. A tese dos Temas 987/533 do STF presume responsabilidade por conteúdo ilícito em anúncio pago.
- [ ] Responsabilidade por produto de terceiro: sem precedente consolidado. Registre como risco, não como certeza.

### Avaliações
- [ ] Avaliação negativa não é ocultada por regra de código sem critério declarado (CDC art. 37, enganosa por omissão).
- [ ] Avaliação incentivada ou de compra não verificada sinalizada.

### Acessibilidade
- [ ] Imagens de produto com `alt`, botões navegáveis por teclado, contraste suficiente no preço e no CTA (LBI art. 63).

## Correções frequentes

- Componente de preço único que recebe `priceCash` e `installments` e sempre renderiza o à vista primeiro, com fonte mínima.
- Rota `POST /orders/:id/withdrawal` com prazo calculado a partir de `deliveredAt`, que chama o estorno do gateway e envia confirmação.
- Fonte única do total (back-end) usada por listagem, carrinho e checkout.
- Checkbox de add-on iniciando desmarcado, com teste.

Aplique com `conforme-corrigir`.
