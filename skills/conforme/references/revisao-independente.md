# Revisão independente de achados

Antes de entrar no relatório, cada achado passa por um revisor que **tenta provar que ele está errado**. Quem encontrou o problema não é quem confirma.

## Quem revisa

| Severidade | Revisor |
|---|---|
| CRÍTICA e ALTA | Um subagente novo por achado (ou por lote de até 5 achados do mesmo arquivo), sem acesso ao raciocínio de quem encontrou. Pode usar um modelo mais leve. |
| MÉDIA e BAIXA | O próprio agente, numa segunda passada que relê o arquivo do zero, seguindo o roteiro abaixo. |

Se o agente não consegue criar subagentes, todos passam pela segunda passada e o relatório diz: "revisão sem agente independente".

## O que o revisor recebe

Só o achado, no formato de `formato-achado.md`, e o caminho do projeto. Não recebe a conversa, a saída do mapeador nem os outros achados. Instrução:

> Você é revisor. Tente derrubar este achado. Abra os arquivos, não confie na descrição. Responda com um veredito e a evidência.

## Roteiro do revisor

1. **O código existe?** Abra `arquivo:linha`. A linha diz o que o achado afirma? Se o arquivo mudou ou a linha não existe, rejeite.
2. **Já está resolvido em outro lugar?** Procure no projeto (`grep` pelo nome da função, do campo, do texto). Exemplos: preço à vista renderizado num componente filho; cancelamento feito por webhook do gateway; máscara de PII aplicada no logger global; RLS que cobre a tabela.
3. **O caminho é alcançável?** Código morto, rota desligada, fixture de teste ou exemplo não contam.
4. **A norma diz isso?** O artigo citado está em `legislacao.md` e sustenta a conclusão? O precedente está em `jurisprudencia.md` ou foi conferido (`verificacao.md`)? Citação fora da lista sem conferência derruba a citação; se só sobrar a lei, o achado continua, sem o precedente.
5. **Depende de fato fora do código?** Ex.: vende para consumidor final? há menores no público? o serviço é regulado? Se a conclusão depende disso, o veredito é "precisa validar".
6. **A severidade está certa?** Ajuste para cima ou para baixo pela tabela de `formato-achado.md`.

## Vereditos

| Veredito | Quando | Destino |
|---|---|---|
| **Confirmado** | O revisor não conseguiu derrubar; a evidência foi lida no arquivo | Seção "Achados" do relatório |
| **Precisa validar** | Depende de um fato que o código não mostra | Seção "Precisa validar", com a pergunta exata a fazer ao usuário, **sem severidade** |
| **Rejeitado** | Derrubado por um dos passos 1 a 4 | Fora do relatório principal; uma linha em `.conforme/rejeitados.md` com o motivo |

O revisor responde neste formato:

```markdown
**Veredito:** confirmado | precisa validar | rejeitado
**Evidência:** `arquivo:linha` lido e o que mostra (ou o que derrubou o achado)
**Pergunta (se precisa validar):** ...
**Ajustes:** severidade ou citação corrigida, se houver
```

## Regras

- Achado sem veredito não entra no relatório.
- O orquestrador não reverte um "rejeitado" por conta própria. Se discordar, manda para outro revisor novo e fica com o segundo veredito.
- Respostas do usuário a "precisa validar" transformam o item em confirmado ou rejeitado; registre a resposta no relatório.
- `conforme-corrigir` e `conforme-pr` só agem sobre achados **confirmados**.
