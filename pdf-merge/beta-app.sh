#!/bin/bash

# Collect all PDFs in the current directory
files=$(ls *.pdf | sort)

# Merge them with pdftk
pdftk $files cat output output.pdf
