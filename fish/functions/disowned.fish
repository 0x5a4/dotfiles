function disowned -d "Start a job and immediatly disown it" -w exec
   $argv &; disown
end
