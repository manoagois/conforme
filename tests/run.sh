#!/usr/bin/env bash
# Testes do conforme: scanner encontra os pontos plantados na fixture e as skills têm frontmatter válido.
set -euo pipefail
cd "$(dirname "$0")/.."
fail=0

out="$(bash skills/conforme/scripts/scan.sh tests/fixtures/loja)"
for cat in pii-em-log segredo-no-codigo dado-de-cartao documento-pessoal rastreamento preco-e-parcela \
           checkout-e-carrinho assinatura-e-renovacao cancelamento ia-e-llm acessibilidade; do
  if ! grep -q "^$cat	" <<<"$out"; then echo "FALHOU: scanner não achou $cat"; fail=1; fi
done
grep -q "https://\|sk_live_" <<<"$out" || { echo "FALHOU: trecho perdeu conteúdo"; fail=1; }

empty="$(mktemp -d)"; trap 'rm -rf "$empty"' EXIT
grep -q "nenhum ponto quente" <<<"$(bash skills/conforme/scripts/scan.sh "$empty")" || { echo "FALHOU: pasta vazia"; fail=1; }

for f in skills/*/SKILL.md; do
  dir="$(basename "$(dirname "$f")")"
  name="$(awk '/^---$/{n++; next} n==1 && /^name:/{sub(/^name:[ ]*/,""); print; exit}' "$f")"
  desc="$(awk '/^---$/{n++; next} n==1 && /^description:/{print; exit}' "$f")"
  [ "$name" = "$dir" ] || { echo "FALHOU: $f name '$name' difere da pasta"; fail=1; }
  [ -n "$desc" ] || { echo "FALHOU: $f sem description"; fail=1; }
  [ "${#desc}" -le 1100 ] || { echo "FALHOU: $f description longa demais (${#desc})"; fail=1; }
done

# links relativos entre skills apontam para arquivos que existem
while IFS= read -r line; do
  src="${line%%:*}"; link="${line#*:}"
  [ -e "$(dirname "$src")/$link" ] || { echo "FALHOU: link quebrado $src -> $link"; fail=1; }
done < <(grep -oE '\]\((\.\./)?[a-z0-9/_.-]+\.(md|sh)\)' -r skills | sed -E 's/\]\(|\)//g')

for j in .claude-plugin/plugin.json .claude-plugin/marketplace.json .codex-plugin/plugin.json .cursor-plugin/plugin.json gemini-extension.json; do
  python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$j" || { echo "FALHOU: JSON inválido $j"; fail=1; }
done

versions="$(python3 -c '
import json
fs=[".claude-plugin/plugin.json",".codex-plugin/plugin.json",".cursor-plugin/plugin.json","gemini-extension.json"]
v={json.load(open(f))["version"] for f in fs}
v.add(json.load(open(".claude-plugin/marketplace.json"))["plugins"][0]["version"])
print(len(v))')"
[ "$versions" = 1 ] || { echo "FALHOU: manifestos com versões diferentes"; fail=1; }

[ "$fail" = 0 ] && echo "ok: todos os testes passaram"
exit "$fail"
