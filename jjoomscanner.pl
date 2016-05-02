use LWP::UserAgent;
use Term::ANSIColor;
use LWP::Simple;

my $url = $ARGV[1];
my $ou = new LWP::UserAgent;
my $file = "grabber/joomlist.txt";
my $vnum = "0";
my $nvnum = "0";
my $url2 = "";
my $zx = LWP::UserAgent->new;
$zx->agent("Mozilla/8.0");
open(j,"<$file") or die "$!";


banner();
print color("green") , "\n   [+] Scanning...          [ This May Take Few Minutes ] \n" , color("reset");


# Delete / In The Last Of The URL If Exist.
if (chop($url) ne "/"){
	$url = "$url/";
}


# Create Result File
if ("$url" =~ "https://"){
	$url2 = substr($url, 8);
	if ("$url2" =~ "www"){
	$urlf = substr($url2, 4);
	}else{
	$urlf = substr($url, 8);
	}
}elsif ("$url" =~ "http://"){
	$url2 = substr($url, 7);
	if ("$url2" =~ "www"){
	$urlf = substr($url2, 4);
	}else{
	$urlf = substr($url, 7);
	}
}
my $surl = "$urlf";
$surl =~ s/\///g;
my $htmlfile = $ou->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/htmlfile.txt")->decoded_content;
chomp($surl);
open (FFFF, '>' , "Result/$surl.html");
print FFFF "$htmlfile";
close FFFF;



	print color("yellow") , "\n   [!] Started At : " . ctime() . color("reset");
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
	print color("green") , "\n   [+] Script-Type : Joomla\n" . color("reset");
	print color("green") , "   [+] Joomla Version Detected : $version\n" , color("reset");
}else{
	print color("green") , "\n   [+] Script : Joomla\n" . color("reset");
	print "   " , color("on_red") , "[-] Joomla Version Cannot Be Detected !!\n" , color("reset");
}





	# Check Headers Valiables
	my $cleartext = $ou->get($url);
	my $headersss = $cleartext->headers_as_string;
	my $headerpow = $cleartext->headers_as_string;
	my $headerser = $cleartext->headers_as_string;
	$headerpow =~ m/X-Powered-By: (.*)/;
	# grep Some Headers
	if ("$headerpow" eq ""){
	print "   " , color("on_red") , "[-] Cannot Detect X-Powered-By !!\n" . color("reset");
	}else{
	print color("green") , "   [+] X-Powered-By : $1\n" . color("reset");
	}

	$headerser =~ m/Server: (.*)/;
	if ("$headerser" eq ""){
	print "   " , color("on_red") , "[-] Cannot Detect Server Name !!\n" . color("reset");
	}else{
	print color("green") , "   [+] Server : $1\n" . color("reset");
	}


	if ( "$headersss" =~ "Set-Cookie:"){
		print color("green") , "   [+] Passwords Are Passing Through None-Encrypt HTTP [You Can Sniffing Users Password].\n" . color("reset");
	}else{
		print "   " , color("on_red") , "[-] The Passwords Are Passing Through Encrypt Channel.\n" . color("reset");
	}


	# Check Firewall Status
	if (head("$url/components/com_rsfirewall/") or head("$url/components/com_firewall/")){
		print "   " , color("on_red") , "[!] RS-Firewall Firewall Detected\n" . color("reset");
		print "     " , color("yellow") , "-  Your Scanning Process Maybe Will Be Loged And Protected.\n" . color("reset");		
	}else{
		print color("green") , "   [+] RS-Firewall Does Not Found.\n" . color("reset");
	}
	# Check Firewall2 Status
	if (head("$url/components/com_jfw/") or head("$url/components/com_jfirewall/")){
		print "   " , color("on_red") , "[!] J-Firewall Firewall Detected\n" . color("reset");
		print "     " , color("yellow") , "-  Your Scanning Process Maybe Will Be Loged And Protected.\n" . color("reset");		
	}else{
		print color("green") , "   [+] J-Firewall Does Not Found.\n" . color("reset");
	}
	# Check Firewall3 Status
	if (head("$url/modules/mod_securelive/") or head("$url/components/com_securelive/")){
		print "   " , color("on_red") , "[!] (Mod_SecureLive/Com_SecureLive) Firewall Detected\n" . color("reset");
		print "     " , color("yellow") , "-  Your Scanning Process Maybe Will Be Loged And Protected.\n" . color("reset");		
	}else{
		print color("green") , "   [+] (Mod_SecureLive/Com_SecureLive) Does Not Found.\n" . color("reset");
	}
	# Check Firewall4 Status
	my $sourcehrad = $ou->get("$url")->decoded_content;
	if (head("$url/init.php") or head("$url/firewall.php") or head("$url/fsAdmin/") or head("$url/fsAdmin/") or head("$url/fsadmin/") or "$sourcehrad" =~ /<div id='fws\-copyright'><a href='http:\/\/firewallscript\.com'>Protected by FireWall Script<\/a><\/div>/){
		print "   " . color("on_red") , "[!] SecureLive Firewall Detected\n" . color("reset");
		print "     " . color("yellow") , "-  Your Scanning Process Maybe Will Be Loged And Protected.\n" . color("reset");		
	}else{
		print color("green") , "   [+] SecureLive Does Not Found.\n" . color("reset");
	}
	# Check Firewall5 Status
	if (head("$url/plugins/system/jsecure.xml") or head("$url/plugins/system/jsecure.php")){
		print "   " , color("on_red") , "[!] jSecure Authentication Detected\n" . color("reset");
		print "     " , color("yellow") , "-  You need additional secret key to access /administrator directory.\n" . color("reset");		
		print "     " , color("yellow") , "-  Default is jSecure like /administrator/?jSecure ;)\n" . color("reset");		
	}else{
		print color("green") , "   [+] jSecure Authentication Does Not Found.\n" . color("reset");
	}
	# Check Firewall6 Status
	if (head("$url/components/com_guardxt/") or head("$url/administrator/components/com_guardxt/")){
		print "   " , color("on_red") , "[!] GuardXT Security Component Detected\n" . color("reset");
		print "     " , color("yellow") , "-  It Is Likely That Webmaster Routinely Checks For Insecurities.\n" . color("reset");		
	}else{
		print color("green") , "   [+] GuardXT Security Component Does Not Found.\n" . color("reset");
	}
	# Check Firewall7 Status
		my $sourcefire7 = $ou->get ("$url/?tell_me_if_antihacker_exist=1%20and%201=2")->decoded_content;
		my $sourcefire27 = $ou->get("$url/index.php?option=com_phpantihacker")->decoded_content;
	if ("$sourcefire7" =~ /Banned:\ssuspicious\shacking\sbehaviour/gi or "$sourcefire27" =~ /Banned:\ssuspicious\shacking\sbehaviour/gi){
		print "   " , color("on_red") , "[!] Anti-Hacker Joomla Component Detected\n" . color("reset");
		print "     " , color("yellow") , "-  The vulnerability probing may be denied.\n" . color("reset");		
	}else{
		print color("green") , "   [+] Anti-Hacker Joomla Component Does Not Found.\n" . color("reset");
	}
	# Check Firewall8 Status
	if (head("$url/components/com_jdefender/") or head("$url/administrator/components/com_jdefender/") or head("$url/administrator/language/en-GB/en-GB.com_jdefender.ini")){
		print "   " , color("on_red") , "[!] Joomla! JoomSuite Defender Detected\n" . color("reset");
		print "     " , color("yellow") , "-  The vulnerability probing may be logged and protected.\n" . color("reset");		
	}else{
		print color("green") , "   [+] Joomla! JoomSuite Defender Does Not Found.\n" . color("reset");
	}
	# Check Firewall10 Status
	if (head("$url/components/com_securityscan/") or head("$url/administrator/components/com_securityscanner/") or head("$url/components/com_securityscanner/")){
		print "   " , color("on_red") , "[!] security scanner (com_securityscanner/com_securityscan) Detected\n" . color("reset");
	}else{
		print color("green") , "   [+] security scanner (com_securityscanner/com_securityscan) Does Not Found.\n" . color("reset");
	}
	# Check Firewall11 Status
	if (head("$url/components/com_joomscan/") or head("$url/administrator/components/com_joomscan/") or head("$url/administrator/components/com_joomlascan/") or head("$url/components/com_joomlascan/")){
		print "   " , color("on_red") , "[!] Joomla! security scanner (com_joomscan/com_joomlascan) Detected\n" . color("reset");
		print "     " , color("yellow") , "-  It Is Likely That Webmaster Routinely Checks For Insecurities.\n" . color("reset");		
	}else{
		print color("green") , "   [+] Joomla! security scanner (com_joomscan/com_joomlascan) Does Not Found.\n" . color("reset");
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
	print "   " , color("on_red") , "[-] Htaccess File Not Avalible Or Not Readable !!\n" , color("reset");
}
	


	# Admin Panel Finder
	my $srobots = $ou->get("$url/robots.txt")->decoded_content;
	if (head("$url/robots.txt") or "$srobots" =~ "User-agent:" or "$srobots" =~ "User-agent:" or "$srobots" =~ "Disallow:"){
	print color("green") , "   [+] Robots File Found At : $url/robots.txt\n" . color("reset");
	$htnum = $htnum + 1;
	}
	if (head("$url/administrator")){
	print color("green") , "   [+] Admin Panel Found At : $url/administrator/\n" . color("reset");
	print color("yellow") , "    -  The Attacker Can Do Bruteforce Attack Easly\n" . color("reset");	
	$htnum = $htnum + 1;
	}
	elsif (head("$url/admin")){
	print color("green") , "   [+] Admin Panel Found At : $url/admin/\n" . color("reset");
	print color("yellow") , "    -  The Attacker Can Do Bruteforce Attack Easly\n" . color("reset");	
	$htnum = $htnum + 1;
	}
	elsif (head("$url/manage")){
	print color("green") , "   [+] Admin Panel Found At : $url/manage/\n" . color("reset");
	print color("yellow") , "    -  The Attacker Can Do Bruteforce Attack Easly\n" . color("reset");	
	$htnum = $htnum + 1;
	}else{
	print "   " , color("on_red") , "[-] Admin Panel Not Found !!\n" . color("reset");
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


open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "$fl2" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "$tl2" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "$sl2" . '</font></b><br><br>' . "\n";
close FOFO;

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

	my $joomua = LWP::UserAgent->new;
    $joomua->agent("Mozilla/8.0");	# Pretend to be Mozilla

    my $joomreq = HTTP::Request->new(GET => "$url$fl2");
    my $joomres = $joomua->request($joomreq);

if ($joomres->is_success){
	print color("yellow") , "   [+] Vuln. Plugin     : $fl2\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : $tl2\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : $sl2\n\n" , color("reset");


open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "$fl2" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "$tl2" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "$sl2" . '</font></b><br><br>' . "\n";
close FOFO;


	$vnum = $vnum + 1;
}

	$nvnum = $nvnum + 1;
}




