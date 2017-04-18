#! /bin/bash -

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
#ORIGINAL_IFS=$IFS

DEFAULT_DOMAIN=stratus3d.com

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
  url=$1;
  #domain=?
  cookies_file=~/cookies.txt

  # Follow links and download the whole site
  wget "$url" --recursive \
      # Don't overwrite files when downloading
    --no-clobber \
    # Download CSS and other assets
    --page-requisites \
    # Save files with the .html extension
    --html-extension \
    # Change URLs in links so they work offline
    --convert-links \
    # modify filenames so they will work in Windows
    --restrict-file-names=windows \
    # Limit the download to this directory
    --domains $domain \
    # Don't follow links outside the directory
    --no-parent "$url" \
    --mirror \
    # Save HTML and CSS with the proper extensions
    --adjust-extension \
    -e robots=off \
    --wait=9 --limit-rate=10K \
    # Use cookies from file. Usefully when dealing with site behind a login page
    #--load-cookies=$cookies_file
}

if [ $# -gt 0 ]; then
    lower_command=$(echo "$1" | awk '{print tolower($0)}');

    case $lower_command in
        'site')
            if [ $# -gt 2 ]; then
                url=${2:-$DEFAULT_DOMAIN}
                directory=${3:-$HOME}

                download "$url" "$directory"
            else
                echo "You must provide a URL and a destination directory"
            fi;;
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
