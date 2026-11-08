#!/usr/bin/env bats

@test "dot prints usage without a command" {
	run dot
	[[ $output =~ "Usage" ]]
}

@test "json formats JSON from stdin" {
	ACTUAL=$(echo '{"x":1}' | json)
	EXPECTED=$'{ "x": 1 }'
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "is-executable exits 0 for an available command" {
	run is-executable ls
	[ "$status" -eq 0 ]
}

@test "is-executable exits 1 for a missing command" {
	run is-executable nonexistent
	[ "$status" -eq 1 ]
}

@test "is-supported exits 0 when given a command and a fallback value" {
	run is-supported ls -a
	[ "$status" -eq 0 ]
}

@test "is-supported exits 1 for a failing command" {
	run is-supported "ls --nonexistent"
	[ "$status" -eq 1 ]
}

@test "sort-json-keys requires exactly one file" {
	FILE="$BATS_TEST_TMPDIR/one.json"
	echo '{"b":1,"a":2}' > "$FILE"
	run sort-json-keys "$FILE" "$FILE"
	[ "$status" -eq 1 ]
	[ "$(cat "$FILE")" = '{"b":1,"a":2}' ]
}

@test "sort-json-keys leaves invalid JSON unchanged" {
	FILE="$BATS_TEST_TMPDIR/invalid.json"
	echo '{"b":1,"a":2,}' > "$FILE"
	run sort-json-keys "$FILE"
	[ "$status" -ne 0 ]
	[ "$(cat "$FILE")" = '{"b":1,"a":2,}' ]
}
