<!-- Modelo adaptado de goul4rt/lgpd-skills (MIT, Copyright (c) 2026 goul4rt), https://github.com/goul4rt/lgpd-skills. Ver THIRD_PARTY_NOTICES.md. -->
<!-- Campos entre chaves {...} são preenchidos com fato do código (.conforme/fatos.md) ou resposta do usuário. Campo sem fonte fica como [PREENCHER: ...]. Nunca invente. -->

# Teste de Legítimo Interesse (LIA)

Para uso quando a base legal escolhida é Art. 7º, IX (legítimo interesse). Sem LIA documentado, a base é frágil em fiscalização da ANPD.

## Identificação

- **Atividade**: {nome}
- **Controlador**: {nome jurídico}
- **Data**: {data}
- **Versão**: {N}
- **Próxima revisão**: {data}

## 1. Teste de finalidade

- **Qual o interesse legítimo perseguido?**
- **É um interesse lícito, específico e real (não hipotético)?**
- **Quem se beneficia?** (controlador, terceiro, titular, sociedade)
- **Sem o tratamento, qual o prejuízo concreto?**

## 2. Teste de necessidade

- **O tratamento é estritamente necessário para a finalidade?** (Art. 10, II)
- **Há forma menos invasiva de atingir a mesma finalidade?**
- **Os dados coletados são os mínimos para a finalidade?** (Art. 6º, III, necessidade)

## 3. Teste de balanceamento

| Fator | Avaliação |
|---|---|
| Expectativa razoável do titular | {alta/média/baixa}, justifique |
| Impacto potencial sobre direitos do titular | {leve/moderado/severo} |
| Categoria do dado | {comum / quasi-sensível / contextual} |
| Vulnerabilidade do titular | {nenhuma / criança / idoso / hipossuficiente} |
| Forma de coleta | {transparente / inferida / observada} |
| Salvaguardas existentes | {minimização, criptografia, opt-out, etc.} |

**Conclusão do balanceamento**: o interesse do controlador {prevalece / não prevalece} sobre os direitos e liberdades do titular porque {justificativa}.

## 4. Salvaguardas adotadas

- [ ] Transparência ativa (informar na política de privacidade)
- [ ] Mecanismo de oposição fácil (opt-out em 1 clique)
- [ ] Minimização de dados
- [ ] Limitação de retenção
- [ ] Acesso restrito (need-to-know)
- [ ] Criptografia
- [ ] Pseudonimização
- [ ] Outras: {especificar}

## 5. RIPD necessário?

A ANPD pode exigir RIPD para legítimo interesse (Art. 10, § 3º). Avaliar:
- Tratamento envolve perfilamento, decisão automatizada, vigilância, dados sensíveis, menores?
- Larga escala (número significativo de titulares, volume, duração e extensão geográfica; Res. CD/ANPD 15/2024, art. 5º, § 2º, usado aqui como referência)?

Se sim → produzir RIPD com o modelo `relatorio-de-impacto.md`.

## 6. Decisão

- [ ] Aprovo o uso de legítimo interesse para esta atividade
- [ ] Rejeito, recomendo migrar para {outra base}

**Responsável pela decisão**: {Encarregado / Jurídico}
**Data**: {data}
