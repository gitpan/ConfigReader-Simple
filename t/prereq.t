# $Id: prereq.t,v 1.1 2002/09/30 06:56:43 comdog Exp $

use Test::More tests => 1;
use Test::Prereq;

print "bail out! Makefile.PL needs help!"
	unless prereq_ok();
