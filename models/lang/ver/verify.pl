#!/usr/bin/perl
use strict;
use Switch;

use Text::Table;

if (@ARGV < 2) { 
    die 'Not enough arguments!'  
}

my $model_file = shift @ARGV;
my $props_file = shift @ARGV;

my $model = $model_file;
$model =~ s/\.xml$//;
my $dirname = "$model.ver";


if (-e $dirname) {
   print STDERR "$dirname exists. Shall I remove it? ";
   my $ans = <STDIN>;
   if ($ans =~ m/^yes$/) {
     system('rm','-r', $dirname);
   } else {
     die "Cannot create tmp dir!";
   }
 }

 mkdir $dirname or die 'Cannot create tmp dir!';

my $now = localtime;
print "Verifying model from $model_file for properties from $props_file.\n";
print "Verification started at $now.\n\n";
print STDERR "Verifying model from $model_file for properties from $props_file.\n";


my $NORM = 0;
my $COMMENT = 1;
my $mode = $NORM;

my $propnum = 0;
my $newprop = 1;
open(PROPS, "<$props_file");
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
		       open ($fh, '>>', "$dirname/$propnum.q");
		       $newprop = 0;
		 }
		   print $fh $line;
		   if ($line !~ m/\\$/) {
		       $now = localtime;
		       print STDERR "Verifying: $propnum.$props{$propnum}{name} (started at $now)\n";
		       system("./run-ver.sh $model $propnum @ARGV") == 0 or die "Err:$?\n";
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
for my $i (sort keys %props) {
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
print $table;

sub print_ver_options {
   open (FILE, "<", "$dirname/0.ver") or die "Cannot open $dirname/0.ver";
   while(<FILE>) {
       my $line = $_;
       if ($line !~ m/^$/) {
	   print $line;
       } else {
	   last;
     }
   }
   close FILE;
   print "\n\n";
}

sub process_ver_stats($) {
    my ($num) = @_;
    open (FILE, "<", "$dirname/$num.stats") or die "Cannot open $dirname/$num.stats";
    if (`wc -l $dirname/$num.stats` =~ m/^2/) {
	my $top = <FILE>;
	my @topres = split /\s+/, $top;
	$props{$num}{virtmem} = $topres[5];
	$props{$num}{resmem} = $topres[6];
	$props{$num}{time} = $topres[11];
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
	case m/satisfied/ {$props{$num}{success} = ($line =~ m/NOT/) ? 'NO' : 'YES';}
	case m/stored/ {$line =~ m/(\d+)/; $props{$num}{stored} = $1};
	case m/explored/ {$line =~ m/(\d+)/; $props{$num}{explored} = $1};
    }
  }
  close FILE;
}
