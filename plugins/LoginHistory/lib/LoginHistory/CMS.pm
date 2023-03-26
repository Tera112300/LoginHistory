package LoginHistory::CMS;
use strict;


sub loginhistory_menu{
    my $app = shift;
    $app->{plugin_template_path} = 'plugins/LoginHistory/tmpl';

    my $iter = LoginHistory::Object->search();
    my @history;
    while (my $obj = $iter->next) {
        push @history, {
            id => $obj->id,
            ipaddress => $obj->ipaddress,
            created => $obj->created,
        };
    }
    my %param;
    $param{history} = \@history;
    return $app->load_tmpl('loginhistory_menu.tmpl',\%param);
}

1;