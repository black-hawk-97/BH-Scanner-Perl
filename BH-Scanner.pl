#!/usr/bin/perl
# Coded By Black Hawk ^_^
# 2016/04/25  11:17 PM

use LWP::UserAgent;
use Term::ANSIColor;
use LWP::Simple;

my $url = "";
my $ou = new LWP::UserAgent;
my $tnum = "No";
my $scrt = "$ARGV[3]";

open( vernum, ">" . "Data/Version.txt");
my $vernum = <vernum>;
sub banner(){
system("cls");
print color("magenta") . '
       ____  __  __
      / __ )/ / / /
     / __  / /_/ /
    / /_/ / __  /
   /_______/ /_/         ' . "$vernum" . '  By Black Hawk
     / ___/_________ _____  ____  ___  _____
     \__ \/ ___/ __ `/ __ \/ __ \/ _ \/ ___/
    ___/ / /__/ /_/ / / / / / / /  __/ /
   /____/\___/\__,_/_/ /_/_/ /_/\___/_/
' . color("reset");

}

sub help(){
	banner();
print color("yellow") . '
   Thanks To Choose Us ^_^ , This Script Maybe Can Help You With Scanning The
   Target In The Targeting Process. The Tool Can Scan And Analysis Wordpress ,
   Joomla And vBulletin Sites. Good Luck :3

   -h | --help           To Learn How To Use This Tool.
   -a | --about          To Tell You Who Us ^_^ .
   -u | --url            To Select The Target To Scan.
   -s | --Script         To Select Installed Script On The Site.
   -p | --proxy          To Use Proxy With Scanning Process.

   Ex:   bhscanner.pl -h
         bhscanner.pl -a
         bhscanner.pl -u http://target.com/ -s WP/VB/Joom  <--  Choose One Ex: -s WP
         bhscanner.pl -u http://target.com/ -s Joom -p 127.0.0.1:8080

' . color("reset");
}



if ("@ARGV" =~ "--update"){
	banner();
	print color("green") . "\n   [~] Updating...          [ This May Take Few Minutes ] \n\n" . color("reset");

my $sREADME = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/README.md")->decoded_content;
	open sREADMETTTFILE, ">" . "README.md" or die "Cannot overwrite file: $!";
	print sREADMETTTFILE "$sREADME";
	close sREADMETTTFILE;


my $sLICENCE = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/LICENCE")->decoded_content;
	open sLICENCETTTFILE, ">" . "LICENCE" or die "Cannot overwrite file: $!";
	print sLICENCETTTFILE "$sLICENCE";
	close sLICENCETTTFILE;


my $sjjoomscanner = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/jjoomscanner.pl")->decoded_content;
	open sjjoomscannerTTTFILE, ">" . "grabber/joomscanner.pl" or die "Cannot overwrite file: $!";
	print sjjoomscannerTTTFILE "$sjjoomscanner";
	close sjjoomscannerTTTFILE;


my $svbscanner = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/vbscanner.pl")->decoded_content;
	open svbscannerTTTFILE, ">" . "grabber/vbscanner.pl" or die "Cannot overwrite file: $!";
	print svbscannerTTTFILE "$svbscanner";
	close svbscannerTTTFILE;


my $swpscanner = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/wpscanner.pl")->decoded_content;
	open swpscannerTTTFILE, ">" . "grabber/wpscanner.pl" or die "Cannot overwrite file: $!";
	print swpscannerTTTFILE "$swpscanner";
	close swpscannerTTTFILE;


my $swplist = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/wplist.txt")->decoded_content;
	open swplistTTTFILE, ">" . "grabber/wplist.txt" or die "Cannot overwrite file: $!";
	print swplistTTTFILE "$swplist";
	close swplistTTTFILE;


my $sjoomlist = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/joomlist.txt")->decoded_content;
	open sjoomlistTTTFILE, ">" . "grabber/joomlist.txt" or die "Cannot overwrite file: $!";
	print sjoomlistTTTFILE "$sjoomlist";
	close sjoomlistTTTFILE;


my $sbhscanner = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/BH-Scanner.pl")->decoded_content;
	open sbhscannerTTTFILE, ">" . "BH-Scanner.pl" or die "Cannot overwrite file: $!";
	print sbhscannerTTTFILE "$sbhscanner";
	close sbhscannerTTTFILE;

my $ver = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/Version.txt")->decoded_content;
	open sverrrTTTFILE, ">" . "Data/Version.txt" or die "Cannot overwrite file: $!";
	print sverrrTTTFILE "$ver";
	close sverrrTTTFILE;


	print color("yellow") . "   [!] Please, Run The Script Again To Apple The Updates ^_^\n" . color("reset");
	exit 0;
}







# Update Valiables
my $upreq = "";
my $whilereq = "NO";
my $up = new LWP::UserAgent;
my $upfile = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/check.txt")->decoded_content;
my $ver = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/Version.txt")->decoded_content;
open(VERSIONFILE, "<Data/Version.txt");
my $version = <VERSIONFILE>;

# Check Version
while("$whilereq" eq "NO"){
if ("$ver" =~ "$version"){
last;
}else{
banner();
print color("yellow") . "\n   [~] There Is A New Update , Do You Want To Update Now ? [Y/n] : " . color("reset");
$upreq = <STDIN>;
chomp($upreq);
}

if ("$upreq" eq "y" or "$upreq" eq "Y" or "$upreq" eq "Yes" or "$upreq" eq "yes" or "$upreq" eq "YES" or "$upreq" eq ""){
	print color("green") . "   [~] Updating... \n" . color("reset");
	$whilereq = "YES";

my $sREADME = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/README.md")->decoded_content;
if ("$upfile" =~ 'README-Update-req'){
	open sREADMETTTFILE, ">" . "README.md" or die "Cannot overwrite file: $!";
	print sREADMETTTFILE "$sREADME";
	close sREADMETTTFILE;
}

my $sLICENCE = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/LICENCE")->decoded_content;
if ("$upfile" =~ 'LICENCE-Update-req'){
	open sLICENCETTTFILE, ">" . "LICENCE" or die "Cannot overwrite file: $!";
	print sLICENCETTTFILE "$sLICENCE";
	close sLICENCETTTFILE;
}

my $sjjoomscanner = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/jjoomscanner.pl")->decoded_content;
if ("$upfile" =~ 'joomscanner-Update-req'){
	open sjjoomscannerTTTFILE, ">" . "grabber/joomscanner.pl" or die "Cannot overwrite file: $!";
	print sjjoomscannerTTTFILE "$sjjoomscanner";
	close sjjoomscannerTTTFILE;
}

my $svbscanner = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/vbscanner.pl")->decoded_content;
if ("$upfile" =~ 'vbscanner-Update-req'){
	open svbscannerTTTFILE, ">" . "grabber/vbscanner.pl" or die "Cannot overwrite file: $!";
	print svbscannerTTTFILE "$svbscanner";
	close svbscannerTTTFILE;
}

my $swpscanner = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/wpscanner.pl")->decoded_content;
if ("$upfile" =~ 'wpscanner-Update-req'){
	open swpscannerTTTFILE, ">" . "grabber/wpscanner.pl" or die "Cannot overwrite file: $!";
	print swpscannerTTTFILE "$swpscanner";
	close swpscannerTTTFILE;
}

my $swplist = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/wplist.txt")->decoded_content;
if ("$upfile" =~ 'wplist-Update-req'){
	open swplistTTTFILE, ">" . "grabber/wplist.txt" or die "Cannot overwrite file: $!";
	print swplistTTTFILE "$swplist";
	close swplistTTTFILE;
}

my $sjoomlist = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/joomlist.txt")->decoded_content;
if ("$upfile" =~ 'joomlist-Update-req'){
	open sjoomlistTTTFILE, ">" . "grabber/joomlist.txt" or die "Cannot overwrite file: $!";
	print sjoomlistTTTFILE "$sjoomlist";
	close sjoomlistTTTFILE;
}

my $sbhscanner = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/BH-Scanner.pl")->decoded_content;
if ("$upfile" =~ 'BH-Scanner-Update-req'){
	open sbhscannerTTTFILE, ">" . "BH-Scanner.pl" or die "Cannot overwrite file: $!";
	print sbhscannerTTTFILE "$sbhscanner";
	close sbhscannerTTTFILE;
}


	open sverrrTTTFILE, ">" . "Data/Version.txt" or die "Cannot overwrite file: $!";
	print sverrrTTTFILE "$ver";
	close sverrrTTTFILE;



print color("yellow") . "   [!] Please, Run The Script Again To Apple The Updates ^_^\n" . color("reset");
exit 0;

}elsif ("$upreq" eq "n" or "$upreq" eq "N" or "$upreq" eq "no" or "$upreq" eq "No" or "$upreq" eq "NO" or "$upreq" eq "nO"){
	$whilereq = "YES";

}else{
	print color("red") . "  [-] Command '$upreq' Not Found !!\n" . color("reset");
	$whilereq = "NO";

}
}



if (!defined($ARGV[0])){
	help();
	exit 1;
}

if ("$ARGV[0]" eq "-h" or "$ARGV[0]" eq "--help"){
	help();
	exit 0;
}

if ("$ARGV[0]" eq "--about"){
	about();
	exit 0;
}


if ("$ARGV[0]" eq "-u" or "$ARGV[0]" eq "--url"){
	if (defined("$ARGV[1]")){
		$url = $ARGV[1];
	}
}


if (!defined($ARGV[1])){
	help();
	print color("red") . "   [-] Please Choose The Target !!\n" . color("reset");
	exit 1;
}


if (!defined($ARGV[2])){
	help();
	print color("red") . "   [-] Please Use '-s' Option !!\n" . color("reset");
	exit 1;
}


if (!defined($ARGV[3])){
	help();
	print color("red") . "   [-] Please Type The Script Of The Site !!\n" . color("reset");
	exit 1;
}


if (defined($ARGV[4])){
	if ("$ARGV[4]" eq "-p" or "$ARGV[4]" eq "--proxy"){
		if (defined($ARGV[5])){
			$ENV{HTTP_proxy}="http://$ARGV[5]";
		}
	}
}



banner();

print color("green") . "\n   [~] Scanning Site...          [ This May Take Few Minutes ] \n" . color("reset");

if ("$scrt" eq 'VB'){
	print color("green") . "\n  [+] Target : $url\n" . color("reset");
	print color("green") . "  [+] Script : vBulletin\n" . color("reset");
require 'grabber/vbscanner.pl';
}

elsif ("$scrt" eq 'WP'){
	print color("green") . "\n  [+] Target : $url\n" . color("reset");
	print color("green") . "  [+] Script : Wordpress\n" . color("reset");
require 'grabber/wpscanner.pl';
}

elsif ("$scrt" eq 'Joom'){
require 'grabber/joomscanner.pl';
}else{
	help();
	print color("red") . "  [+] '$scrt' Is Not Support !!\n" . color("reset");
	exit 1;
}
