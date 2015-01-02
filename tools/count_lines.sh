#! /bin/bash
FILES=$(find . -iname "*.$1")
wc -l $FILES
