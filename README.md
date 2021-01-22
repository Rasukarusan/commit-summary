# Github Actions - Get commit summary

Get the commits from the previous tag.

## Inputs

- `ref`: ${{ GitHub.ref }}. The new tag.


## Outputs

- `summary`: The hash commits and commit messages

example
```sh
a722eac replace step
6e5bf22 create action for get commit summary
```

## Example workflow

```yaml
name: Release

on:
  push:
    tags:
      - 'v*'
jobs:
  build:
    name: Create Release
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        with:
          fetch-depth: 0

      # get commit summary
      - name: Get commit summary
        uses: actions/commit-summary@v1
        id: get_commit_summary
        with:
          ref: ${{ github.ref }}

      # create release
      - name: Create Release
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ github.ref }}
          release_name: Release ${{ github.ref }}
          body: |
            ${{ steps.get_commit_summary.outputs.summary }}
          draft: false
          prerelease: false
```
