# args
source_type=$1

# configs
runner_path="../final-check-bash"
compare_branch="develop"

echo "*******Final Checking*******"

#### phase 1: check spelling
echo "-------Step 1: Check Spelling-------"

# get git changed files
changed_files=$(git diff --name-only $compare_branch)
echo "$changed_files"

# run cspell check for changed files
report_file_path="$runner_path/out/issue_report.txt"
config_file_path="$runner_path/cspell/config.json"

cspell_out=$(cspell --config $config_file_path --reporter @cspell/cspell-json-reporter $changed_files)

# write to report json file
echo "$cspell_out" >$report_file_path

# run js summary
summary_path="$runner_path/cspell/summary-report.js"
node $summary_path

# show details info
echo "Issue report: 'out/issues_report.txt'"

#### phase 2: check based on script_check
echo "-------Step 2: Check Based On Script-------"
script_file_path="$runner_path/script_check/config.json"

# read script
script=$(jq -r ".$source_type" "$script_file_path")

# exc cmd
eval $script