# Search By Version
if ("$version" != ""){


if ("$version" eq "1.5" or "$version" eq "1.6" or "$version" eq "1.7" or "$version" eq "3.0" or "$version" eq "3.1" or "$version" eq "3.2" or "$version" eq "3.3" or "$version" eq "3.4" or "$version" =~ "1.5." or "$version" =~ "1.6." or "$version" =~ "1.7." or "$version" =~ "3.0." or "$version" =~ "3.1." or "$version" =~ "3.2." or "$version" =~ "3.3." or "$version" =~ "3.4." or "$version" =~ "3.4.5"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Object Injection RCE X-Forwarded-For Header\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1Zp9YU\n\n" , color("reset");
open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable In : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : Object Injection RCE X-Forwarded-For Header</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : http://adf.ly/1Zp9YU</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" eq "3.2" or "$version" =~ "3.2." or "$version" =~ "3.3." or "$version" =~ "3.4." or "$version" =~ "3.3" or "$version" =~ "3.4"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : SQL-Injection\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1ZpAKy\n\n" , color("reset");
open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "SQL-Injection" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "http://adf.ly/1ZpAKy" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.0"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Cross Site Scripting\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1Zztjv\n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "Cross Site Scripting" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "http://adf.ly/1Zztjv" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.5.21"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : SQL-Injection\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1ZzuYu\n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "SQL-Injection" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "http://adf.ly/1ZzuYu" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.5.20"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Cross Site Scripting\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1Zzubt\n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "Cross Site Scripting" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "http://adf.ly/1Zzubt" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.7.0"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Cross Site Scripting\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1Zzufw\n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "Cross Site Scripting" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "http://adf.ly/1Zzufw" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.6.4" or "$version" =~ "1.6." or "$version" =~ "1.6" or "$version" =~ "1.5" or "$version" =~ "1.4" or "$version" =~ "1.3" or "$version" =~ "1.2" or "$version" =~ "1.1" or "$version" =~ "1.0" or "$version" =~ "1.0."){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Cross Site Scripting\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1Zzuq5\n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "Cross Site Scripting" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "http://adf.ly/1Zzuq5" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.6.0"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : SQL-Injection\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1Zzutc\n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "SQL-Injection" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "http://adf.ly/1Zzutc" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.6.0"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Disclosure/Full Path Disclosure Vulnerability\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1ZzuxB\n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "Disclosure/Full Path Disclosure Vulnerability" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "http://adf.ly/1ZzuxB" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.6.0"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Cross Site Scripting\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1Zzv1e\n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "Cross Site Scripting" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "http://adf.ly/1Zzv1e" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}


if ("$version" =~ "1.7.0"){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Cross Site Scripting\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : http://adf.ly/1Zzv5b\n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "Cross Site Scripting" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "http://adf.ly/1Zzv5b" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.5.9" and head("$url/components/com_content/")){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Cross Site Scripting\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : A XSS vulnerability exists in the category view of com_content. \n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "Cross Site Scripting" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "A XSS vulnerability exists in the category view of com_content. " . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.5.10" and head("$url/components/com_users/")){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : Cross Site Scripting\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : A XSS vulnerability exists in the user view of com_users in the administrator panel. \n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "Cross Site Scripting" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "A XSS vulnerability exists in the user view of com_users in the administrator panel. " . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}

if ("$version" =~ "1.5.0" and head("$url/administrator/components/com_installer")){
	print color("yellow") , "   [+] Vulnerable In    : V$version\n" , color("reset");
	print color("yellow") , "   [+] Vulnerable With  : CSRF\n" , color("reset");
	print color("yellow") , "   [+] Exploit          : N/A \n\n" , color("reset");

open(FOFO , '>>' , "Result/$surl.html") or die "$!";
print FOFO '<b><font color="green" size="4">URL : ' . "$url" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable Plugin : ' . "V$version" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Vulnerable With : ' . "CSRF" . '</b></font><br>' . "\n";
print FOFO '<b><font color="green" size="4">Exploit : ' . "N/A" . '</font></b><br><br>' . "\n";
close FOFO;
	$vnum = $vnum + 1;
}
# Add Here The Version Vulnerability
}


# Backup Finder Request ^_^
my $bbnum = "0";
my $backreqq = "No";
while ("$backreqq" eq "No"){
print color("cyan") . "\n  [~] Do You Want To Start Backup-Finder ? [Y/n] : " . color("reset");
my $backreq = <STDIN>;
chomp($backreq);
if ("$backreq" eq "y" or "$backreq" eq "Y" or "$backreq" eq "Yes" or "$backreq" eq "yes" or "$backreq" eq "YES" or "$backreq" eq ""){
	$backreqq = "Yes";
@conbfigs = ('site.zip' , 'site.tar.gz' , 'site.tar' , 'site.rar' , 'wp.zip' , 'wp.tar' , 'wp.gzip' , 'wp.tar.gz' , 'wp.deb' , 'joomla.zip' , 'joomla.gzip' , 'joomla.tar' , 'joomla.rar' , 'joomla.tar.gz' , 'joomla.zip~' , 'wp.zip~' , 'database.zip' , 'wp.sql~' , 'wp.sql' , 'site.sql' , "$surl.zip" , "$surl.sql" , "$surl.tar" , "$surl.tar~" , "$surl.tar.gz" , "$surl.tar.gz~" , 'db.txt' , '/backup.tar.gz', '/backup/backup.tar.gz', '/backup/backup.zip', '/vb/backup.zip', '/site/backup.zip', '/backup.zip', '/backup.rar', '/backup.sql', '/vb/vb.zip', '/vb.zip', '/vb.sql', '/vb.rar', '/vb1.zip', '/vb2.zip', '/vbb.zip', '/vb3.zip', '/upload.zip', '/up/upload.zip', '/joomla.sql', '/wordpress.zip', '/wp/wordpress.zip', '/blog/wordpress.zip', '/wordpress.rar' , 'backup.zip','upload.zip','vb.zip','forum.zip','forum.tar','forum.tar.gz','backup.tar.gz','2.zip','1.zip','database.zip','sql.zip','backup.sql','database.sql','db.sql','site.sql','DB.sql','Database.sql','db.zip','1.sql','Database.zip');
foreach my $backjup (@conbfigs){

if ($ou->get("$url/$backjup")->decoded_content =~ "file does not exist"){
	my $skjdfhsdjkf = "sdajkfh";
}else{

    my $backbackua = LWP::UserAgent->new;
    $backbackua->agent("Mozilla/8.0");	# Pretend to be Mozilla
    my $backbackreq = HTTP::Request->new(GET => "$url/$backjup");
    my $backbackres = $backbackua->request($backbackreq);

    if ($backbackres->is_success) {
    print color("yellow") . "\a    - File Found : $url/$backjup\n" . color("reset");
    $bbnum = $bbnum + 1;
    }
}
}
if ("$bbnum" eq "0"){
	print "      " . color("on_red") . "[-] Not Found Any Backup File !!\n" . color("reset");
}
}elsif ("$backreq" eq "n" or "$backreq" eq "N" or "$backreq" eq "no" or "$backreq" eq "No" or "$backreq" eq "NO" or "$backreq" eq "nO"){
		$backreqq = "Yes";
	print "\n";
	}else{
		print "      " . color("on_red") . "[-] Command '$backreq' Not Found !!\n" . color("reset");
		$backreqq = "No";
	}
}






# Config Finder Request ^_^
my $ccnum = "0";
my $conreqq = "No";
while ("$conreqq" eq "No"){
print color("cyan") . "\n  [~] Do You Want To Start Config-Finder ? [Y/n] : " . color("reset");
my $conreq = <STDIN>;
chomp($conreq);
if ("$conreq" eq "y" or "$conreq" eq "Y" or "$conreq" eq "Yes" or "$conreq" eq "yes" or "$conreq" eq "YES" or "$conreq" eq ""){
	$conreqq = "Yes";
@cnconfigs = ('configuration.php' , 'wp-config.php' , 'wp-config.php~' , 'configuration.php~' , 'configuration.php.new' , 'configuration.php.new~' , 'config.php~','config.php.new','config.php.new~','config.php.old','config.php.old~','config.bak','config.php.bak','config.php.bkp','config.txt','config.php.txt','config - Copy.php');
foreach $cnconfig(@cnconfigs){
    $sourcsse=$ou->get("$url/$cnconfig")->decoded_content;
    my $confua = LWP::UserAgent->new;
    $confua->agent("Mozilla/8.0");	# Pretend to be Mozilla
    my $confreq = HTTP::Request->new(GET => "$url/$cnconfig");
    my $confres = $confua->request($confreq);
    if($confres->is_success){
    if ($sourcsse =~ m/DB_NAME/i || $sourcsse =~ m/define/i || $sourcsse =~ m/\'\)\;/i || $sourcsse =~ m/\"\)\;/i){
    	print color("yellow") . "\a    - Config File Path : $url/includes/$cnconfig\n" . color("reset");
    	$ccnum = $ccnum + 1;
    }
}
}
if ("$ccnum" eq "0"){
	print "      " . color("on_red") . "[-] Not Found Config File !!\n" . color("reset");
}

}elsif ("$conreq" eq "n" or "$conreq" eq "N" or "$conreq" eq "no" or "$conreq" eq "No" or "$conreq" eq "NO" or "$conreq" eq "nO"){
		$conreqq = "Yes";
	print "\n";
	}else{
		print "      " . color("on_red") . "[-] Command '$conreq' Not Found !!\n" . color("reset");
		$conreqq = "No";
	}
}


# Shell Finder Request ^_^
my $scnum = "0";
my $shreqq = "No";
while ("$shreqq" eq "No"){
print color("cyan") . "\n  [~] Do You Want To Start Shell-Finder ? [Y/n] : " . color("reset");
my $shreq = <STDIN>;
chomp($shreq);
if ("$shreq" eq "y" or "$shreq" eq "Y" or "$shreq" eq "Yes" or "$shreq" eq "yes" or "$shreq" eq "YES" or "$shreq" eq ""){
	$shreqq = "Yes";
@shells = ('c99.php' , '.c99.php' , 'wos.php' , 'wso.php' , '.wos.php' , '.wso.php' , '.r57.php' , 'r57.php' , 'sql.php' , '.sql.php' , 'shell.php' , '.shell.php');
foreach $shell(@shells){

	my $shshua = LWP::UserAgent->new;
    $shshua->agent("Mozilla/8.0");	# Pretend to be Mozilla
    my $shshreq = HTTP::Request->new(GET => "url/$shell");
    my $shshres = $shshua->request($shshreq);

    if($shshres->is_success){
    	print color("yellow") . "\a    - Shell File Path : $url/$shell\n" . color("reset");
    	$scnum = $scnum + 1;
    }
}
if ("$scnum" eq "0"){
	print "      " . color("on_red") . "[-] Not Found Any Shell File !!\n" . color("reset");
}

}elsif ("$shreq" eq "n" or "$shreq" eq "N" or "$shreq" eq "no" or "$shreq" eq "No" or "$shreq" eq "NO" or "$shreq" eq "nO"){
		$shreqq = "Yes";
	print "\n";
	}else{
		print "      " . color("on_red") . "[-] Command '$shreq' Not Found !!\n" . color("reset");
		$shreqq = "No";
	}
}





# Subdomain Finder Request ^_^
my $bsubnum = "0";
my $subreqq = "No";
if ("$url" =~ "https://"){
	$url2 = substr($url, 8);
	if ("$url2" =~ "www"){
	$urlf = substr($url2, 4);
	}else{
	$urlf = substr($url, 8);
	}
}elsif ("$url" =~ "http://"){
	$url2 = substr($url, 7);
	if ("$url2" =~ "www"){
	$urlf = substr($url2, 4);
	}else{
	$urlf = substr($url, 7);
	}
}
while ("$subreqq" eq "No"){
print color("cyan") . "\n  [~] Do You Want To Start Subdomain-Finder ? [Y/n] : " . color("reset");
my $subreq = <STDIN>;
chomp($subreq);
if ("$subreq" eq "y" or "$subreq" eq "Y" or "$subreq" eq "Yes" or "$subreq" eq "yes" or "$subreq" eq "YES" or "$subreq" eq ""){
	$subreqq = "Yes";
@subconfigs = ("www." , "about.", "abose.", "acme.", "ad.", "admanager.", "admin.", "admins.", "administrador.", "administrateur.", "administrator.", "ads.", "adsense.", "adult.", "adwords.", "affiliate.", "affiliatepage.", "afp.", "analytics.", "android.", "shop.", "echop.", "blog.", "tienda.", "answer.", "ap.", "api.", "apis.", "app.", "bank.", "blogs.", "client.", "clients.", "community.", "content.", "cpanel.", "dashbord.", "data.", "developer.", "developers.", "dl.", "docs.", "documents.", "download.", "downloads.", "encrypted.", "email.", "webmail.", "mail.", "correo.", "ftp.", "forum.", "forums.", "feed.", "feeds.", "file.", "files.", "gov.", "home.", "help.", "invoice.", "invoises.", "items.", "js.", "es.", "it.", "en.", "fr.", "ar.", "legal.", "iphone.", "lab.", "labs.", "list.", "lists.", "log.", "logs.", "errors.", "net.", "mysql.", "mysqldomain.", "net.", "network.", "news.", "ns.", "ns1.", "ns2.", "ns3.", "ns4.", "ns5.", "org.", "panel.", "partner.", "partners.", "pop.", "pop3.", "private.", "proxies.", "public.", "reports.", "root.", "rss.", "prod.", "prods.", "sandbox.", "search.", "server.", "servers.", "signin.", "signup.", "login.", "smtp.", "srntp.", "ssl.", "soap.", "stat.", "statics.", "store.", "status.", "survey.", "sync.", "system.", "text.", "test.", "webadmin.", "webdisk.", "xhtml.", "xhtrnl.", "xml.");
foreach my $subdodo (@subconfigs){
	my $srt = $ou->get('http://' . "$subdodo$urlf")->decoded_content;
    if (head('http://' . "$subdodo$urlf")) {
    	if ("$srt" =~ "Access denied." or "$srt" =~ "404 Not Found"){
    		my $rjdskhfg = "dfgjshd";
    		}else{
    print color("yellow") . "\a   -  Subdomain Found : $subdodo$urlf\n" . color("reset");
    $bsubnum = $bsubnum + 1;
}
    }
}
if ("$bsubnum" eq "0"){
	print "      " . color("on_red") . "[-] Not Found Any Subdomain !!\n" . color("reset");
}
}elsif ("$subreq" eq "n" or "$subreq" eq "N" or "$subreq" eq "no" or "$subreq" eq "No" or "$subreq" eq "NO" or "$subreq" eq "nO"){
		$subreqq = "Yes";
	print "\n";
	}else{
		print "      " . color("on_red") . "[-] Command '$subreq' Not Found !!\n" . color("reset");
		$subreqq = "No";
	}
}


# Upload Files Finder Request ^_^
my $supum = "0";
my $supupreqq = "No";
while ("$supupreqq" eq "No"){
print color("cyan") . "\n  [~] Do You Want To Start Shell-Finder ? [Y/n] : " . color("reset");
my $suprreq = <STDIN>;
chomp($suprreq);
if ("$suprreq" eq "y" or "$suprreq" eq "Y" or "$suprreq" eq "Yes" or "$suprreq" eq "yes" or "$suprreq" eq "YES" or "$suprreq" eq ""){
	$supupreqq = "Yes";
@uploadsp = ("/up.php", "/up1.php", "up/up.php", "/site/up.php", "/vb/up.php", "/forum/up.php", "/blog/up.php", "/upload.php", "/upload1.php", "/upload2.php", "/vb/upload.php", "/forum/upload.php", "blog/upload.php", "site/upload.php", "download.php");
foreach $ups(@uploadsp){

    my $upupua = LWP::UserAgent->new;
    $upupua->agent("Mozilla/8.0");	# Pretend to be Mozilla
    my $upupreq = HTTP::Request->new(GET => "$url/$ups");
    my $upupres = $upupua->request($upupreq);

    if($upupres->is_success){
    	print color("yellow") . "\a    - Upload File Path : $url/$ups\n" . color("reset");
    	$supum = $supum + 1;
    }
}
if ("$supum" eq "0"){
	print "      " . color("on_red") . "[-] Not Found Any Upload File !!\n" . color("reset");
}

}elsif ("$suprreq" eq "n" or "$suprreq" eq "N" or "$suprreq" eq "no" or "$suprreq" eq "No" or "$suprreq" eq "NO" or "$suprreq" eq "nO"){
		$supupreqq = "Yes";
	print "\n";
	}else{
		print "      " . color("on_red") . "[-] Command '$suprreq' Not Found !!\n" . color("reset");
		$supupreqq = "No";
	}
}








if ("$vnum" eq "0"){
	print color("yellow") , "\n  [!] Exploit Tested   : $nvnum\n" , color("reset");
	print "  " . color("on_red") . "[-] Sorry Not Found." , color("reset");
}else{
	print color("yellow") , "\n  [!] Exploit Tested   : $nvnum\n" , color("reset");
	print color("yellow") , "  [!] Exploit Found    : $vnum\n" , color("reset");
}
if ("$scnum" ne "0"){
	print color("yellow") . "  [-] Shell Found      : $scnum\n" . color("reset");
}

if ("$ccnum" ne "0"){
	print color("yellow") . "  [-] Config Found     : $ccnum\n" . color("reset");
}

if ("$bbnum" ne "0"){
	print color("yellow") . "  [-] Backup Found     : $bbnum\n" . color("reset");
}

if ("$bsubnum" ne "0"){
	print color("yellow") . "  [-] Subdomain Found  : $bsubnum\n" . color("reset");
}


if ("$supum" ne "0"){
	print color("yellow") . "  [-] Upload Found     : $supum\n" . color("reset");
}


return 1;
