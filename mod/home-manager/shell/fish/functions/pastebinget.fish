if not set -q argv[1] || not set -q argv[2]
    echo "usage: pastebinget [PASTEBINCODE] <OUTPUTNAME>"
    return 1
end

wget https://pastebin.com/raw/$argv[1] -O $argv[2]
