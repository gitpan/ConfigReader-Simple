# $Id: 02.get.t,v 1.4 2002/07/14 03:56:33 comdog Exp $
BEGIN { $| = 1; print "1..10\n"; }
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

# get things that do exist
eval
	{
	die "\nDid not fetch Test3 value correctly"
		unless $config->get( 'Test3' ) eq 'foo';
	die "\nDid not fetch Test2 value correctly"
		unless $config->get( 'Test2' ) eq 'Test 2 value';
	};
$@ ? not_ok($@) : ok();
print STDERR $@ if $@;

# get things that do exist, but look like false values to perl
eval
	{
	die "\nDid not fetch Zero value correctly (as a string)"
		unless $config->get( 'Zero' ) eq '0';
	die "\nDid not fetch Zero value correctly (as a number)"
		unless $config->get( 'Zero' ) == 0;
	die "\nDid not fetch Undef value correctly"
		unless $config->get( 'Undef' ) eq '';
	};
$@ ? not_ok($@) : ok();
print STDERR $@ if $@;

# get things that do not exist
# using AUTOLOAD
eval
	{
	die "\nDid fetch Test value, which I shouldn't be able to do"
		if defined $config->get( 'Test' );
	die "\nDid fetch Test5 value, which I shouldn't be able to do"
		if defined $config->get( 'Test5' );
	};
$@ ? not_ok($@) : ok();
print STDERR $@ if $@;

# get things that do exist
# using AUTOLOAD
eval
	{
	die "\nDid not fetch Test3 value correctly (with AUTOLOAD)"
		unless $config->Test3 eq 'foo';
	die "\nDid not fetch Test2 value correctly (with AUTOLOAD)"
		unless $config->Test2 eq 'Test 2 value';
	};
$@ ? not_ok($@) : ok();
print STDERR $@ if $@;

# get things that do not exist
# using AUTOLOAD
eval
	{
	die "\nDid fetch Test value (with AUTOLOAD), which I shouldn't be able to do"
		if defined $config->Test;
	die "\nDid fetch Test5 value (with AUTOLOAD), which I shouldn't be able to do"
		if defined $config->Test5;
	};
$@ ? not_ok($@) : ok();
print STDERR $@ if $@;

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # Now try it with multiple files
eval
	{
	$config = ConfigReader::Simple->new_multiple( 
		Files => [ qw( t/global.config t/example.config ) ] );

	die "\nCould not create configuration object! [ $config ]"
		unless ref $config eq 'ConfigReader::Simple';
	};
$@ ? not_ok($@) : ok();

# get things that do exist
eval
	{
	die "\nDid not fetch Test3 value correctly"
		unless $config->get( 'Test3' ) eq 'foo';
	die "\nDid not fetch Scope value correctly"
		unless $config->get( 'Scope' ) eq 'Global';
	die "\nDid not fetch Test2 value correctly"
		unless $config->get( 'Test2' ) eq 'Test 2 value';
	};
$@ ? not_ok($@) : ok();
print STDERR $@ if $@;

eval
	{
	$config = ConfigReader::Simple->new( "t/example.config" );

	die "\nDid not fetch Test3 value correctly"
		unless $config->get( 'Test3' ) eq 'foo';
	die "\nDid not fetch Test2 value correctly"
		unless $config->get( 'Test2' ) eq 'Test 2 value';

	$config->add_config_file( "t/global.config" );
	
	die "\nDid not fetch Scope value correctly"
		unless $config->get( 'Scope' ) eq 'Global';
	};
$@ ? not_ok($@) : ok();
print STDERR $@ if $@;

