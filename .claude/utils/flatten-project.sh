#!/usr/bin/env bash
set -euo pipefail

# Flatten a project into a single AI-friendly file with minimal noise.
# Usage:
#   ./flatten-project.sh [OUTPUT_FILE] [ROOT_DIR] [--no-index] [--no-sha] [--no-header] [--expanded]
# Defaults: compact output, with index and without SHA (token friendly).

OUTPUT="${1:-project_flatten.txt}"
ROOT="${2:-.}"

# Flags (token-lean defaults)
SHOW_INDEX=1
SHOW_SHA=0
SHOW_HEADER=1
COMPACT=1

# Parse optional flags
for arg in "${@:3}"; do
  case "$arg" in
    --no-index)   SHOW_INDEX=0 ;;
    --no-sha)     SHOW_SHA=0 ;;
    --sha)        SHOW_SHA=1 ;;
    --no-header)  SHOW_HEADER=0 ;;
    --compact)    COMPACT=1 ;;
    --expanded)   COMPACT=0 ;;
  esac
done

# Excludes
EXCLUDES=(
  "$ROOT/.git" "$ROOT/.hg" "$ROOT/.svn" "$ROOT/docs" "$ROOT/package-lock.json"
  "$ROOT/node_modules" "$ROOT/.venv" "$ROOT/venv" "$ROOT/public"
  "$ROOT/.mypy_cache" "$ROOT/.pytest_cache" "$ROOT/.cache" "$ROOT/.gitignore"
  "$ROOT/.next" "$ROOT/.turbo" "$ROOT/.pnpm-store" "$ROOT/.env"
  "$ROOT/.claude" "$ROOT/.claude" "$ROOT/.vscode" "$ROOT/README.md"
  "$ROOT/dist" "$ROOT/build" "$ROOT/target" "$ROOT/out" "$ROOT/coverage"
)

# Include extensions
INCLUDE_EXTS=(js jsx ts tsx mjs cjs py go rs java kt scala swift c cc cpp cxx h hpp cs php rb sh bash zsh fish css scss less html htm vue svelte json yml yaml toml ini cfg conf env proto sql graphql gql md)

collapse_whitespace() {
  awk 'BEGIN{blank=0} {
    sub(/[ \t\r]+$/, "");
    if ($0 ~ /^[ \t]*$/) { blank++ } else { blank=0 }
    if (blank <= 1) print $0
  }'
}

has_cmd() { command -v "$1" >/dev/null 2>&1; }

fence_lang_from_ext() {
  local ext="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
  case "$ext" in
    js|mjs|cjs|jsx) echo "javascript" ;;
    ts|tsx)         echo "ts" ;;
    py)             echo "python" ;;
    sh|bash|zsh)    echo "bash" ;;
    go)             echo "go" ;;
    rs)             echo "rust" ;;
    java)           echo "java" ;;
    kt)             echo "kotlin" ;;
    cpp|cc|cxx)     echo "cpp" ;;
    c|h)            echo "c" ;;
    cs)             echo "csharp" ;;
    php)            echo "php" ;;
    rb)             echo "ruby" ;;
    css|scss|less)  echo "css" ;;
    html|htm|vue|svelte) echo "html" ;;
    json)           echo "json" ;;
    yml|yaml)       echo "yaml" ;;
    toml)           echo "toml" ;;
    ini|cfg|conf|env) echo "" ;;
    proto)          echo "proto" ;;
    sql)            echo "sql" ;;
    graphql|gql)    echo "graphql" ;;
    md)             echo "markdown" ;;
    *)              echo "" ;;
  esac
}

build_find() {
  local find_cmd=(find "$ROOT" -type f)
  for ex in "${EXCLUDES[@]}"; do
    find_cmd+=(-path "$ex" -prune -o)
  done
  local first=1
  find_cmd+=( \( )
  for ext in "${INCLUDE_EXTS[@]}"; do
    if [[ $first -eq 1 ]]; then
      find_cmd+=( -iname "*.${ext}" )
      first=0
    else
      find_cmd+=( -o -iname "*.${ext}" )
    fi
  done
  find_cmd+=( \) -print )
  printf '%q ' "${find_cmd[@]}"
}

py_strip_comments() {
  python3 - "$1" <<'PYCODE' || cat "$1"
import sys, io, tokenize
p = sys.argv[1]
with open(p, 'rb') as f:
    data = f.read()
try:
    tokens = [t for t in tokenize.tokenize(io.BytesIO(data).readline)
              if t.type not in (tokenize.COMMENT, tokenize.NL)]
    out = tokenize.untokenize(tokens)
    sys.stdout.write(out)
except Exception:
    sys.stdout.write(data.decode('utf-8', errors='ignore'))
PYCODE
}

