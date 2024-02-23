## Requirements

Install packages:

- NodeJS
- CSpell Ref:
  https://cspell.org/docs/getting-started/

  `npm install -g cspell@latest`

- JQ Ref:
  https://www.npmjs.com/package/jq

  For Debian/Ubuntu:
  `sudo apt-get install jq`  
  For macOS:
  `brew install jq`

## Description

- Bash shell to final checking after coding done

## Usage

1. Clone repo.
2. Set `exc` permission for bash file `chmod +x bash.sh`.
3. Config `script_checking` in `script_check/config.json` file.
4. Run `bash` file with args `./bash.sh destination/path backend` (arg is `script` key in `script_check/config.json` Ex: `backend`, `frontend`,...).
