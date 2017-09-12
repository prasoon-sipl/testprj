#!/bin/bash
branches=()
eval "$(git for-each-ref --shell --format='branches+=(%(refname))' refs/heads/)"
for branch in "${branches[@]}"; do
    echo "$branch"
done
