if not command -v emerge 2&> /dev/null
    return
end

# equery
alias eq='command equery'
alias eqb='command equery belongs'
alias eqc='command equery changes'
alias eqk='command equery check'
alias eqd='command equery depends'
alias eqg='command equery depgraph'
alias eqf='command equery files'
alias eqa='command equery has'
alias eqh='command equery hasuse'
alias eqy='command equery keywords'
alias eql='command equery list'
alias eqm='command equery meta'
alias eqs='command equery size'
alias equ='command equery uses'
alias eqw='command equery which'

# eix
alias eixi='command eix --installed'
alias eixo='command eix --installed-from-overlay'
