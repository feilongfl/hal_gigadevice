#!/usr/bin/env fish

set script_dir (dirname (status --current-filename))
set top (realpath $script_dir/../..)
set target (realpath $top/$argv[1])
echo work at $top , target: $target

# # mkdirs
# set libbak $target.bak
# mv $target $libbak
# mkdir -p $target

# # copy files and drop unnessary files
# cp -rv $libbak/Firmware/CMSIS $target/CMSIS
# rm $target/CMSIS/*.h
# cp -rv $libbak/Firmware/GD32C10x_standard_peripheral $target/standard_peripheral
# cp $libbak/Template/*_libopt.h $target/standard_peripheral/include

# change file to unix format
# find $target type f -print0 | xargs -0 dos2unix -k

# git add .
# git commit -s -m "auto: librefact: add original lib file."

# patch the files
for cocci in (find $script_dir -name "*.cocci" )
    find $target -name "*.h" -or -name "*.c" | xargs -P0 -n1 $script_dir/eval_patch.sh $cocci
end

# git add .
# git commit -s -m "auto: librefact: apply cocci patches."
