#!/bin/sh

new_tag=$1

previous_tag=$(git tag --sort=-creatordate | sed -n 2p)
commit_summary="$(git log --oneline --pretty=tformat:"%h %s" $previous_tag..$new_tag)"
commit_summary="${commit_summary//$'\n'/'%0A'}"
echo ::set-output name=summary::$commit_summary