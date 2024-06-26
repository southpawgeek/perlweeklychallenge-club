#!/usr/bin/env perl
# Perl weekly challenge 147
# Task 2: pentagon numbers
#
# See https://wlmb.github.io/2022/01/10/PWC147/#task-2-pentagon-numbers
use v5.12;
use warnings;
use POSIX qw(floor);
use Time::HiRes qw(time);

die "Usage: ./ch-2.pl largest_index\n" unless @ARGV==1;
my $N=shift;
my $start=time();
use integer;
J:
    foreach my $j(2..$N){
        my $p=$j*(3*$j-1)/2;
        foreach my $k(1..$j-1){
            my $q=$k*(3*$k-1)/2;
            say("p$j=$p\np$k=$q\np$j-p$k=", $p-$q, "=p", index_of($p-$q),
                  "\np$j+p$k=", $p+$q, "=p", index_of($p+$q)),
                last J if pentagonal($q+$p) && pentagonal($p-$q);
        }
}
no integer; # don't truncate time
say "Time: ", time()-$start;
use integer;
sub pentagonal {
    my $p=24*shift()+1;
    my $s=floor(sqrt($p));
    return $s**2==$p && $s%6==5;
}
sub index_of {
    my $p=24*shift()+1;
    my $s=sqrt($p);
    return ($s+1)/6;
}
