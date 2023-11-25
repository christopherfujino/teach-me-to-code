# Workflows

For GitHub Actions. Per [https://docs.github.com/en/free-pro-team@latest/actions/quickstart].

## Personal Access Token

From user account, go to settings -> Personal access tokens -> Fine-grained tokens (beta).

Token name: publish-teach-me-to-code-from-gh-actions
Expiration: 1 year from today
Description:

> Intended for https://github.com/christopherfujino/teach-me-to-code/blob/master/.github/workflows/hugo-build.yml
> To publish to https://github.com/teach-me-to-code/teach-me-to-code.github.io/tree/master

Resource owner: teach-me-to-code
Repository access: only select repositories (teach-me-to-code/teach-me-to-code.github.io)

Permissions:

- Contents: read & write
- Metadata: read only
- Pages: read & write

## In repo Secrets & Variables

Actions secrets -> Repository Secrets

PASSWORD: personal access token
USERNAME: christopherfujino
