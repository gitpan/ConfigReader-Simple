# $Id: 04.clone.t,v 1.1 2002/03/07 20:33:20 comdog Exp $
BEGIN { $| = 1; print "1..5\n"; }
END   {print "not ok\n" unless $loaded;}

# Test it loads
use ConfigReader::Simple;
$loaded = 1;
print "ok\n";

sub ok     { print STDOUT "ok\n" }
sub not_ok { print STDERR @_, "\n"; print STDOUT "not ok\n" }

my @Directives = qw( Test1 Test2 Test3 Test4 );

my( $config, $clone );

eval
	{
	$config = ConfigReader::Simple->new( "t/example.config", \@Directives );

	die "\nCould not create configuration object! [ $config ]"
		unless ref $config eq 'ConfigReader::Simple';
	};
$@ ? not_ok($@) : ok();


# can we clone the object?
# this should be a deep copy
eval
	{
	$clone = $config->clone;
	
	die "\nCould not clone configuration object! [ $config ]"
		unless ref $clone eq 'ConfigReader::Simple';
	
	};
$@ ? not_ok($@) : ok();

# can we change the clone without affecting the original?
eval
	{
	my $Test1_value = 'Kundry';
	$clone->set( 'Test1', $Test1_value );
	
	die "Could not set Test1 value to $Test1_value."
		unless  $clone->Test1 eq $Test1_value;
	die "Setting clone value affected original"
		unless  $config->Test1 ne $Test1_value;
	};
$@ ? not_ok($@) : ok();	

# can we change the original without affecting the clone?
eval
	{
	my $Test2_value = 'Second Squire';
	$config->set( 'Test2', $Test2_value );
	
	die "Could not set Test1 value to $Test2_value."
		unless  $config->Test2 eq $Test2_value;
	die "Setting clone value affected original"
		unless  $clone->Test2 ne $Test2_value;
	};
$@ ? not_ok($@) : ok();	
