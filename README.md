# wercker-step-homebrew

Keep your Homebrew's formula fresh by using [solver](https://github.com/uetchy/solver).

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
        version: 1.0.0
        file64: snapshot/solver_darwin_amd64.zip
        file32: snapshot/solver_darwin_386.zip
```

## Contributing

This step currently focusing on Golang project.
If you have any idea of creating formula for another language's project, please feel free to submit Pull-request or create issues.