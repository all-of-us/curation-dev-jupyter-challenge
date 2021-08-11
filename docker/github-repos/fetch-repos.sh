#!/usr/bin/env bash

# what language are we interested in?
LANGUAGE_OF_INTEREST="${LANGUAGE_OF_INTEREST:-python}"

# number of seconds to sleep in between requests
SLEEP_SECONDS="${SLEEP_SECONDS:-5}"

# base url for github api
FETCH_BASE_URL="https://api.github.com/search/repositories?q=language:${LANGUAGE_OF_INTEREST}&sort=stargazers_count&per_page=100&page="

# base output file, should be defined by an ENVVAR
OUTPUT_FILE="${GITHUB_REPOS_CSV:-$(pwd)/repos-csv-output/${LANGUAGE_OF_INTEREST}-github-repos.csv}"

# list of fields we're extracting from the returned json
FIELDS_OF_INTEREST=(name full_name created_at updated_at pushed_at git_url ssh_url\
 homepage size stargazers_count watchers_count language has_issues has_projects \
 has_downloads has_wiki has_pages forks_count mirror_url archived disabled \
 open_issue_count forks open_issues watchers default_branch
)

# join_by kindly defined by this nice SOBRO: https://stackoverflow.com/a/17841619/11101981
function join_by { local d=${1-} f=${2-}; if shift 2; then printf %s "$f" "${@/#/$d}"; fi; }

# this variable gets used repeatedly by the write_rows function
MAP_COLUMNS=.$(join_by ', .' "${FIELDS_OF_INTEREST[@]}")

# write_rows takes the returned json, extracts key fields, and writes out a row per entry into our csv file
function write_rows() {
  filename="${1}"
  json_data="${2}"

  echo -n "${json_data}" \
    | jq -r ".items | map([${MAP_COLUMNS}]) | foreach .[] as \$row ([]; \$row ; @csv)" \
    >> "${filename}"
}

# fetch_repo_list_page executes our paginated http query against the github api, returning the resulting json
function fetch_repo_list_page() {
  page="${1}"

  curl -s -H "Accept: application/json" "${FETCH_BASE_URL}${page}"
}

# we want to trap interrupt signals
trap ctrl_c INT

# exits our script if ctrl+c (interrupt) is seen
function ctrl_c() {
	echo 'Done been interrupted, shutting down...'
	exit 0
}

# seed output file
echo '"'"$(join_by '","' "${FIELDS_OF_INTEREST[@]}")"'"' > "${OUTPUT_FILE}"

# query for top 1000 python project repos
for i in {1..10}
do
  echo "Querying for page ${i}..."
  page_json=$(fetch_repo_list_page i)
  write_rows "${OUTPUT_FILE}" "${page_json}"
  echo "Sleeping ${SLEEP_SECONDS} seconds..."
  sleep "${SLEEP_SECONDS}"
done