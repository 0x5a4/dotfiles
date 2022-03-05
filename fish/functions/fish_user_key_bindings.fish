if status is-interactive
  function fish_user_key_bindings
    # auto complete
    bind -M insert \ck up-or-search
    bind -M insert \cj down-or-search
    bind -M insert \cl forward-char

    #doas exists
    if command -v doas &> /dev/null
      bind \es 'fish_commandline_prepend doas'
      bind -M insert \es 'fish_commandline_prepend doas'
      bind -M visual 'fish_commandline_prepend doas'
    end
  end
end
