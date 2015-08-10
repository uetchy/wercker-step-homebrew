# wercker-step-homebrew

Keep your Homebrew's formula fresh using [solver](https://github.com/uetchy/solver).

Example commit is [here](https://github.com/uetchy/homebrew-gst/commit/cd3ae8b1d4f8df9f8d41e120d384a5e41db9c139).

## Usage

```yaml
~~~trimmed~~~
deploy:
  steps:
    - wercker/github-create-release:
        token: $GITHUB_TOKEN
        tag: v1.0.0
    - wercker/github-upload-asset:
        token: $GITHUB_TOKEN
        file: snapshot/solver_darwin_amd64.zip
    - wercker/github-upload-asset:
        token: $GITHUB_TOKEN
        file: snapshot/solver_darwin_386.zip
    - uetchy/homebrew:
        token: $GITHUB_TOKEN
        tag: v1.0.0
        file64: snapshot/solver_darwin_amd64.zip
        file32: snapshot/solver_darwin_386.zip
```

## Options

There are all of available options.

|option |description          |
|-------|---------------------|
|token [$GITHUB_TOKEN]|Github access token  |
|tag [$RELEASE_TAG]|Release tag          |
|file64 |binary or package(64)|
|file32 (optional)|binary or package(32)|
|version (optional)|Formula's Version|
|name (optional)|Formula repo |
|owner (optional)|Owner of formula repo|
|product-owner (optional)|Owner of product repo|
|message (optional)|Commit message|

## Contributing

This step currently focusing on Golang project.
If you have any idea of creating formula for another language's project, please feel free to submit Pull-request or create issues.
