package LoginHistory::Object;
use strict;

use base qw( MT::Object );
__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'integer not null auto_increment',
        'ipaddress' => {
            type => 'string',
            size => 255,
        },
        'created' => 'datetime not null',
    },
    # audit => 1,
    indexes => {
        id => 1,
    },
    datasource => 'login_history',
    primary_key => 'id',
});

1;