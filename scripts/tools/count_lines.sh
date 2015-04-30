#! /bin/bash
FILES=$(find . -iname "*.$1")
$FILES | wc -l
