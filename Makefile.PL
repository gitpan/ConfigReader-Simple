# $Id: Makefile.PL,v 1.12 2007/01/10 03:57:20 comdog Exp $
use strict;

use ExtUtils::MakeMaker;

eval "use Test::Manifest 1.14";
	
WriteMakefile(
    'NAME'	        => 'ConfigReader::Simple',
    'VERSION_FROM'  => 'lib/ConfigReader/Simple.pm',
	'LICENSE'       => 'perl',

    'PREREQ_PM'	    => {
		'Test::More'       => '0',
		'Test::Warn'       => '0',
		},
		                      
	'MAN3PODS' => {
		'lib/ConfigReader/Simple.pm' => 
			'$(INST_MAN3DIR)/ConfigReader::Simple.3',
		},

    clean  => { FILES => "ConfigReader-Simple-*" },

	);
