# $Id: Makefile.PL,v 1.8 2003/11/24 12:24:48 comdog Exp $
use strict;

use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'	        => 'ConfigReader::Simple',
    'VERSION_FROM'  => 'lib/ConfigReader/Simple.pm',

    'PREREQ_PM'	    => {
		'Test::More'       => '0',
		},
		                      
    clean  => { FILES => "ConfigReader-Simple-*" },

	);
