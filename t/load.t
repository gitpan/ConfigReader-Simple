# $Id: load.t 1214 2004-04-29 06:22:13Z comdog $

use Test::More tests => 1;
print "bail out! ConfigReader::Simple did not compile" 
	unless use_ok( 'ConfigReader::Simple' );