js_ts_minify_or_cat() {
  local file="$1" ext="$2" loader="js"
  [[ "$ext" == "ts" || "$ext" == "tsx" ]] && loader="ts"
  if has_cmd esbuild; then
    esbuild --loader="$loader" --minify --log-level=error "$file" 2>/dev/null || cat "$file"
  else
    cat "$file"
  fi
}

sha256_of() {
  if [[ $SHOW_SHA -eq 0 ]]; then echo ""; return; fi
  if has_cmd sha256sum; then
    sha256sum "$1" | awk '{print $1}'
  elif has_cmd shasum; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    echo ""
  fi
}

# Collect files (portable, no mapfile)
FIND_CMD_STR=$(build_find)
IFS=$'\n' FILES=($(eval "$FIND_CMD_STR" | sort))
unset IFS

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "No matching files found under $ROOT" >&2
  exit 1
fi

: > "$OUTPUT"

print_header() {
  if [[ $SHOW_HEADER -eq 0 ]]; then return; fi
  if [[ $COMPACT -eq 1 ]]; then
    echo "#flatten root=$ROOT files=${#FILES[@]} gen=$(date -u +'%Y-%m-%dT%H:%M:%SZ')" >> "$OUTPUT"
  else
    {
      echo "# Flattened Project"
      echo "- root: $ROOT"
      echo "- generated: $(date -u +'%Y-%m-%dT%H:%M:%SZ')"
      echo "- files: ${#FILES[@]}"
      echo ""
    } >> "$OUTPUT"
  fi
}

print_index() {
  if [[ $SHOW_INDEX -eq 0 ]]; then return; fi
  if [[ $COMPACT -eq 1 ]]; then
    i=1
    for f in "${FILES[@]}"; do
      rel="${f#$ROOT/}"; size=$(wc -c <"$f" | tr -d ' '); sum=$(sha256_of "$f")
      if [[ $SHOW_SHA -eq 1 && -n "$sum" ]]; then
        echo "${i}:${rel}|${size}|${sum}" >> "$OUTPUT"
      else
        echo "${i}:${rel}|${size}" >> "$OUTPUT"
      fi
      ((i++))
    done
  else
    echo "## Index" >> "$OUTPUT"
    i=1
    for f in "${FILES[@]}"; do
      rel="${f#$ROOT/}"; size=$(wc -c <"$f" | tr -d ' '); sum=$(sha256_of "$f")
      if [[ $SHOW_SHA -eq 1 && -n "$sum" ]]; then
        echo "$i. \`$rel\` | ${size} | sha256:$sum" >> "$OUTPUT"
      else
        echo "$i. \`$rel\` | ${size}" >> "$OUTPUT"
      fi
      ((i++))
    done
    echo "" >> "$OUTPUT"
  fi
}

print_header
print_index

# Body
for f in "${FILES[@]}"; do
  rel="${f#$ROOT/}"
  ext="${f##*.}"
  lang="$(fence_lang_from_ext "$ext")"
  tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT

  case "$(echo "$ext" | tr '[:upper:]' '[:lower:]')" in
    js|mjs|cjs|jsx|ts|tsx) js_ts_minify_or_cat "$f" "$ext" | collapse_whitespace > "$tmp" ;;
    py)                    py_strip_comments "$f" | collapse_whitespace > "$tmp" ;;
    *)                     collapse_whitespace < "$f" > "$tmp" ;;
  esac

  size=$(wc -c <"$f" | tr -d ' ')
  sum=$(sha256_of "$f")

  # Compact, ASCII-only, no spaces.
  if [[ $SHOW_SHA -eq 1 && -n "$sum" ]]; then
    echo "@@${rel}|${size}|${sum}" >> "$OUTPUT"
  else
    echo "@@${rel}|${size}" >> "$OUTPUT"
  fi

  if [[ -n "$lang" ]]; then
    echo "\`\`\`$lang" >> "$OUTPUT"
    cat "$tmp" >> "$OUTPUT"
    echo "\`\`\`" >> "$OUTPUT"
  else
    echo '```' >> "$OUTPUT"
    cat "$tmp" >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
  fi

  rm -f "$tmp"; trap - EXIT
done

echo "Wrote $(realpath "$OUTPUT")"