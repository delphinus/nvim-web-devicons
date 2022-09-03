#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);
binmode STDOUT => ':utf8';

my $filename = 'lua/nvim-web-devicons.lua';
my $script = do {
    local $/;
    open my $fh, '< :utf8', $filename or die $!;
    <$fh>;
};

$script =~ s{.}{
    my $codepoint = ord $&;
    if ($codepoint >= 0xf900 && $codepoint <= 0xfd46) {
        my $new = chr($codepoint + 0xe800 - 0xf900);
        say "$& => $new";
        $new;
    } elsif ($codepoint >= 0xea60 && $codepoint <= 0xebeb) {
        my $new = chr($codepoint + 0xf0000);
        say "$& => $new";
        $new;
    } else {
        $&;
    }
}eg;

{
    open my $fh, '> :utf8', $filename or die $!;
    $fh->print($script);
}
