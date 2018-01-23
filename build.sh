#!/bin/bash
git config --global credential.helper '!f() { sleep 1; echo "username=${GIT_USER}"; echo "password=${GIT_PASSWORD}"; }; f'
git config --global user.email "andreas.groll@gmail.com"
git config --global user.name "Andreas Groll"

if [[ $SOURCE ]]; then
  git clone ${SOURCE}
else
  echo "env variable SOURCE is empty!"
fi
find /build -name build.sh -print0 | head -n 1 | while read -d $'\0' fname; do
  echo "### executing ${fname}"
  cd $(dirname "${fname}")
  eval ${fname}
done
