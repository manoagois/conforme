#!/usr/bin/env bash
# Mapeia pontos quentes de conformidade num projeto. Só lê arquivos; não altera nada.
# Uso: scan.sh [pasta]   (padrão: pasta atual)
# Saída: TSV "categoria<TAB>arquivo:linha<TAB>trecho", seguido de um resumo por categoria.
# Os achados são candidatos para leitura humana ou do agente, não conclusões.
set -euo pipefail

ROOT="${1:-.}"
[ -d "$ROOT" ] || { echo "pasta não encontrada: $ROOT" >&2; exit 2; }

EXCLUDES=(--exclude-dir=node_modules --exclude-dir=.git --exclude-dir=dist --exclude-dir=build
  --exclude-dir=.next --exclude-dir=.nuxt --exclude-dir=out --exclude-dir=coverage --exclude-dir=vendor
  --exclude-dir=.venv --exclude-dir=venv --exclude-dir=__pycache__ --exclude-dir=.conforme
  --exclude=*.min.js --exclude=*.map --exclude=*.lock --exclude=package-lock.json --exclude=pnpm-lock.yaml)
INCLUDES=(--include=*.ts --include=*.tsx --include=*.js --include=*.jsx --include=*.mjs --include=*.cjs
  --include=*.vue --include=*.svelte --include=*.py --include=*.rb --include=*.php --include=*.go
  --include=*.java --include=*.kt --include=*.swift --include=*.dart --include=*.cs --include=*.sql
  --include=*.prisma --include=*.html --include=*.liquid --include=*.env.example)

# categoria|regex (ERE, sem diferenciar maiúsculas)
RULES=(
  'pii-em-log|(console\.(log|info|warn|error|debug)|logger\.[a-z]+|print|log\.(info|debug|error))\(.*(email|cpf|cnpj|senha|password|token|card|cartao|phone|telefone|address|endereco)'
  'segredo-no-codigo|(sk_live_[0-9a-z]{8,}|sk-ant-[0-9a-z_-]{8,}|sk-proj-[0-9a-z_-]{8,}|AKIA[0-9A-Z]{16}|-----BEGIN (RSA |EC )?PRIVATE KEY)'
  'dado-de-cartao|(card_?number|numero_?cartao|cvv|cvc|security_?code)'
  'documento-pessoal|(\bcpf\b|\brg\b|\bcnh\b|passaporte|passport|date_?of_?birth|data_?nascimento|birth_?date)'
  'rastreamento|(gtag\(|fbq\(|googletagmanager|hotjar|clarity\.ms|ttq\.|posthog|mixpanel|segment\.(com|io)|amplitude)'
  'preco-e-parcela|(parcela|installment|sem juros|interest_?free|preco_?avista|price_?cash|x de r\$|de: r\$|compare_?at_?price|old_?price|preco_?de)'
  'checkout-e-carrinho|(checkout|carrinho|\bcart\b|add_?to_?cart|place_?order|finalizar_?compra)'
  'frete-e-entrega|(frete|shipping|delivery_?(date|time|estimate)|prazo_?entrega)'
  'assinatura-e-renovacao|(subscription|assinatura|renew|renovac|recurring|recorrente|trial|auto_?renew)'
  'cancelamento|(cancel(ar|amento|_?subscription)|unsubscribe|downgrade)'
  'estorno-e-arrependimento|(refund|estorno|chargeback|arrependimento|devolu[cç])'
  'exclusao-de-conta|(delete_?(account|user|me)|excluir_?conta|account_?deletion|right_?to_?erasure)'
  'consentimento|(consent|consentimento|opt_?in|opt_?out|cookie_?banner|lgpd|privacy)'
  'verificacao-de-idade|(age_?gate|idade_?minima|min(imum)?_?age|is_?adult|maior_?de_?idade|under_?18|parental)'
  'conteudo-de-usuario|(report_?(content|post|user)|denuncia|moderat|takedown|user_?generated|comment_?create)'
  'ia-e-llm|(openai|anthropic|@ai-sdk|langchain|generativeai|gemini|ollama|chat\.completions|messages\.create)'
  'decisao-automatizada|(score|scoring|risk_?model|auto_?(approve|reject|ban)|fraud_?score)'
  'termos-e-aceite|(terms_?(of_?service|accepted|version)|termos_?de_?uso|accept_?terms|aceite)'
  'acessibilidade|(outline:[[:space:]]*none|tabIndex=\{?-1|<img[^>]*>)'
)

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

for rule in "${RULES[@]}"; do
  categoria="${rule%%|*}"
  re="${rule#*|}"
  grep -rnIiE "${EXCLUDES[@]}" "${INCLUDES[@]}" -e "$re" "$ROOT" 2>/dev/null \
    | { if [ "$categoria" = "acessibilidade" ]; then grep -viE 'alt=' || true; else cat; fi; } \
    | cut -c1-240 \
    | awk -v c="$categoria" '{
        i = index($0, ":"); arq = substr($0, 1, i - 1); r = substr($0, i + 1)
        j = index(r, ":"); lin = substr(r, 1, j - 1); txt = substr(r, j + 1)
        gsub(/^[ \t]+/, "", txt); print c "\t" arq ":" lin "\t" txt
      }' >> "$TMP" || true
done

if [ ! -s "$TMP" ]; then
  echo "nenhum ponto quente encontrado em $ROOT"
  exit 0
fi

cat "$TMP"
echo
echo "# resumo"
cut -f1 "$TMP" | sort | uniq -c | sort -rn
