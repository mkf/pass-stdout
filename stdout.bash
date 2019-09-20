#!/usr/bin/env bash
VERSION="0.2.1"

#local opts
opts="$($GETOPT -o n:k: -n "$PROGRAM" -- "$@")"
#local
err=$?
eval set -- "$opts"
#local 
n=1
k=""
while true; do case $1 in
	-n) shift; n="$n"; shift ;;
	-k) shift; k="$k"; shift ;;
	--) shift; break ;;
esac done

[[ $err -ne 0 || $# -ne 1 ]] && 
	die "Usage: $PROGRAM $COMMAND [-n N] [-k KEYWORD] pass-name"

#local
path="${1%/}"
#local
passfile="$PREFIX/$path.gpg"
check_sneaky_paths "$path"
[[ ! -f $passfile ]] && 
	die "$path: passfile not found"

$GPG -d "${GPG_OPTS[@]}" "$passfile" |
	if [[ -z $k ]]; then cat
	else sed '/^(?!'"$k"':).*$/d' |
		sed 's/^'"$k"':[^[:graph:]]*(.*?)$/\1/'; fi |
	sed -n "${n}p"
exit 0
