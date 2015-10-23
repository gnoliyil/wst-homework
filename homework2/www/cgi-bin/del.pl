#!/usr/bin/env perl
# delete the user

use CGI qw/:standard/; 

my $q = CGI->new; 
$q->charset('utf-8'); 

open my $fin, '<', 'data.txt'; 
flock $fin, LOCK_EX; 
my @lines = <$fin>; 
close $fin; 

$ids = $q->param('stuid'); 
@id = split '|', $ids;
open my $fin, '>', 'data.txt'; 
my $deleted = 0; 
foreach (@lines){
    if (not /\t($ids)$/) {
        print $fin $_; 
    } else {
        $deleted = 1; 
    }
}
flock $fin, LOCK_UN;
close $fin; 

print $q->header(-type=>'text/plain');
if ($deleted) {
    print "{\"code\": 0, \"msg\": \"success\"}\n"; 
} else {
    print "{\"code\": -1, \"msg\": \"not deleted yet\"}\n"; 
}
