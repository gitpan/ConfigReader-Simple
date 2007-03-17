# $Id: pod_coverage.t 1671 2005-08-24 23:31:54Z comdog $

use Test::More;
eval "use Test::Pod::Coverage";

if( $@ )
	{
	plan skip_all => "Test::Pod::Coverage required for testing POD";
	}
else
	{
	plan tests => 1;

	pod_coverage_ok( "ConfigReader::Simple",
		{
		trustme => [ qr/^[A-Z_]+$/, qr/parse_line/ ]
		}
		);      
	}
