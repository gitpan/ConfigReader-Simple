# $Id: 01.load.t,v 1.3 2001/10/23 20:01:32 comdog Exp $
BEGIN { $| = 1; print "1..4\n"; }
END   {print "not ok\n" unless $loaded;}

# Test it loads
use ConfigReader::Simple;
$loaded = 1;
print "ok\n";

sub ok     { print STDOUT "ok\n" }
sub not_ok { print STDERR @_, "\n"; print STDOUT "not ok\n" }

my $config = '';
my @Directives = qw( Test1 Test2 Test3 Test4 );

eval
	{
	$config = ConfigReader::Simple->new( "t/example.config", \@Directives );

	die "Could not create configuration object! [ $config ]"
		unless ref $config eq 'ConfigReader::Simple';
	};
$@ ? not_ok($@) : ok();

eval
	{
	die unless $config->Test3 eq 'foo';
	};
$@ ? not_ok($@) : ok();

eval
	{
	my %directives = map { $_, 1 } $config->directives;

	foreach my $directive ( @Directives )
		{
		die "[$directive] was not returned by directives()"
			unless exists $directives{ $directive };
		}

	};
$@ ? not_ok($@) : ok();
