# $Id: Makefile.PL,v 1.7 2003/03/23 21:51:38 petdance Exp $
use strict;

use ExtUtils::MakeMaker;

eval "use Test::Pod";

if ( $@ || ($Test::Pod::VERSION <= '0.95') ) {
    warn "Test::Pod 0.95 is not installed, so we'll skip the POD tests.\n";
}

WriteMakefile(
    'NAME'	    => 'ConfigReader::Simple',
    'VERSION_FROM'  => 'lib/ConfigReader/Simple.pm',

    'PREREQ_PM'	    => {
		'Test::More'       => '0',
		},
		                      
    clean  => { FILES => "ConfigReader-Simple-*" },

);

1;
