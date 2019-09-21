#!/usr/bin/env bash
# pass-stdout - Password Store Extension (https://www.passwordstore.org/)
# Copyright (c) 2019 Michał Krzysztof Feiler
# License: MIT

VERSION="0.2.2"

opts="$($GETOPT -o n:k: -n "$PROGRAM" -- "$@")"
err=$?
eval set -- "$opts"
n=1 k=""
while true; do case $1 in
	-n) shift; n="$n"; shift ;;
	-k) shift; k="$k"; shift ;;
	--) shift; break ;;
esac done

[[ $err -ne 0 || $# -ne 1 ]] && 
	die "Usage: $PROGRAM $COMMAND [-n N] [-k KEYWORD] pass-name"

path="${1%/}"
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
