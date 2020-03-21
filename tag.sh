#!/bin/bash
echo "####################"
echo "## Tag generation ##"
echo "####################"

vtag=$(git log --pretty=oneline | head -n1 | grep -o -P "(v[0-9].[0-9].[0-9])")
echo "Tag: $vtag"
echo "####################"

if [ "$vtag" != "" ]
then
  tag=${vtag:1:5}
  export TAG="$tag"
  commit=$(git rev-parse HEAD)
  remote=$(git config --get remote.origin.url)
  repo=$(basename "$remote" .git)

  echo "########################################################"
  echo "Commit: $commit"
  echo "Remote: $remote"
  echo "Repo: $repo"
  echo "########################################################"

  curl -XPOST -H 'Authorization: token '"$GITHUB_KEY" -H "Content-type: application/json" \
  -d '{ "tag_name": "'"$vtag"'" }' 'https://api.github.com/repos/'"$GITHUB_USER"'/'"$repo"'/releases'

  echo "########################################################"
fi
