#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3846;
use blib;
use jsFind;

BEGIN { use_ok('jsFind'); }

my @base62 = qw(
0 1 2 3 4 5 6 7 8 9
a b c d e f g h i j k l m n o p q r s t u v w x y z
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
);

my @nr;

diag "generating test base62 numbers";

foreach my $l (@base62) {
	foreach my $r (@base62) {
		if ($l eq '0') {
			push @nr, $r;
		} else {
			push @nr, $l.$r;
		}
	}
}

cmp_ok(scalar @nr, '==', 3844, "generated 3844 numbers");

my $i = 0;
foreach my $nr (@nr) {
	cmp_ok($nr, 'eq', jsFind::Node::base62(undef,$i),"base62($i) == $nr");
	$i++;
}
