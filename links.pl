#!/usr/bin/perl
use HTTP::Tiny;
use Data::Dumper::Perltidy;

$message="Hello, Welcome to LinuxHint";
print("$message \n");

#use warnings;
#use HTTP::Request; use HTTP::Headers; use LWP::UserAgent; use JSON::PP;

$apiKEY="?apikey=3e00873e2f8047a4a541d8d11b439330";
$host="https://192.168.1.100:8989/api/v3";
$targetAPI="history";

$SERVER_ADDR="http://192.168.1.100:8989/api/v3/history?apikey=3e00873e2f8047a4a541d8d11b439330";




#use LWP::Simple;
#$content = get($url);
#die "Can't GET $url" if (! defined $content);

my $response = HTTP::Tiny->new->get($SERVER_ADDR);
if ($response->{success})
{
    my $html = $response->{content};
    @LINES = split /\n/, $html;
    chomp(@LINES);
    #print("Lines: '@LINES'\n"); # ZZZ
    my $decoded_json = decode_json( $html );
    print Dumper $decoded_json;
}
else
{
    print "Failed: $response->{status} $response->{reasons}";
}
