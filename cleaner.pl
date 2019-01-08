
#my $fileName;
my $file;
my $cleanedFile;

my $line;
my $line2;
my $prefixe;
my $suffixe;

open($file, "<train.tsv");
open($cleanedFile, ">train2.tsv");

################
# Header

$line = <$file>;
print $cleanedFile $line;

################
# Cleaning

while($line = <$file>){
	if($line =~ /(^[0-9]+\t[0-9]+\t)(.+)(\t[0-4]\n$)/){
		$prefixe = $1;
		$line = " ".$2." ";
		$suffixe = $3;
	}
	
	# Symbols
	if($line =~ s/[\\\/\-,.':`=;!?*\$&#+]/ /g){}
	
	# Numerals
	if($line =~ s/ [a-zA-Z0-9]*[0-9][a-zA-Z0-9]* / /g){}
	
	# One letter long
	while($line =~ s/ [a-zA-Z] / /g){}
	
	if($line =~ s/ +/ /g){}
	if($line =~ s/^ | $//g){}
	
	if($line ne ""){
		print $cleanedFile $prefixe.$line.$suffixe;
	}
}

close($file);
close($cleanedFile);

