############################################################################
# ABOUT
# This is a simple tool to help track your daily activities and report
# them back. It does some validation and sanity checks, but you can probably
# break it if you try...
#
# INSTALLATION
# In your ~/.zshrc:
#
# Path to keep journal files (stored as one text file per date):
# DIDLOG_JOURNAL_PATH=~/path/to/keep/didlog/journal/files
#
# When using 'didlog' without specifying a number of days
# how many days back should it display? (Defaults to 3 if not set)
# DIDLOG_DAYS_AGO=1
#
# source ~/path/to/didlog.zsh

# USAGE
# This will define four aliases:
# did "something that you did"
#   -> add an action to today's didlog journal file
#
# didlog [N]
#   -> show dated journal entries going back N days, including today.
#      Defaults to $DIDLOG_DAYS_AGO if N is not specified.
#      If $DIDLOG_DAYS_AGO is not set, it defaults to 3
#
# didago N "something that ou did N days ago"
#  -> Add an action to the journal of N days ago
#
# didedit [N]
#  -> Edit the journal file for N days ago (defaults to 0/today)
############################################################################

if [[ -z $DIDLOG_JOURNAL_PATH ]]; then
  DIDLOG_JOURNAL_PATH="~/.didlog"
fi

mkdir -p $DIDLOG_JOURNAL_PATH

function _didago {
   REL="$1 days ago"
   filename=`date --date=$REL +%Y-%m-%d`
   shift
   echo $@ >> "$DIDLOG_JOURNAL_PATH/$filename"
   echo "Added that to $filename"
}

function _did {
   filename=`date +%Y-%m-%d`
   echo $@ >> "$DIDLOG_JOURNAL_PATH/$filename"
   echo "Added that to $filename"
}

function _didedit {
    if [[ -z $1 ]]; then
      DAYS=0
    else
      DAYS=$@
    fi

    REL="$DAYS days ago"
    DATE=$(date --date=$REL +%Y-%m-%d)
    FULL=$DIDLOG_JOURNAL_PATH/$DATE
    if [[ -e $FULL ]]; then
      echo "Editing $FULL"
    else
      echo "Creating new journal for $DATE."
    fi
    $=EDITOR "$FULL"
}

function _didlog {
  if [[ -z $1 ]]; then
    if [[ -z $DIDLOG_DAYS_AGO ]]; then
      DIDLOG_DAYS_AGO=1
    fi
  else
    DIDLOG_DAYS_AGO=$1
  fi
  for ((i = $DIDLOG_DAYS_AGO; i >= 0; i--)) {
    REL="$i days ago"
    DATE=$(date --date=$REL +%Y-%m-%d)
    FULL=$DIDLOG_JOURNAL_PATH/$DATE
    if [[ -e $FULL ]]; then
      echo -en "\033[36m"
      echo $DATE
      echo -en "\033[1m\033[38m"
      sed 's/^/    /' $FULL
      echo -en "\033[0m"
    fi
  }
}

alias did=_did
alias didlog=_didlog
alias didedit=_didedit
alias didago=_didago
