#!/usr/bin/perl
# Goooooooooooood ^_^
use LWP::UserAgent;
use Term::ANSIColor;
use LWP::Simple;

my $url = "";
my $ou = new LWP::UserAgent;
my $tnum = "No";
my $scrt = "$ARGV[3]";


sub banner(){
system("cls");
print color("magenta") . '
       ____  __  __
      / __ )/ / / /
     / __  / /_/ /
    / /_/ / __  /
   /_______/ /_/               By Black Hawk
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


# Update Valiables
my $upreq = "";
my $whilereq = "0";
my $up = new LWP::UserAgent;
my $upfile = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/check.txt")->decoded_content;
my $ver = $up->get("https://raw.githubusercontent.com/black-hawk-97/BH-Scanner-Perl/master/Version.txt")->decoded_content;
open(VERSIONFILE, "<Data/Version.txt");
my $version = <VERSIONFILE>;

# Check Version
while("$whilereq" eq "0"){
if ("$ver" =~ "$version"){
print color("yellow") . "   [~] There Is A New Update , Do You Want To Update Now ? [Y/n] : " . color("reset");
$upreq = <STDIN>;
chomp($upreq);
}

if ("$upreq" eq "y" or "$upreq" eq "Y" or "$upreq" eq "Yes" or "$upreq" eq "yes" or "$upreq" eq "YES" or "$upreq" eq ""){
	print color("green") . "   [~] Updating... \n" . color("reset");



if ("$upfile" =~ 'README-Update-req'){
	open TTTFILE, ">" . "README.md" or die "Cannot overwrite file: $!";
	print TTTFILE "Whatesdfsdver";
	close TTTFILE;
}

if ("$upfile" =~ 'LICENCE-Update-req'){
	open TTTFILE, ">" . "grabber/tt.txt" or die "Cannot overwrite file: $!";
	print TTTFILE "Whatesdfsdver";
	close TTTFILE;
}

if ("$upfile" =~ 'joomscanner-Update-req'){
	open TTTFILE, ">" . "grabber/joomscanner.pl" or die "Cannot overwrite file: $!";
	print TTTFILE "Whatesdfsdver";
	close TTTFILE;
}

if ("$upfile" =~ 'vbscanner-Update-req'){
	open TTTFILE, ">" . "grabber/vbscanner.pl" or die "Cannot overwrite file: $!";
	print TTTFILE "Whatesdfsdver";
	close TTTFILE;
}

if ("$upfile" =~ 'wpscanner-Update-req'){
	open TTTFILE, ">" . "grabber/wpscanner.pl" or die "Cannot overwrite file: $!";
	print TTTFILE "Whatesdfsdver";
	close TTTFILE;
}

if ("$upfile" =~ 'wplist-Update-req'){
	open TTTFILE, ">" . "grabber/wplist.txt" or die "Cannot overwrite file: $!";
	print TTTFILE "Whatesdfsdver";
	close TTTFILE;
}

if ("$upfile" =~ 'joomlist-Update-req'){
	open TTTFILE, ">" . "grabber/joomlist.txt" or die "Cannot overwrite file: $!";
	print TTTFILE "Whatesdfsdver";
	close TTTFILE;
}

if ("$upfile" =~ 'BH-Scanner-Update-req'){
	open TTTFILE, ">" . "BH-Scanner.pl" or die "Cannot overwrite file: $!";
	print TTTFILE "Whatesdfsdver";
	close TTTFILE;
}




}elsif ("$upreq" eq "n" or "$upreq" eq "N" or "$upreq" eq "no" or "$upreq" eq "No" or "$upreq" eq "NO" or "$upreq" eq "nO"){
	$whilereq = "YES";
}else{
	print color("red") . "  [-] Command '$upreq' Not Found !!\n" . color("reset");
	$whilereq = "No";
}
}



exit 0;











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

print color("green") . "\n   [~] Scanning Site...\n" . color("reset");

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
