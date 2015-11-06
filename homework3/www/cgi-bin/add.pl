#!/usr/bin/env perl
# add a record to "log.txt"

use CGI qw(:standard); 
use Fcntl qw(:flock SEEK_END);

#"data.txt" 第一行写当前的最大数据
sub error {
    my $q = shift; 
    my $error_message = shift;
     
    print $q->header( "text/plain" ),
          "{\"code\": -1; \"msg\": \'" , 
          $error_message, 
          "\'}\n"; 
    exit;
}

sub die_msg
{
	return '{"code": -1, "msg": "' . shift . '"}';
}

my $q=CGI->new; 
$q->charset("utf-8"); 

sub get_param
{
    my $q = shift; 
    my $s = $q->param(shift);
    $s =~ s/\t/    /; 
    return $s;
}

@input_data = ('name', 'addr', 'gender', 'password', 'stuid'); 
foreach (@input_data) {
    $$_ = get_param($q, $_);
    print STDERR $_; 
    error($q, 'Sorry, ' . $_ . ' can not be empty. ') if ($$_ eq "") ; 
}

open($file, "<", "data.txt");
flock($file, LOCK_SH); 
while (<$file>){
    error $q, "Student ID already exists!" if /\t$stuid$/;
}
flock($file, LOCK_UN); 
close($file);

open($file, ">>", "data.txt")
    or error $q, "Error while reading data.txt"; 
seek($file, 0, SEEK_END);     
flock($file, LOCK_EX); 
print $file "$name\t$addr\t$gender\t$password\t$stuid\n"; 


print $q->header(-type=>'text/plain'); 
print "{\"code\": 0, \"msg\": \"success\"}\n"; 

flock($file, LOCK_UN); 


