#!/usr/bin/perl

$fname = "test-files/scratch.txt";

open(F_HANDLE, "+>>$fname") || die "Failed to open $fname, $!";

while(<F_HANDLE>) {
   print $_;
}
print F_HANDLE "perl'ed!\n";

close(F_HANDLE);
