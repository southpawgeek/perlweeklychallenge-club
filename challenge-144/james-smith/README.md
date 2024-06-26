[< Previous 143](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-143/james-smith) |
[Next 145 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-145/james-smith)
# Perl Weekly Challenge #144

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-144/james-smith

# Challenge 1 - Semiprimes

***Write a script to generate all Semiprime number <= 100. (A semiprime is a number which is a multiple of two primes)***`

## The solution

Rather than looping through each number to find if it is a semiprime - instead we find all the primes and multiply these together.
We realise we need the primes up to $N/2, and so compute them. Then for each prime we push all multiples of the prime with all
the previous primes (filtering for values less than or equal to $N)

This method is faster than the loop method about 9x faster than the loop method for `$N = 10,000`.
```perl
my $N = 1000;
my @primes      = (2);
my @semi_primes = (4);

foreach my $p ( map { 1+2*$_ } 1..($N/4) ) {
  map { ($p%$_)||(next) } @primes;
  push @primes,$p;
  push @semi_primes,grep {$_<=$N} map{$p*$_} @primes;
}

say for sort {$a<=>$b} @semi_primes;
```

# Challenge 2 - Ulam Sequence

***You are given two positive numbers, `$u` and `$v`. Write a script to generate Ulam Sequence having at least 10 Ulam numbers where `$u` and `$v` are the first 2 Ulam numbers.
The standard Ulam sequence (the (1, 2)-Ulam sequence) starts with U1 = 1 and U2 = 2. Then for n > 2, Un is defined to be the smallest integer that is the sum of two distinct earlier terms in exactly one way and larger than all earlier terms.***

## The solution

For ulam numbers - we use an array and a hash to store previous ulam numbers. That allows us to quickly find those which have 1 unique partition. We do this with the grep in the 3rd line of the function. We then continue until the the array has the appropriate size. (We know there will be at least one solution the sum of the last two ulam numbers)

```perl
sub ulam {
  my%seq_hash=map{$_,$_}my@seq=($_[0],my$n=$_[1]);
  for(;scalar @seq<$_[2];++$n){
    push@seq,$seq_hash{$n}=$n if 1==grep{2*$_<$n&&$seq_hash{$n-$_}}@seq;
  }
  @seq;
}
```
