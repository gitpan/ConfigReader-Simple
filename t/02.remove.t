# $Id: 02.remove.t,v 1.1 2002/03/07 20:44:07 comdog Exp $
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

	die "\nCould not create configuration object! [ $config ]"
		unless ref $config eq 'ConfigReader::Simple';
	};
$@ ? not_ok($@) : ok();

# remove things that do exist
eval
	{
	die "\nDid not fetch Test3 value correctly"
		unless $config->get( 'Test3' ) eq 'foo';
		
	$config->remove( 'Test3' );
	
	die "\nTest3 exists - should have been removed"
		if $config->exists( 'Test3' );
	};
$@ ? not_ok($@) : ok();

# remove things that do not exist
eval
	{
	die "\nRemoved Tenor which should not exist"
		if $config->remove( 'Tenor' );
		
	$config->remove( 'Tenor' );
	
	die "\nTenor exists - should have been removed and not created"
		if $config->exists( 'Tenor' );
	};
$@ ? not_ok($@) : ok();
