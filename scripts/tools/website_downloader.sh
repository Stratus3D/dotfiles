#! /bin/bash -

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

usage() {
    cat <<EOF
    Usage: site_sucker.sh [command]

    Commands:
    site [url] [destination dir]         Download all pages on the domain
    subdirectory [url] [destination dir] Download URL and sub pages
    single_page [url] [destination dir]  Download a single URL

    Options:
    --no-localize                        Don't localize links. With this option
                                         URLs may not work on your local copy
EOF
}

download() {
  wget \
    --recursive \ # Follow links and download the whole site
    --no-clobber \ # Don't overwrite files when downloading
    --page-requisites \ # Download CSS and other assets
    --html-extension \ # Save files with the .html extension
    --convert-links \ # Change URLs in links so they work offline
    --restrict-file-names=windows \ # modify filenames so they will work in Windows
    --domains $domain \ # Limit the download to this directory
    --no-parent $url # Don't follow links outside the directory
    --mirror
    --adjust-extension # Save HTML and CSS with the proper extensions
    -e robots=off
    --wait=9 --limit-rate=10K
}

if [ $# -gt 0 ]; then
    lower_command=$(echo $1 | awk '{print tolower($0)}');

    case $lower_command in
        'site')
            download ;;
        'subdirectory')
            print_fixmes;;
        'single_page')
            print_optimizes;;
        *)
            usage;;
    esac
else
    usage;
fi
