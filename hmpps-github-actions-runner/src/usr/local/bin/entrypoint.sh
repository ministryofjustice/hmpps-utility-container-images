#!/usr/bin/env bash

set -euo pipefail

ACTIONS_RUNNER_DIRECTORY="/actions-runner"
EPHEMERAL="${EPHEMERAL:-"false"}"

echo "Runner parameters:"
echo "  Repository: ${GITHUB_REPOSITORY}"
echo "  Runner Name: $(hostname)"
echo "  Runner Labels: ${RUNNER_LABELS}"

echo "Obtaining registration token"
getRegistrationToken=$(
  curl \
    --silent \
    --location \
    --request "POST" \
    --header "X-GitHub-Api-Version: 2022-11-28" \
    --header "Authorization: Bearer ${GH_AUTH_TOKEN}" \
    https://api.github.com/repos/"${GITHUB_REPOSITORY}"/actions/runners/registration-token | jq -r '.token'
)
export getRegistrationToken

echo "Checking if registration token exists"
if [[ -z "${getRegistrationToken}" ]]; then
  echo "Failed to obtain registration token"
  exit 1
else
  echo "Registration token obtained successfully"
  REPO_TOKEN="${getRegistrationToken}"
fi

if [[ "${EPHEMERAL}" == "true" ]]; then
  EPHEMERAL_FLAG="--ephemeral"
  trap 'echo "Shutting down runner"; exit' SIGINT SIGQUIT SIGTERM INT TERM QUIT
else
  EPHEMERAL_FLAG=""
fi

echo "Checking the runner"
bash "${ACTIONS_RUNNER_DIRECTORY}/config.sh" --check --url "https://github.com/${GITHUB_REPOSITORY}" --pat ${GH_AUTH_TOKEN}

echo "Configuring runner"
bash "${ACTIONS_RUNNER_DIRECTORY}/config.sh" ${EPHEMERAL_FLAG} \
  --unattended \
  --disableupdate \
  --url "https://github.com/${GITHUB_REPOSITORY}" \
  --token "${REPO_TOKEN}" \
  --name "$(hostname)" \
  --labels "${RUNNER_LABELS}"

echo "Setting the 'ready' flag for Kubernetes liveness probe"
touch /tmp/runner.ready

echo "Starting runner"
bash "${ACTIONS_RUNNER_DIRECTORY}/run.sh"
