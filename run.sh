#!/bin/sh

function solve() {
  SOLVER_VERSION="1.1.1"
  name="${WERCKER_HOMEBREW_NAME:-$WERCKER_GIT_REPOSITORY}"
  owner="${WERCKER_HOMEBREW_OWNER:-$WERCKER_GIT_OWNER}"
  tag="${WERCKER_HOMEBREW_TAG:-$RELEASE_TAG}"

  # Setup solver
  cd $WERCKER_STEP_ROOT
  curl -L https://github.com/uetchy/solver/releases/download/v${SOLVER_VERSION}/solver_linux_amd64.tar.gz -o ${WERCKER_STEP_ROOT}/solver_linux_amd64.tar.gz
  tar xzf solver_linux_amd64.tar.gz
  solver_bin=${WERCKER_STEP_ROOT}/solver_linux_amd64/solver

  # Commit to homebrew repository
  cd $WERCKER_SOURCE_DIR
  ${solver_bin} push \
    --token "$WERCKER_HOMEBREW_TOKEN" \
    --name "$name" \
    --owner "$owner" \
    --tag "$tag" \
    --product-owner "$WERCKER_GIT_OWNER" \
    --version "$WERCKER_HOMEBREW_VERSION" \
    --message "$WERCKER_HOMEBREW_MESSAGE" \
    --target-path-64 "$WERCKER_HOMEBREW_FILE64" \
    --target-path-32 "$WERCKER_HOMEBREW_FILE32" \
    --committer "werckerbot" \
    --committer-email "pleasemailus@wercker.com"
}

if [ ! -n "$WERCKER_HOMEBREW_TOKEN" ]; then
  fail "Missing 'token' for Github API"
fi

if [ ! -n "$WERCKER_HOMEBREW_TAG" ]; then
  warn "No 'tag' given. aborting"
else
  solve()
fi
