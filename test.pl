#
# tests for ConfigReader::Simple
#
# Last updated by gossamer on Sat Aug 12 09:12:36 EST 2000
#

BEGIN { $| = 1; print "1..4\n"; }
END {print "not ok 1\n" unless $loaded;}

# Test it loads
use ConfigReader::Simple;
$loaded = 1;
print "ok 1\n";

# Test a valid config file loads
my $Config = ConfigReader::Simple->new("example.config", ["Test1", "Test2"]);
if($Config) {
   print "ok 2\n";
} else {
   print "not ok 2\n";
}

# Test a valid config file parses and validates
if($Config->parse()) {
   print "ok 3\n";
} else {
   print "not ok 3\n";
}
