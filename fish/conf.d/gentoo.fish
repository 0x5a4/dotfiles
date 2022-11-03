if not command -v emerge 2&> /dev/null
    return
end

# equery
alias eq='command equery $argv'
alias eqb='command equery belongs $argv'
alias eqc='command equery changes $argv'
alias eqk='command equery check $argv'
alias eqd='command equery depends $argv'
alias eqg='command equery depgraph $argv'
alias eqf='command equery files $argv'
alias eqa='command equery has $argv'
alias eqh='command equery hasuse $argv'
alias eqy='command equery keywords $argv'
alias eql='command equery list $argv'
alias eqm='command equery meta $argv'
alias eqs='command equery size $argv'
alias equ='command equery uses $argv'
alias eqw='command equery which $argv'
