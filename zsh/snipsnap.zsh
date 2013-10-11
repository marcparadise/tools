############################################################################
# ABOUT
# A really simple set of macros that captures and finds one-liner
# snippets of info. Useful if you live in the shell all day.
#
# INSTALLATION
# In your ~/.zshrc or ~/.bashrc:
#
# SNIPPETS_PATH=~/.snippets-data-file
# source ~/path/to/snippets.zsh
#
# USAGE
# snip "whatever you want to capture"
# snap regex search string to find in captured snippets.
############################################################################

function _snip {
   echo $@ >> $SNIPPETS_PATH
}

function _snap {
    grep -e $@ $SNIPPETS_PATH
}
alias snap=_snap
alias snip=_snip
