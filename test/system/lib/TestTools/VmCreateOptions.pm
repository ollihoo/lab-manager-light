package TestTools::VmCreateOptions;

use strict;
use warnings;

use Getopt::Long;
use Data::Dumper;
use Carp;

sub new {
    my ( $class, $self ) = @_;
    croak("Arg must be hashref of vm options") unless ( ref($self) eq "HASH" );
    # extend test data with builtins
    $self->{expiration_date} = DateTime->today()->add( days => 1 )->dmy(".");
    $self->{force_boot_target} = 'qrdata' unless ($self->{force_boot_target});
    # TODO: rename vm_host to vm_name to avoid confusion with ESX server
    $self->{vm_host} = sprintf "%s%02d", $self->{vm_name_prefix}, (localtime)[1] + 1;

    # make sure that everything is set
    if (
         not(     $self->{test_host}
              and $self->{vm_name_prefix}
              and $self->{esx_host}
              and $self->{username}
              and $self->{folder}
              and $self->{lmlhostpattern} )
      )
    {
        croak "##teamcity[buildStatus status='FAILURE' text='Need to provide at least test_host, vm_name_prefix, esx_host, username, folder and lmlhostpattern options.']\n";
    }

    bless $self, $class;

    return $self;
}

1;