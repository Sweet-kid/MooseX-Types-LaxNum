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
