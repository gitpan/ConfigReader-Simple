
BEGIN { $| = 1; print "1..2\n"; }
END {print "not ok 1\n" unless $loaded;}

use ConfigReader::Simple;
$loaded = 1;
print "ok 1\n";

if(my $Config = ConfigReader::Simple->new("example.config", ["Test1", "Test2"])) {
   print "ok 2\n";
} else {
   print "not ok 2\n";
}

