use LWP::UserAgent;
use Term::ANSIColor;
use LWP::Simple;

my $url = $ARGV[1];
my $ou = new LWP::UserAgent;
my $file = "grabber/wplist.txt";
my $vnum = "0";
my $nvnum = "0";

open(w,"<$file") or die "$!";

banner();
print color("green") , "\n   [+] Scanning ...          [ This May Take Few Minutes ] \n\n" , color("reset");


while(<w>){
	chomp($_);
	my $str = "$_";
	my @fields = split /\t/, $str;
	my $fl = "$fields[0]";
	my $sl = "$fields[1]";
	my $tl = "$fields[2]";
	my $fol = "$fields[3]";
	my $wpsource = $ou->get("$url")->decoded_content;

if (head("$url" . "$fl")){
	print color("yellow") , "\a   [+] URL              : $url\n" , color("reset");
	print color("yellow") , "   [+] Script Installed : $fol\n" , color("reset");
	print color("yellow") , "   [+] Vuln. Plugin     : $fl\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : $tl\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : $sl\n\n" , color("reset");
	$vnum = $vnum + 1;
}

	$nvnum = $nvnum + 1;
}



# Backup Finder Request ^_^
my $bbnum = "0";
my $backreqq = "No";
while ("$backreqq" eq "No"){
print color("green") . "\n  [~] Do You Want To Start Backup-Finder ? [Y/n] : " . color("reset");
my $backreq = <STDIN>;
chomp($backreq);
if ("$backreq" eq "y" or "$backreq" eq "Y" or "$backreq" eq "Yes" or "$backreq" eq "yes" or "$backreq" eq "YES" or "$backreq" eq ""){
	$backreqq = "Yes";
@configs = ('backup.zip','upload.zip','vb.zip','forum.zip','forum.tar','forum.tar.gz','backup.tar.gz','2.zip','1.zip','database.zip','sql.zip','backup.sql','database.sql','db.sql','site.sql','DB.sql','Database.sql','db.zip','1.sql','Database.zip');
print "\n";
foreach my $config (@configs){
    if (head("$url/$config")) {
    print color("yellow") . "\a\n    - File Found : $url/$config\n" . color("reset");
    $bbnum = $bbnum + 1;
    }
}
if ("$bbnum" eq "0"){
	print color("red") . "\n  [-] Not Found Any Backup File !!\n" . color("reset");
}
}elsif ("$backreq" eq "n" or "$backreq" eq "N" or "$backreq" eq "no" or "$backreq" eq "No" or "$backreq" eq "NO" or "$backreq" eq "nO"){
		$backreqq = "Yes";
	print "\n";
	}else{
		print color("red") . "\n  [-] Command '$backreq' Not Found !!\n" . color("reset");
		$backreqq = "No";
	}
}






# Config Finder Request ^_^
my $ccnum = "0";
my $conreqq = "No";
while ("$conreqq" eq "No"){
print color("green") . "\n  [~] Do You Want To Start Config-Finder ? [Y/n] : " . color("reset");
my $conreq = <STDIN>;
chomp($conreq);
if ("$conreq" eq "y" or "$conreq" eq "Y" or "$conreq" eq "Yes" or "$conreq" eq "yes" or "$conreq" eq "YES" or "$conreq" eq ""){
	$conreqq = "Yes";
@cnconfigs = ('wp-config.php' , 'wp-config.php~' , 'wp-config.php.new' , 'wp-config.php.new~' , 'config.php~','config.php.new','config.php.new~','config.php.old','config.php.old~','config.bak','config.php.bak','config.php.bkp','config.txt','config.php.txt','config - Copy.php');
foreach $cnconfig(@cnconfigs){
    $sourcsse=$ou->get("$url/$cnconfig")->decoded_content;
    if($sourcsse =~ m/ /i || $sourcsse =~ m/a/i || $sourcsse =~ m/\//i || $sourcsse =~ m/:/i){
    	print color("yellow") . "\a\n    - Config File Path : $url/includes/$cnconfig\n" . color("reset");
    	$ccnum = $ccnum + 1;
    }
}
if ("$ccnum" eq "0"){
	print color("red") . "\n  [-] Not Found Any Readable Config File !!\n" . color("reset");
}

}elsif ("$conreq" eq "n" or "$conreq" eq "N" or "$conreq" eq "no" or "$conreq" eq "No" or "$conreq" eq "NO" or "$conreq" eq "nO"){
		$conreqq = "Yes";
	print "\n";
	}else{
		print color("red") . "\n  [-] Command '$conreq' Not Found !!\n" . color("reset");
		$conreqq = "No";
	}
}






# Shell Finder Request ^_^
my $scnum = "0";
my $shreqq = "No";
while ("$shreqq" eq "No"){
print color("green") . "\n  [~] Do You Want To Start Shell-Finder ? [Y/n] : " . color("reset");
my $shreq = <STDIN>;
chomp($shreq);
if ("$shreq" eq "y" or "$shreq" eq "Y" or "$shreq" eq "Yes" or "$shreq" eq "yes" or "$shreq" eq "YES" or "$shreq" eq ""){
	$shreqq = "Yes";
@shells = ('' , '' , '' , '');
foreach $shell(@shells){
    if(head("$url/$shell")){
    	print color("yellow") . "\a\n    - Shell File Path : $url/$shell\n" . color("reset");
    	$scnum = $scnum + 1;
    }
}
if ("$scnum" eq "0"){
	print color("red") . "\n  [-] Not Found Any Shell File !!\n" . color("reset");
}

}elsif ("$shreq" eq "n" or "$shreq" eq "N" or "$shreq" eq "no" or "$shreq" eq "No" or "$shreq" eq "NO" or "$shreq" eq "nO"){
		$shreqq = "Yes";
	print "\n";
	}else{
		print color("red") . "  [-] Command '$shreq' Not Found !!\n" . color("reset");
		$shreqq = "No";
	}
}




if ("$vnum" eq "0"){
	print color("yellow") , "   [!] Exploit Tested : $nvnum\n" , color("reset");
	print color("red") , "  [-] Sorry Not Found." , color("reset");
}else{
	print color("yellow") , "   [!] Exploit Tested : $nvnum\n" , color("reset");
	print color("yellow") , "   [!] Exploit Found  : $vnum\n\n" , color("reset");
}
if ("$scnum" ne "0"){
	print color("red") . "  [-] Shell Found : $scnum\n" . color("reset");
}

if ("$ccnum" ne "0"){
	print color("red") . "  [-] Config Found : $ccnum\n" . color("reset");
}

if ("$bbnum" ne "0"){
	print color("red") . "  [-] Backup Found : $bbnum\n" . color("reset");
}
