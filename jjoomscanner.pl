use LWP::UserAgent;
use Term::ANSIColor;
use LWP::Simple;

my $url = $ARGV[1];
my $ou = new LWP::UserAgent;
my $file = "grabber/joomlist.txt";
my $vnum = "0";
my $nvnum = "0";

open(j,"<$file") or die "$!";

banner();
print color("green") , "\n   [+] Scanning...          [ This May Take Few Minutes ] \n" , color("reset");

if (chop($url) ne "/"){
	$url = "$url/";
}


# Checking Joomla Version
my $pourl = "https://joomjunk.co.uk/extras-page/joomla-version-detect.html";
my $joomver = $ou->post($pourl , { site => $url , submit => '' , })->content;
my $str = "$joomver";
$str =~ /(<h2>Joomla version : \S+)/;
my $verjo = "$1";
my $rrr = substr($verjo,21);
my @fidfelds = split /\</, $rrr;
my $version = "";
$version = $fidfelds[0];

if ("$version" ne ""){
	print color("green") , "\n   [+] Script : Joomla\n" . color("reset");
	print color("green") , "   [+] Joomla Version Detected : $version\n" , color("reset");
}else{
	print color("green") , "\n   [+] Script : Joomla\n" . color("reset");
	print color("red") , "   [-] Joomla Version Cannot Be Detected !!\n" , color("reset");
}




# Check Htaccess
my $htnum = "0";
my @htac = ('.htaccess' , '.htaccess.txt' , 'htaccess' , 'htaccess.txt');
foreach	my $ht (@htac){
	my $shtac = $ou->get("$url/$ht")->decoded_content;
	if (head("$url/$ht") and "$shtac" =~ "</"){
	print color("green") , "   [+] Htaccess File Found At : $url/$ht\n" . color("reset");
	$htnum = $htnum + 1;
	}
}
if ("$htnum" eq "0"){
	print color("red") , "   [-] Htaccess File Not Avalible Or Not Readable !!\n" , color("reset");
}
	
	my $srobots = $ou->get("$url/robots.txt")->decoded_content;
	if (head("$url/robots.txt") and "$srobots" =~ "User-agent:" or "$srobots" =~ "User-agent:" or "$srobots" =~ "Disallow:"){
	print color("green") , "   [+] Robots File Found At : $url/robots.txt\n" . color("reset");
	$htnum = $htnum + 1;
	}

	my $scp = $ou->get("$url/administrtator/")->decoded_content;
	if (head("$url/administrtator") and "$scp" =~ "admin" or "$scp" =~ "panel" or "$scp" =~ "login"){
	print color("green") , "   [+] Admin Panel Found At : $url/administrtator/\n" . color("reset");
	print color("green") , "   [!] The Attacker Can make Bruteforce Attack Easly\n" . color("reset");	
	$htnum = $htnum + 1;
	}



	my $scp1 = $ou->get("$url/admin/")->decoded_content;
	if (head("$url/admin/") and "$scp1" =~ "admin" or "$scp1" =~ "panel" or "$scp1" =~ "login"){
	print color("green") , "   [+] Admin Panel Found At : $url/admin/\n" . color("reset");
	print color("green") , "   [!] The Attacker Can make Bruteforce Attack Easly\n" . color("reset");	
	$htnum = $htnum + 1;
	}



	my $scp2 = $ou->get("$url/manage/")->decoded_content;
	if (head("$url/manage/") and "$scp2" =~ "admin" or "$scp2" =~ "panel" or "$scp2" =~ "scp2"){
	print color("green") , "   [+] Admin Panel Found At : $url/manage/\n" . color("reset");
	print color("green") , "   [!] The Attacker Can make Bruteforce Attack Easly\n" . color("reset");	
	$htnum = $htnum + 1;
	}



# Search Plugin
print "\n";
while(<j>){
	chomp($_);
	my $str = "$_";
	my @fields = split /\t/, $str;
	my $fl = "$fields[0]";
	my $sl = "$fields[1]";
	my $tl = "$fields[2]";
	my $fol = "$fields[3]";
	my $joomsource = $ou->get("$url")->decoded_content;

if ("$joomsource" =~ "$fl"){
	print color("yellow") , "\a   [+] Vuln. Plugin     : $fl\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : $tl\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : $sl\n\n" , color("reset");
	$vnum = $vnum + 1;
}
	$nvnum = $nvnum + 1;
}



# Search Path
my $file2 = "grabber/j2.txt";
my $vnum2 = "0";
my $nvnum2 = "0";
open(www,"<$file2") or die "$!";
while(<www>){
	chomp($_);
	my $jnd = "$_";
	my @fields2 = split /\t/, $jnd;
	my $fl2 = "$fields2[0]";
	my $sl2 = "$fields2[1]";
	my $tl2 = "$fields2[2]";
	my $fol2 = "$fields2[3]";

if (head("$url" . "$fl2")){
	print color("yellow") , "\a   [+] URL              : $url\n" , color("reset");
	print color("yellow") , "   [+] Script Installed : $fol2\n" , color("reset");
	print color("yellow") , "   [+] Vuln. Plugin     : $fl2\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : $tl2\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : $sl2\n\n" , color("reset");
	$vnum2 = $vnum2 + 1;
}

	$nvnum2 = $nvnum2 + 1;
}




