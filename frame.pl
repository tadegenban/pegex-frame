use Pegex;
use 5.012;
use Data::Dumper;

my $grammar = <<'...';
frame: section*
section:
    title EOL
    row*
title: LSQUARE plain RSQUARE
row:
    plain+ % SPACE
    EOL
plain: /- ( [^ SPACE TAB EOL CR NL LSQUARE RSQUARE ]* ) /
...

{
    package Frame;
    use Pegex::Base;
    extends 'Pegex::Tree';

    use Data::Dumper;
    sub got_title { @{$_[1]} }
    sub got_row { @{$_[1]} }
    sub got_section { +{ @{$_[1]} } }

}

my $result = pegex($grammar, 'Frame')->parse(<<__);
[xxx2014]
plvt nlvt
zvt
[xxx2013]
psvt nsvt
npn18
__

print Dumper $result