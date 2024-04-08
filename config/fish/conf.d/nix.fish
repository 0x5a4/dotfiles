set -l HM_SESSION_VARS_SYSTEM "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
set -l HM_SESSION_VARS_USER "~/.nix-profile/etc/profile.d/hm-session-vars.sh"

for path in $HM_SESSION_VARS_SYSTEM $HM_SESSION_VARS_USER
    if [ -f $path ]
        fenv source $path
    end
end
