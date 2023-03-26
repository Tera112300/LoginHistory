package MT::Plugin::LoginHistory;
use strict;
use utf8;
use base qw(MT::Plugin);
use LoginHistory::Object;
use DateTime;


my $plugin = MT::Plugin::LoginHistory->new({
    id       => "loginhistory",
    key      => __PACKAGE__,
    name     => 'LoginHistory',
    schema_version => 1.0,
    registry => {
        object_types => {
          'loginhistory' => 'LoginHistory::Object'
        },
        applications => {
            cms => {
                menus => {
                    'tools::new_menu' => {
                        label => 'ログイン履歴確認',
                        order => 10100,
                        mode  => "loginhistory_menu"
                    }
                },
                methods => {
                    'loginhistory_menu' => '$LoginHistor::LoginHistory::CMS::loginhistory_menu',
                },
            },
        }
    }
});
MT->add_plugin($plugin);

sub init_app {
    my ( $cb, $app ) = @_;

    my $saved_login = \&MT::App::login;
    my $_login = sub {
        my $app = shift;
        my ($author, $new_login) = $saved_login->($app, @_);
        if($author && $app->isa('MT::App::CMS')) {
            my $sess = $app->{session}
                or return ($author, $new_login);
            if($new_login) {
                    my $obj = LoginHistory::Object->new();
                    $obj->ipaddress($ENV{REMOTE_ADDR});
                    $obj->created(DateTime->now(time_zone => 'Asia/Tokyo'));
                    $obj->save();
            }
        }
        return ($author, $new_login);
    };
    *MT::App::login = $_login;
    return 1;
}

1;