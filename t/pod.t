# $Id: pod.t,v 1.1 2002/09/16 21:13:51 comdog Exp $
BEGIN {
	use File::Find::Rule;
	@files = File::Find::Rule->file()->name( '*.pm' )->in( 'blib/lib' );
	}

use Test::More tests => scalar @files;
use Test::Pod;

foreach my $file ( @files )
	{
	pod_ok( $file );
	}
