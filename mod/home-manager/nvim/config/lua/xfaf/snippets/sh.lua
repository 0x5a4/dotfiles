return {
    s(
        "strict",
        fmt([[
            set -euo pipefail
            IFS=$'\n\t'
        ]], {})
    ),
}
