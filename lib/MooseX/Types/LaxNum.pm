package MooseX::Types::LaxNum;

use strict;
use warnings;

use Moose::Util::TypeConstraints;
use Scalar::Util qw( looks_like_number );

my $value_type = Moose::Util::TypeConstraints::find_type_constraint('Value');
subtype 'LaxNum'
    => as 'Str'
    => where { Scalar::Util::looks_like_number($_) }
=> inline_as {
    # the long Str tests are redundant here
    $value_type->_inline_check($_[1])
	. ' && Scalar::Util::looks_like_number(' . $_[1] . ')'
};

1;

__END__

=head1 NAME

MooseX::Types::LaxNum

=head1 SYNOPSIS

   #!/usr/bin/env perl

   use strict;
   use warnings;

   package Foo {
       use Moose;
       use MooseX::Types::LaxNum;

       has 'laxnum', is => 'rw', isa => 'LaxNum';
   }

   my $foo = Foo->new( laxnum => '1234' );

=head1 DESCRIPTION

C<LaxNum> accepts everything for which L<Scalar::Util/looks_like_number> return true. It can be used to get the old behaviour of C<Moose::Util::TypeConstraints::Num>, since Num has been changed to be more strict. 

=head1 AUTHOR

Upasana Shuka, C<me@upasana.me>

=head1 COPYRIGHT & LICENSE

Copyright 2013 Upasana Shukla.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
