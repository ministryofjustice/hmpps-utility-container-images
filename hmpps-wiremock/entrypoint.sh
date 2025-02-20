#!/bin/bash
set -e

WIREMOCK_MAPPINGS_DIR="/home/wiremock/mappings"
mkdir -p "${WIREMOCK_MAPPINGS_DIR}"

WIREMOCK_FILES_DIR="/home/wiremock/__files"
mkdir -p "${WIREMOCK_FILES_DIR}"

clone_and_copy() {
    local repoSpec="$1"
    local repoUrl=$(echo "${repoSpec}" | jq -r '.repoUrl')
    local branch=$(echo "${repoSpec}" | jq -r '.branch')
    local mappingsPath=$(echo "${repoSpec}" | jq -r '.path')
    local repoUrlNoGit=$(echo "${repoUrl}" | sed 's/\.git$//')
    local repoName=$(basename "${repoUrlNoGit}")

    echo ""
    echo "Repo: ${repoName}"
    echo "   Cloning ${repoUrl} (branch: ${branch})..."

    cloneDir="/tmp/wiremock-${repoName}@${branch}"

    if [[ -n "${GITHUB_TOKEN}" ]]; then
      repoUrl=$(echo "$repoUrl" | sed "s|https://github.com/|https://$GITHUB_TOKEN@github.com/|")
    fi
    git clone --quiet --depth=1 --branch "${branch}" "${repoUrl}" "${cloneDir}"

    targetDir="${cloneDir}/${mappingsPath}"
    if [ ! -d "${targetDir}" ]; then
        echo "   Error: The specified path '${mappingsPath}' does not exist in the repository."
        exit 1
    fi

    if [ -d "${targetDir}/mappings" ]; then
        echo "   Copying mappings from '${targetDir}/mappings' to '${WIREMOCK_MAPPINGS_DIR}'..."
        cp -r "${targetDir}/mappings/." "${WIREMOCK_MAPPINGS_DIR}"
    else
        echo "   Warning: No 'mappings' directory found at '${targetDir}'."
    fi

    if [ -d "${targetDir}/__files" ]; then
        echo "   Copying __files from '${targetDir}/__files' to '${WIREMOCK_FILES_DIR}'..."
        cp -r "${targetDir}/__files/." "${WIREMOCK_FILES_DIR}"
    else
        echo "   Warning: No '__files' directory found at '${targetDir}'."
    fi

    rm -rf "${cloneDir}"

    echo "   Finished processing '${repoUrl}'"
    echo ""
}

if [[ -n "${WIREMOCK_REPOS}" ]]; then
    echo "Parsing repos from WIREMOCK_REPOS"
    echo "${WIREMOCK_REPOS}" | jq -c '.[]' | while read -r repoSpec; do
        clone_and_copy "${repoSpec}"
    done
else
    echo "No WIREMOCK_REPOS provided—using existing mappings in ${WIREMOCK_MAPPINGS_DIR}."
fi

echo "Checking for duplicate WireMock stub 'id' fields..."
declare -A seenIds

while IFS= read -r -d '' stubFile; do
    currentId="$(jq -r '.id // empty' "${stubFile}" 2>/dev/null || true)"
    if [ -n "${currentId}" ]; then
        if [[ -v "seenIds[${currentId}]" ]]; then
            echo "   Removing file ${stubFile} because wiremock ID '${currentId}' is already present."
            rm -f "${stubFile}"
        else
            seenIds["${currentId}"]=1
        fi
    fi
done < <(find "${WIREMOCK_MAPPINGS_DIR}" -type f -name "*.json" -print0)

echo "Starting WireMock..."
exec /docker-entrypoint.sh --port=8090 --global-response-templating --disable-gzip --verbose