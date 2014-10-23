# $Id: clone.t 1669 2005-08-24 22:51:02Z comdog $

use Test::More tests => 14;

use ConfigReader::Simple;

my @Directives = qw( Test1 Test2 Test3 Test4 );

my $config = ConfigReader::Simple->new( "t/example.config", \@Directives );
isa_ok( $config, 'ConfigReader::Simple' );

# can we clone the object?
# this should be a deep copy
my $clone = $config->clone;
isa_ok( $clone, 'ConfigReader::Simple' );

# can we change the clone without affecting the original?
{
my $Test1_value = 'Kundry';
$clone->set( 'Test1', $Test1_value );
is( $clone->Test1, $Test1_value, 
	'Cloned object has right value after change' );
isnt( $config->Test1, $Test1_value, 
	'Original object has right value after clone change' );
}

# can we change the original without affecting the clone?
{
my $Test2_value = 'Second Squire';
$config->set( 'Test2', $Test2_value );
is( $config->Test2, $Test2_value,
	'Original object has right value after change' );
isnt( $clone->Test2, $Test2_value,
	'Clone object has right value after original change' );

my @files       = $config->files;
my @clone_files = $clone->files;

is( scalar @files, 1, "Original object has 1 associated file" );
is( scalar @clone_files, 1, "Clone object has 1 associated file" );
is( $files[-1], "t/example.config", "Original object returns right file" );
is( $clone_files[-1], "t/example.config", "Clone object returns right file" ); 

$config->add_config_file( 't/clone.config' );

@files       = $config->files;
@clone_files = $clone->files;

is( scalar @files, 2, "Original object has 1 associated file" );
is( scalar @clone_files, 1, "Clone object has 1 associated file" );
is( $files[-1], "t/clone.config", "Original object returns right file" );
is( $clone_files[-1], "t/example.config", "Clone object returns right file" ); 


}