# Search By Version
if ("$version" != ""){
if ("$version" eq "1.5" or "$version" eq "1.6" or "$version" eq "1.7" or "$version" eq "3.0" or "$version" eq "3.1" or "$version" eq "3.2" or "$version" eq "3.3" or "$version" eq "3.4" or "$version" =~ "1.5." or "$version" =~ "1.6." or "$version" =~ "1.7." or "$version" =~ "3.0." or "$version" =~ "3.1." or "$version" =~ "3.2." or "$version" =~ "3.3." or "$version" =~ "3.4." or "$version" =~ "3.4.5"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Object Injection RCE\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1Zp9YU\n\n" , color("reset");
	$vnum = $vnum + 1;
}
if ("$version" eq "3.2" or "$version" =~ "3.2." or "$version" =~ "3.3." or "$version" =~ "3.4." or "$version" =~ "3.3" or "$version" =~ "3.4"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : SQL-Injection\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1ZpAKy\n\n" , color("reset");
	$vnum = $vnum + 1;
}
# Add Here The Version Vulnerability
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
	my $srt = $ou->get("$url/$config")->decoded_content;
    if (head("$url/$config")) {
    	if ("$srt" =~ "Access denied." or "$srt" =~ "404 Not Found"){
    		my $rrrrrrjdskhfg = "dfgjshd";
    		}else{
    print color("yellow") . "\a    - File Found : $url/$config\n" . color("reset");
    $bbnum = $bbnum + 1;
}
    }
}
if ("$bbnum" eq "0"){
	print color("red") . "      [-] Not Found Any Backup File !!\n" . color("reset");
}
}elsif ("$backreq" eq "n" or "$backreq" eq "N" or "$backreq" eq "no" or "$backreq" eq "No" or "$backreq" eq "NO" or "$backreq" eq "nO"){
		$backreqq = "Yes";
	print "\n";
	}else{
		print color("red") . "      [-] Command '$backreq' Not Found !!\n" . color("reset");
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
@cnconfigs = ('configuration.php' , 'configuration.php~' , 'configuration.php.new' , 'configuration.php.new~' , 'config.php~','config.php.new','config.php.new~','config.php.old','config.php.old~','config.bak','config.php.bak','config.php.bkp','config.txt','config.php.txt','config - Copy.php');
foreach $cnconfig(@cnconfigs){
    $sourcsse=$ou->get("$url/$cnconfig")->decoded_content;
    if(head("$url/$config") and $sourcsse =~ m/DB_NAME/i || $sourcsse =~ m/define/i || $sourcsse =~ m/\'\)\;/i || $sourcsse =~ m/\"\)\;/i){
    	print color("yellow") . "\a    - Config File Path : $url/includes/$cnconfig\n" . color("reset");
    	$ccnum = $ccnum + 1;
    }
}
if ("$ccnum" eq "0"){
	print color("red") . "      [-] Not Found Any Config File !!\n" . color("reset");
}

}elsif ("$conreq" eq "n" or "$conreq" eq "N" or "$conreq" eq "no" or "$conreq" eq "No" or "$conreq" eq "NO" or "$conreq" eq "nO"){
		$conreqq = "Yes";
	print "\n";
	}else{
		print color("red") . "      [-] Command '$conreq' Not Found !!\n" . color("reset");
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
@shells = ('c99.php' , '.c99.php' , 'wos.php' , 'wso.php' , '.wos.php' , '.wso.php' , '.r57.php' , 'r57.php' , 'sql.php' , '.sql.php' , 'shell.php' , '.shell.php');
foreach $shell(@shells){
    if(head("$url/$shell")){
    	print color("yellow") . "\a    - Shell File Path : $url/$shell\n" . color("reset");
    	$scnum = $scnum + 1;
    }
}
if ("$scnum" eq "0"){
	print color("red") . "      [-] Not Found Any Shell File !!\n" . color("reset");
}

}elsif ("$shreq" eq "n" or "$shreq" eq "N" or "$shreq" eq "no" or "$shreq" eq "No" or "$shreq" eq "NO" or "$shreq" eq "nO"){
		$shreqq = "Yes";
	print "\n";
	}else{
		print color("red") . "      [-] Command '$shreq' Not Found !!\n" . color("reset");
		$shreqq = "No";
	}
}


if ("$vnum" eq "0"){
	print color("yellow") , "\n  [!] Exploit Tested : $nvnum\n" , color("reset");
	print color("red") , "  [-] Sorry Not Found." , color("reset");
}else{
	print color("yellow") , "\n  [!] Exploit Tested : $nvnum\n" , color("reset");
	print color("yellow") , "  [!] Exploit Found  : $vnum\n" , color("reset");
}
if ("$scnum" ne "0"){
	print color("yellow") . "  [-] Shell Found : $scnum\n" . color("reset");
}

if ("$ccnum" ne "0"){
	print color("yellow") . "  [-] Config Found : $ccnum\n" . color("reset");
}

if ("$bbnum" ne "0"){
	print color("yellow") . "  [-] Backup Found : $bbnum\n" . color("reset");
}




return 1;
