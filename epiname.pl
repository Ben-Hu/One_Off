#!/usr/bin/perl
# Re-name all files with names matching arg1 to format arg2_(1..n)
use Data::Dumper;
my $debug = 1;

my @files = `ls`;
print Dumper \@files if $debug;

my $match = $ARGV[0];
my $replace = $ARGV[1];

my $iter = 0;
for (@files) {
  print $_ if $debug;
  chomp($_);
  if ($_ =~ /$match/) {
    print "match: running mv $_ $replace\_$iter\n";
    my $rc = `mv $_ $replace\_$iter`;
    $iter = $iter + 1;
  }
}



