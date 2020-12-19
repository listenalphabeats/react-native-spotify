#!/bin/sh

MODULES=`sed -n -e '/path/,/url/p' .gitmodules | sed 'N;s/\\n/\\$$$/'`
echo "$MODULES" | while IFS= read -r line; do
  if [[ $line =~ (.*)\$\$\$(.*) ]] ; then
    path=$(echo ${BASH_REMATCH[1]} | sed 's/.*= //')
    url=$(echo ${BASH_REMATCH[2]} | sed 's/.*= //')
    if [ -d $path ] ; then
      echo "Updating submodule"
      start=$PWD;
      cd $path;
      git pull;
      cd $PWD;
    else
      echo "Cloning submodule $url to $path"
      git clone $url $path;
    fi
  fi
done
