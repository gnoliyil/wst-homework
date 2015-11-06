#!/usr/bin/env perl
# show all data in data.txt

use CGI qw/:standard/; 

open $fin, '<', 'data.txt'; 
flock $fin, LOCK_SH; 

my @json_list = ();  
my @item_list = ('name', 'addr', 'gender', 
                 'password', 'stuid'); 

while (<$fin>){
    $_ =~ s/^\s+|\s+$//g; 
    my @data = split '\t', $_; 
    my @json_data = (); 
    foreach (0..4) {
        push @json_data, "\"@item_list[$_]\" : \"$data[$_]\""; 
    }
    push @json_list, '{' . join(', ', @json_data) . '}'; 
}
close $fin; 
flock $fin, LOCK_UN; 

$q = CGI->new; 
$q->charset('utf-8'); 

print $q->header(-type=>'text/plain'); 
print '[' . join(', ', @json_list) . "]\n";  

