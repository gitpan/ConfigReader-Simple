# $Id: 01.load.t,v 1.2 2001/10/10 08:25:33 comdog Exp $
BEGIN { $| = 1; print "1..3\n"; }
END   {print "not ok\n" unless $loaded;}

# Test it loads
use ConfigReader::Simple;
$loaded = 1;
print "ok\n";

sub ok     { print STDOUT "ok\n" }
sub not_ok { print STDERR @_, "\n"; print STDOUT "not ok\n" }

my $config = '';

eval
	{
	$config = ConfigReader::Simple->new(
		"t/example.config", [ qw( Test1 Test2 Test3 Test4 ) ] );

	die "Could not create configuration object! [ $config ]"
		unless ref $config eq 'ConfigReader::Simple';
	};
$@ ? not_ok($@) : ok();

eval
	{
	die unless $config->Test3 eq 'foo';
	};
$@ ? not_ok($@) : ok();

