#!/usr/bin/env bash
# Claude Code status line; Bash 5+. Only jq forks on the common path.
IFS=$'\x1f' read -r model effort cwd ctx < <(jq -r '[
  (.model.display_name // ""), (.effort.level // ""),
  (.workspace.current_dir // .cwd // ""),
  ([(.context_window.used_percentage | numbers | "ctx \(round)%"),
    (.context_window.context_window_size | numbers
      | (if . % 1000000 == 0 then "\(. / 1000000)M" else "\(. / 1000 | floor)k" end) + " window")
  ] | join(" · "))
] | join("\u001f")' 2>/dev/null) || exit 0

out=
append() { [[ $1 ]] && out+="${out:+ · }$1"; }
append "$model${effort:+ ($effort)}"
[[ $cwd/ == "$HOME"/* ]] && append "~${cwd#"$HOME"}" || append "$cwd"

cd -- "${cwd:-/}" 2>/dev/null || cd /
until [[ -e .git || $PWD == / ]]; do cd ..; done
if [[ -e .git ]]; then
  gitdir=.git
  [[ -f .git ]] && read -r _ gitdir < .git # Worktree or submodule
  read -r head 2>/dev/null < "$gitdir/HEAD"
  # Reftable keeps the real HEAD elsewhere.
  [[ $head == *.invalid ]] && head=$(git symbolic-ref -q HEAD || git rev-parse HEAD) 2>/dev/null
  branch=${head#ref: } branch=${branch#refs/heads/}
  if [[ $branch == "$head" ]]; then
    append "${head:0:7}"
  else
    append "$branch"
    cache=$gitdir/statusline-pr-${branch//\//%}
    updated= pr=
    read -r updated pr 2>/dev/null < "$cache"
    if ! [ "$updated" -gt "$((EPOCHSECONDS - 300))" ] 2>/dev/null; then
      # Reserve the next refresh and keep the old PR unless gh gives a real answer.
      printf '%s %s\n' "$EPOCHSECONDS" "$pr" 2>/dev/null > "$cache"
      (
        num=$(gh pr view --json number -q .number 2>&1) || [[ $num == *'no pull requests found'* ]] || exit
        printf '%s %s\n' "$EPOCHSECONDS" "$num" > "$cache.$$" && mv -f "$cache.$$" "$cache"
      ) </dev/null >/dev/null 2>&1 &
    fi
    [[ $pr =~ ^[0-9]+$ ]] && append "PR #$pr"
  fi
fi

append "$ctx"
printf '%s\n' "$out"
