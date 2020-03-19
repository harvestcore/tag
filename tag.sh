#!/bin/bash
echo "####################"
echo "## Tag generation ##"
echo "####################"

tag=$(git log --pretty=oneline | head -n1 | grep -o -P "(v[0-9].[0-9].[0-9])")
echo "Tag found: $tag"
echo "####################"

if [ "$tag" != "" ]
then
  commit=$(git rev-parse HEAD)
  remote=$(git config --get remote.origin.url)
  repo=$(basename "$remote" .git)

  echo "########################################################"
  echo "Commit: $commit"
  echo "Remote: $remote"
  echo "Repo: $repo"
  echo "########################################################"

  # curl -XPOST -H 'Authorization: token '"$GITHUB_KEY" -H "Content-type: application/json" \
  # -d '{ "ref": "refs/heads/'"$tag"'", "sha": "'"$commit"'"}' 'https://api.github.com/repos/harvestcore/'"$repo"'/git/refs'

  # echo "########################################################"
  curl -XPOST -H 'Authorization: token '"$GITHUB_KEY" -H "Content-type: application/json" \
  -d '{ "tag_name": '"$tag"' }' 'https://api.github.com/repos/harvestcore/'"$repo"'/releases'
  echo "########################################################"
fi
