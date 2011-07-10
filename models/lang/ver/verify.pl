#!/usr/bin/perl
use strict;
use Switch;

use Text::Table;
use File::Basename;

if (@ARGV < 2) { 
    die 'Not enough arguments!'  
}

my $model_file = shift @ARGV;
my $props_file = shift @ARGV;

die "Model should be an XML file.\n" unless $model_file =~ m/\.xml$/;
die "Queries should be a Q file.\n" unless $props_file =~ m/\.q$/;

my ($mname, $mpath, $msuf) = fileparse($model_file);
my ($pname, $ppath, $psuf) = fileparse($props_file);

my $model = $mname;
$model  =~ s/\.xml//;

my $options = "@ARGV";
$options =~ s/[- ]//g;

my $hostname = `hostname`;
chomp $hostname;
my $dirname = "$mpath$model$options-$hostname.ver";

if (-e $dirname) {
   print STDERR "$dirname exists. Shall I remove it? ";
   my $ans = <STDIN>;
   if ($ans =~ m/^yes$/) {
     system('rm','-r', $dirname);
   } else {
     die "Cannot create tmp dir!";
   }
 }

mkdir $dirname or die "Cannot create tmp dir: $dirname!";
system ("cp", "$model_file", "$props_file", "$dirname");
$model_file = "$dirname/$mname";
$props_file = "$dirname/$pname";


open(RESULTS, ">$dirname/RESULTS-$model") or die "Can't create results file.\n";

my $now = localtime;
print RESULTS "Verifying model from $model_file for properties from $props_file.\n";
print RESULTS "Verification started at $now.\n\n";
print STDERR "Verifying model from $model_file for properties from $props_file.\n";


my $NORM = 0;
my $COMMENT = 1;
my $mode = $NORM;

my $propnum = 0;
my $newprop = 1;
open(PROPS, "<$props_file") or die "Cannot open $props_file";
my $fh;
my %props = ();
while(<PROPS>) {
       my $line = $_;
       switch($line) {
	   case m|^//| {}
	   case m|^/\*| {$mode = $COMMENT}
	   case m|^\*/| {$mode = $NORM}
	   else {
	       if ($mode==$COMMENT) {
		   chomp $line;
		   $props{$propnum}{name} = $line;
	       } elsif ($line !~ m/^$/) {
		   if ($newprop) {
		       open ($fh, '>>', "$dirname/$propnum.q") or die "Cannot open $propnum.q";
		       $newprop = 0;
		 }
		   print $fh $line;
		   if ($line !~ m/\\$/) {
		       $now = localtime;
		       print STDERR "Verifying: $propnum.$props{$propnum}{name} (started at $now)\n";
		       system("./run-ver.sh",
			      "$model_file",
			      "$dirname/$propnum.q",
			      "$dirname/$propnum.ver",
			      "$dirname/$propnum.stats",
			      @ARGV) == 0 or die "Err:$?\n";
		       $now = localtime;
		       process_ver_result($propnum);
		       process_ver_stats($propnum);
		       print STDERR "\tSuccess: $props{$propnum}{success}\n";
		       print STDERR "\tTime: $props{$propnum}{time}\n";
		       print STDERR "\t(finished at $now)\n";
		       $newprop = 1;
		       $propnum++;
		   }
	       }
	   }
       }
}

my  $table = Text::Table->new("NO\n--",
			      "NAME\n----",
			      "SUCCESS\n------",
			      "TIME\n----",
			      "REALTIME    \n--------",
			      "STATES STORED\n------------",
			      "STATES EXPLORED    \n------------",
			      "VIRTUAL\n-------",
			      "RESIDENT\n--------");
for my $i (sort { $a <=> $b } keys %props) {
    $table->add($i, 
		$props{$i}{name},
		$props{$i}{success},
		$props{$i}{time},
		$props{$i}{realtime},
		$props{$i}{stored},
		$props{$i}{explored},
		$props{$i}{virtmem},
		$props{$i}{resmem}
	);
    $table->add(' ');
}
print_ver_options();
print RESULTS $table;

sub print_ver_options {
   open (FILE, "<", "$dirname/0.ver") or die "Cannot open 0.ver";
   while(<FILE>) {
       my $line = $_;
       if ($line !~ m/^$/) {
	   print RESULTS $line;
       } else {
	   last;
     }
   }
   close FILE;
   print RESULTS "\n\n";
}

sub process_ver_stats($) {
    my ($num) = @_;
    open (FILE, "<", "$dirname/$num.stats") or die "Cannot open $dirname/$num.stats";
    if (`wc -l $dirname/$num.stats` =~ m/^2/) {
	my $top = <FILE>;
	$top =~ s/^\s+//;
	my @topres = split /\s+/, $top;
	$props{$num}{virtmem} = $topres[4];
	$props{$num}{resmem} = $topres[5];
	$props{$num}{time} = $topres[10];
    } else {
	$props{$num}{virtmem} = '--';
	$props{$num}{resmem} = '--';
	$props{$num}{time} = '--';
    }
   my $time = <FILE>;
    if ($time =~ m/^(\d+)\s(\d+)\sverifyta$/) {
     $props{$num}{realtime} = $2 - $1;
    } else {
	$props{$num}{realtime} = '--';
    }
    close FILE;
}

sub process_ver_result($) {
  my ($num) = @_;
  open (FILE, "<", "$dirname/$num.ver") or die "Cannot open $dirname/$num.ver";
  while(<FILE>) {
    my $line = $_;
    use Switch;
    switch($line) {
	case m/satisfied/ {$props{$num}{success} = ($line =~ m/NOT/) ? ($line =~ m/MAY/ ? 'DK' : 'NO') : 'YES';}
	case m/stored/ {$line =~ m/(\d+)/; $props{$num}{stored} = $1};
	case m/explored/ {$line =~ m/(\d+)/; $props{$num}{explored} = $1};
    }
  }
  close FILE;
}
