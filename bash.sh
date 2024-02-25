#!/bin/bash

# args
destination_path=$1
source_type=$2

# configs
runner_folder="final-check-bash"
compare_branch="develop"

echo "*******Final Checking*******"

#### phase 1: check spelling
echo "-------Step 1: Check Spelling-------"

runner_path=$(pwd)

# create temp dir to clone content
mkdir temp

# cd to destination source
cd $destination_path

# get git changed files
changed_files=$(git diff --diff-filter=AM --name-only $compare_branch)

# clone source to temp
temp_path="$runner_path/temp"

for file in $changed_files; do
	dir_name=$(dirname $file)

	if [[ $dir_name == "." ]]; then
		cp $file $temp_path
	else
		temp_dir_path=$temp_path/$dir_name
		test -d $temp_dir_path
		exists_folder=$(echo $?)

		# if not exists folder will create it
		if [[ exists_folder -eq 1 ]]; then
			mkdir -p $temp_dir_path
		fi

		cp $file $temp_path/$file
	fi
done

# cd to runner temp
cd $runner_path

# run cspell check for changed files
report_file_path="./out/issue_report.txt"
config_file_path="./cspell/config.json"

cspell_out=$(cspell --config $config_file_path --reporter @cspell/cspell-json-reporter temp/**)

# write to report json file
echo "$cspell_out" >$report_file_path

# run js summary
summary_path="./cspell/summary-report.js"
node $summary_path

# remove temp folder:
rm -rf temp

# show details info
echo "Issue report: 'out/issues_report.txt'"

#### phase 2: check based on script_check
# check args exits
if [[ -z "$source_type" ]]; then
	exit 1
fi

echo "-------Step 2: Check Based On Script-------"
script_file_path="./script_check/config.json"

# read script
script=$(jq -r ".$source_type" "$script_file_path")

# cd destination source
cd $destination_path

# exc cmd
eval $script
