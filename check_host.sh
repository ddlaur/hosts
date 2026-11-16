#!/bin/bash

verify-IP() {
	if ! nslookup "$1" 2>/dev/null | tail -n +4 | grep -Fw "$2"; then
		echo "Bogus IP for $1 in $HOME/etc/hosts !"
		return 1
	fi
	return 0
}

while read ip name; do
	if echo "$ip" | grep -q "^[0-9]" && [ "$name" != "localhost" ]; then
		verify-IP "$name" "$ip"
	fi
done < "$HOME/etc/hosts"
