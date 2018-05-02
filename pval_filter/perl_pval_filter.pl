#!/usr/bin/perl

$old_dir = $ARGV[0];
$new_dir = $ARGV[1];
$threshold = $ARGV[2];

$mkdir = "mkdir ./$new_dir";
system ($mkdir);


opendir (OPENDIR, "./$old_dir") || die ("Can't open directory $old_dir");
@files = readdir (OPENDIR);

foreach $file (@files) {

#	print ("$file\n");

	if ($file ne "." && $file ne ".."){
#	print ("$file\n");

		$touch_file = "touch ./$new_dir/$file";
		system ($touch_file);
	
	
		open (READ, "<", "./$old_dir/$file") || die ("Can't open file $file");
		$header = <READ>;
#		print ("$header\n");

		open (WRITE, ">", "./$new_dir/$file");
		print WRITE "$header";


			while ($line = <READ>){
			chomp ($line);

			@lineparts = split (/\t/, $line);
#			print ($lineparts[0], $lineparts[1], $lineparts[2], $lineparts[3], $lineparts[4], "\n")
				

				if (	($lineparts[1] < $threshold || $lineparts[1] eq NA) &&
					($lineparts[2] < $threshold || $lineparts[2] eq NA) &&
					($lineparts[3] < $threshold || $lineparts[3] eq NA) &&
					($lineparts[4] < $threshold || $lineparts[4] eq NA)	 ) {

#						print ($line, "\n");

						print WRITE "$line\n";											

				}


			}

		

		close (READ);
		close (WRITE);	

}

}
