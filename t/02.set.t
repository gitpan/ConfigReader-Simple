# $Id: 02.set.t,v 1.1 2002/03/07 20:33:20 comdog Exp $
BEGIN { $| = 1; print "1..6\n"; }
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

# set things that do exist
eval
	{
	my $Test1_value = 'Tamino';
	
	$config->set( 'Test1', $Test1_value );
	
	die "\nDid not set Test1 value correctly"
		unless $config->Test1 eq $Test1_value;
	};
$@ ? not_ok($@) : ok();

# set things that do not exist
eval
	{
	my $directive = 'Baritone';
	my $value     = 'Tamino';
	
	$config->set( $directive, $value );
	
	die "\nDid not set $directive value correctly"
		unless $config->$directive eq $value;
	};
$@ ? not_ok($@) : ok();

# unset things that do exist
eval
	{
	my $directive = 'Baritone';
	
	die "\nUnset returned false while trying to unset $directive"
		unless $config->unset( $directive );
	
	die "\nDid not set $directive value correctly"
		if defined $config->$directive;
	};
$@ ? not_ok($@) : ok();

# unset things that do exist
eval
	{
	my $directive = 'Tenor';
	
	die "\nUnset returned true while trying to unset $directive"
		if $config->unset( $directive );
	
	die "\nUnset created directive"
		if $config->exists( $directive );
	};
$@ ? not_ok($@) : ok();
