# $Id: 03.exists.t,v 1.1 2002/03/05 04:30:11 comdog Exp $
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

# try the ones that should exist
eval
	{
	foreach my $directive ( @Directives )
		{
		die "\nDirective [$directive] should exist, but I cannot tell it does"
			unless $config->exists( $directive );
		}	
	};
$@ ? not_ok($@) : ok();
print STDERR $@ if $@;

# try the ones that shouldn't
eval
	{
	foreach my $directive ( qw(Test5 exists blah get) )
		{
		die "\nDirective [$directive] shouldn't exist, but I think it does"
			if $config->exists( $directive );

		my $value = $config->get( 'Test5' );
		die "\nDirective [$directive] didn't exist, but after get() it does"
			if $config->exists( $directive );
		
		$value = $config->Test5;
		die "\nDirective [$directive] didn't exist, but after AUTOLOAD it does"
			if $config->exists( $directive );
		}	
	};
$@ ? not_ok($@) : ok();
print STDERR $@ if $@;
