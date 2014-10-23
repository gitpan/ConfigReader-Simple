# $Id: pod.t,v 1.2 2003/03/23 21:52:41 petdance Exp $

BEGIN {
    @files = qw(
	lib/ConfigReader/Simple
    );
    $nfiles = @files;
}

use Test::More tests => $nfiles;

SKIP: {
    eval "use Test::Pod;";
    $bad = ( $@ || ($Test::Pod::VERSION <= '0.95') );
    skip "Test::Pod 0.95 not installed", $nfiles if $bad;
    pod_file_ok('blib/$_') for @files;
}

