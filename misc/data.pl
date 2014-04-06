#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

my $num = shift || 5;
my @label = @{ [0, 'a'..'z'] }[1..$num];

my @plot = qw(kind label min q1 med q3 max mean);
print join ",", @plot;
print "\n";

for my $k (qw(A B)) {
    for my $l (@label) {
        my $R = int( rand(40) + 20 );
        my $r = int( rand(10) );
        print join ",",
            $k,
            $l,
            $R * 1 + $r,
            $R * 2,
            $R * 3,
            $R * 4 + $r,
            $R * 5 + $r,
            $R * 3 - $r,
        ;
        print "\n";
    }
}
