#!/bin/sh

# Parameter Locker
# Prevent Access to certain parameters on DD_1 detail displays
# Brahm Neufeld
#
#------------------/!\ WARNING /!\------------------#
#
# This script will search through a directory (and 
# all of its subdirectories) and modify all .fdf files. 
# Before pointing it at a folder (defined by 
# DISPLAYPATH), ensure you have a backup. 
#
# This will also delete any *.g files in the specified
# directory (and subdirs) as a final step. 
#
# Shared with no warranty, guarantees, etc. 
#
#------------------/!\ WARNING /!\------------------#

# set verbose mode so we can see commands being executed
set -x


# set directory to have detail displays converted. 
# 	default is "/opt/fox/dd_1"
# if you only want to modify dd's for specific blocks, 
# point it at the appropriate subdir, eg: 
# 
# 	"/opt/fox/dd_1/aout"
# 
DISPLAYPATH="/opt/fox/dd_1"


# call Foxboro's fdf-to-g file utility. the -r is a flag to recursively search a directory. 
/usr/fox/wp/bin/tools/fdf_g -r $DISPLAYPATH


# search through subdirectories for *.g files
# go through each .g file looking for a string of text, eg:
# 	cmd== PICK1 .INT
# if found, modify the access control level on that same line 
# from the default of 0 to the site-specific requirement, eg:
# 	s/alevel=0/alevel=16/g
#
#	^ the above replaces alevel=0 with alevel=16
#
# extra lines/parameters can be added by inserting another line like this: 
# 	-e '/cmd== PICK1 .PBAND/ s/alevel=0/alevel=16/g' \
#
# 	... replacing .PBAND with whatever parameter you want. 
# 
find $DISPLAYPATH -name "*.g" |
while IFS= read -r file; do
	sed -e '/cmd== PICK1 .MANSW/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .AUTSW/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .LOCSW/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .REMSW/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .TRKENL/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .TRACK/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .HOLD/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .FOLLOW/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .SET/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .CLEAR/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .MTRFAC/ s/alevel=0/alevel=16/g' \
	-e '/cmd== PICK1 .MRATE/ s/alevel=0/alevel=16/g' \
	"$file" > tmp && mv tmp "$file"
done


# call Foxboro's g-to-fdf file utility. the -r is a flag to recursively search a directory. 
/usr/fox/wp/bin/tools/g_fdf -r $DISPLAYPATH

# delete all .g files that were created. 
find $DISPLAYPATH -name "*.g" -exec rm -rf {} \;