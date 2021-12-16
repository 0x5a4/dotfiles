# try to use mold as the linker
if command -v mold &> /dev/null
  # cargo
  function cargo
    mold -run cargo $argv
  end
end

