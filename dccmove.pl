#
# Copyright (C) 2003 by Peder Stray <peder@ninja.no>
#

use Irssi;
use vars qw{$VERSION %IRSSI};
($VERSION) = '$Revision: 1.1 $' =~ / (\d+\.\d+) /;
%IRSSI = (
          name        => 'dccmove',
          authors     => 'Peder Stray',
          contact     => 'peder@ninja.no',
          url         => 'http://ninja.no/irssi/dccmove.pl',
          license     => 'GPL',
          description => 'Move completed dcc gets to the subfolder done',
         );

sub sig_dcc_closed {
    my($dcc) = @_;
    my($dir,$file);

    return unless $dcc->{type} eq 'GET';
    next unless -f $dcc->{file};

    ($dir,$file) = $dcc->{file} =~ m,(.*)/(.*),;
    $dir .= "/done";

    mkdir $dir, 0755 unless -d $dir;
    rename $dcc->{file}, "$dir/$file";

    print '%gDCC moved %_'.$file.'%_ to %_'.$dir.'%_%n';
     
}

Irssi::signal_add('dcc closed', 'sig_dcc_closed');
