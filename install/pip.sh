if ! is-executable pip; then
  echo "Skipped: pip packages (missing: pip)"
  return
fi

pip install git-sweep
