# $Id: Makefile.PL,v 1.3 2001/09/29 18:45:32 comdog Exp $
use strict;

use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'	   => 'ConfigReader::Simple',
    'VERSION_FROM' => 'lib/ConfigReader/Simple.pm',

    'dist'         => { 
                         COMPRESS => 'gzip -9f',
                         SUFFIX => '.gz',
                      },
);
