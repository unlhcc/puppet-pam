#
# pam params
#

class pam::params {

    $enable_duo = false
    $enable_sssd = false
    $session_include = undef

    $pam_d_sshd_file = '/etc/pam.d/sshd'
    $pam_d_system_auth_file = '/etc/pam.d/system-auth'
    $pam_d_password_auth_file = '/etc/pam.d/password-auth'


    case $::osfamily {
        'RedHat': {
            case $::operatingsystemmajrelease {
                '5': {
                    $pam_d_sshd_template = 'pam/sshd.el5.erb'
                    $pam_d_system_auth_template = 'pam/system-auth.el5.erb'
                }
                '6': {
                    $pam_d_sshd_template = 'pam/sshd.el6.erb'
                    $pam_d_password_auth_template = 'pam/password-auth.el6.erb'
                    $pam_d_system_auth_template = 'pam/system-auth.el6.erb'
                }
                '7': {
                    $pam_d_sshd_template = 'pam/sshd.el7.erb'
                    $pam_d_password_auth_template = 'pam/password-auth.el7.erb'
                    $pam_d_system_auth_template = 'pam/system-auth.el7.erb'
                }
                '8': {
                    $pam_d_sshd_template = 'pam/sshd.el8.erb'
                    $pam_d_password_auth_template = 'pam/password-auth.el8.erb'
                    $pam_d_system_auth_template = 'pam/system-auth.el8.erb'
                }
                default: {
                    fail('This PAM module is only supported on EL 5, 6, 7, and 8.')
                }
            }
        }
        default: {
            fail('This PAM module is only supported on RedHat and derivatives.')
        }
    }

}
