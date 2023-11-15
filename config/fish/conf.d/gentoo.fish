if command -v equery 2&> /dev/null
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
end

if command -v eix 2&> /dev/null
    alias eixi='command eix --installed'
    alias eixo='command eix --installed-from-overlay'
end
