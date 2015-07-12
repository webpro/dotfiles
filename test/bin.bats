#!/usr/bin/env bats

@test "dotfiles" {
	run dotfiles
	[[ $output =~ "Usage" ]]
}

@test "json" {
	ACTUAL=$(echo '{"x":1}' | \json)
	EXPECTED=$'{\n    \"x\": 1\n}'
	[ "$ACTUAL" = "$EXPECTED" ]
}
