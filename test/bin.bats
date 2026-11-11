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

@test "podman-docker forwards to podman without buildx-only flags" {
	printf '#!/usr/bin/env bash\necho "$@"\n' > "$BATS_TEST_TMPDIR/podman"
	chmod +x "$BATS_TEST_TMPDIR/podman"
	PATH="$BATS_TEST_TMPDIR:$PATH" run podman-docker build --load -t img --platform linux/amd64 --provenance=false -f - .
	[ "$status" -eq 0 ]
	[ "$output" = "build -t img --platform linux/amd64 -f - ." ]
}

@test "podman-docker reports the digest of a pushed image in the registry" {
	printf '#!/usr/bin/env bash\n[ "$1" = push ] && echo sha256:remote > "$3"\necho "podman $*"\n' > "$BATS_TEST_TMPDIR/podman"
	chmod +x "$BATS_TEST_TMPDIR/podman"
	export PATH="$BATS_TEST_TMPDIR:$PATH" TMPDIR="$BATS_TEST_TMPDIR"
	podman-docker push registry.example/acct/img:v1
	run podman-docker image inspect registry.example/acct/img:v1 --format '{{ json .RepoDigests }}'
	[ "$output" = '["registry.example/acct/img@sha256:remote"]' ]
	run podman-docker image inspect registry.example/acct/img:v2 --format '{{ json .RepoDigests }}'
	[ "$output" = "podman image inspect registry.example/acct/img:v2 --format {{ json .RepoDigests }}" ]
}
