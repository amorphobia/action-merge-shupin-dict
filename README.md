# GitHub Action for merging contents of Shupin dictionary

The action automatically merges dictionary contents after commits for [Papnas/shupin](https://github.com/Papnas/shupin).

## Usage

An actual [repository](https://github.com/amorphobia/test-merge-dict) can be found as a demo.

The [example workflow file](https://github.com/amorphobia/test-merge-dict/blob/master/.github/workflows/main.yml):

```yml
name: CI
on:
  push:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2

    - name: Merge dict
      uses: amorphobia/action-merge-shupin-dict@master
      with:
        token: ${{ secrets.GITHUB_TOKEN }}
```

### Inputs

1. token: REQUIRED. The token for the repo. Just pass `${{ secrets.GITHUB_TOKEN }}` as the example;
2. contents: The path and file names of the contents. Default is "contents/*.txt";
3. dict: The output dictionary file name. Default is "shupin.dict.yaml";
4. branch: The git branch to push. Default is "master"

## License
The basic frame of this action is from [ad-m/github-push-action](https://github.com/ad-m/github-push-action)

[MIT License](https://github.com/amorphobia/action-merge-shupin-dict/blob/master/LICENSE)
