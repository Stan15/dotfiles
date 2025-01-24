export PATH=/opt/homebrew/bin:$PATH

# bun completions
[ -s "/Users/stan/.bun/_bun" ] && source "/Users/stan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "/Users/stan/.deno/env"

source ~/.shared_shellrc
