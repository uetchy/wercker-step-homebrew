# wercker-step-homebrew

Keep your Homebrew's formula fresh by using [solver](https://github.com/uetchy/solver).

## Usage

```yaml
box: motemen/golang-goxc
build:
  steps:
    - setup-go-workspace
    - script:
        name: get dependencies
        code: |
          go get
    - script:
        name: goxc build / archive
        code: |
          goxc -tasks='xc archive' -bc 'linux,!arm windows darwin' -d $WERCKER_OUTPUT_DIR/ -build-ldflags "-X main.Version \"$(git describe --tags --always --dirty)\""
    - script:
        name: output release tag
        code: |
          git describe --tags --exact --match 'v*' > $WERCKER_OUTPUT_DIR/.release_tag || true
deploy:
  steps:
    - script:
        name: restore variables
        code: |
          export RELEASE_TAG=$(cat .release_tag)
          export RELEASE_VERSION=$(cat .release_tag | sed 's/^v//')
    - wercker/github-create-release:
        token: $GITHUB_TOKEN
        tag: $RELEASE_TAG
    - wercker/github-upload-asset:
        token: $GITHUB_TOKEN
        file: snapshot/solver_darwin_amd64.zip
    - wercker/github-upload-asset:
        token: $GITHUB_TOKEN
        file: snapshot/solver_darwin_386.zip
    - uetchy/homebrew:
        token: $GITHUB_TOKEN
        version: $RELEASE_VERSION
        file64: snapshot/solver_darwin_amd64.zip
        file32: snapshot/solver_darwin_386.zip
```
