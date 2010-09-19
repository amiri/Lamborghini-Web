package Lamborghini::I18N;

use strict;
use warnings;
use Encode;
use parent 'Locale::Maketext';
use Locale::Maketext::Lexicon {
    'i_default' => [ Gettext => 'i_default.po' ],
    _auto       => 1,
    _style      => 'gettext',
};

1;
