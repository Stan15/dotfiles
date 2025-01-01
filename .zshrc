export PATH=/opt/homebrew/bin:$PATH

# Aliases
alias python=/usr/local/bin/python3
alias nvimdeleteswp='find ~/.local/state/nvim/ -type f -name "*.sw[klmnop]" -delete'


# bun completions
[ -s "/Users/stan/.bun/_bun" ] && source "/Users/stan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "/Users/stan/.deno/env"

source ~/.shared_shellrc
