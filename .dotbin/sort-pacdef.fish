for f in (dotgit diff --cached --name-only --diff-filter=ACMR ~/.config/pacdef/groups | sed 's| |\\ |g')
    sort $f -o $f
    sed -i '/./,$!d' $f
    dotgit add $f
end