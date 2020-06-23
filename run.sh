#!/bin/sh
set -e

INPUT_CONTENTS=${INPUT_CONTENTS:-contents/*.txt}
INPUT_DICT=${INPUT_DICT:-shupin.dict.yaml}
INPUT_BRANCH=${INPUT_BRANCH:-master}

[ -z "${INPUT_TOKEN}" ] && {
  echo 'Missing input "token: ${{ secrets.GITHUB_TOKEN }}".';
  exit 1;
};

echo "Basic info"
echo "  Contents"
ls -lh ${INPUT_CONTENTS}
# echo "  Dict"
# ls -lh ${INPUT_DICT}
echo "  GitHub Actor: ${GITHUB_ACTOR}"
echo "  Repo: ${GITHUB_REPOSITORY}"

echo "Perform merging contents"
cat ${INPUT_CONTENTS} > ${INPUT_DICT}

echo "Test modified"
if [ "$(git diff ${INPUT_DICT})" != "" ]; then
  echo "Commit files"
  git config --local user.email "action@github.com"
  git config --local user.name "GitHub Action"
  git add ${INPUT_DICT}
  git commit -m "Merging contents"

  echo "Push changes"
  git push "https://${INPUT_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" HEAD:${INPUT_BRANCH}
fi
