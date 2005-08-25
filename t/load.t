# $Id: load.t,v 1.4 2004/04/29 06:22:13 comdog Exp $

use Test::More tests => 1;
print "bail out! ConfigReader::Simple did not compile" 
	unless use_ok( 'ConfigReader::Simple' );

