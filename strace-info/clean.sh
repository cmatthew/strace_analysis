#! /bin/bash

# append / here in case we set it to the empty string somehow (will make the first statement 'rm -r /*' !)
outDir="traces/"
resDir="analysis/"

rm -r $outDir""* $resDir""*
#rmdir $outDir""kernel $outDir""network $outDir $resDir""kernel $resDir""network $resDir
rmdir $outDir $resDir
