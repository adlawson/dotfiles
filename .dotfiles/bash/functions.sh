# Convenience for working in dotfiles (i.e. `dotfiles git push origin master`)
dotfiles () {
    (cd ~/Projects/adlawson/dotfiles && "$@")
}
