function disowned -d "Start a job and immediatly disown it" -w exec
    exec $argv &; disown
end
