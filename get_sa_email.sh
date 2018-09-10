#!/bin/bash -ex

# Extract JSON args into shell variables
JQ=$(command -v jq || true)
[[ -z "${JQ}" ]] && echo "ERROR: Missing command: 'jq'" >&2 && exit 1

eval "$(${JQ} -r '@sh "INSTANCE=\(.instance_group)  PROJECT=\(.project)"')"

TMP_DIR=$(mktemp -d)
function cleanup() {
  rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

if [[ ! -z ${GOOGLE_CREDENTIALS+x} && ! -z ${GOOGLE_PROJECT+x} ]]; then
  export CLOUDSDK_CONFIG=${TMP_DIR}
  gcloud auth activate-service-account --key-file - <<<"${GOOGLE_CREDENTIALS}"
  gcloud config set project "${GOOGLE_PROJECT}"
fi

PROJECT=${PROJECT:-$(gcloud config get-value project 2>/dev/null)}

RES=$(gcloud --project ${PROJECT} sql instances describe ${INSTANCE} --format='value(serviceAccountEmailAddress)')

# Output results in JSON format.
jq -n --arg instance "${INSTANCE}" --arg project "${PROJECT}" --arg sa_email "${RES}" '{"instance":$instance, "project":$project, "sa_email":$sa_email}'