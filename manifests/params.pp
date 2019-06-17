#
# pam params
#

class pam::params {

    $enable_duo = false
    $enable_sssd = false
    $session_include = undef

    $pam_d_sshd_file = '/etc/pam.d/sshd'
    $pam_d_system_auth_ac_file = '/etc/pam.d/system-auth-ac'
    $pam_d_password_auth_ac_file = '/etc/pam.d/password-auth-ac'


    case $::osfamily {
        'RedHat': {
            case $::operatingsystemmajrelease {
                '5': {
                    $pam_d_sshd_template = 'pam/sshd.el5.erb'
                    $pam_d_system_auth_ac_template = 'pam/system-auth-ac.el5.erb'
                }
                '6': {
                    $pam_d_sshd_template = 'pam/sshd.el6.erb'
                    $pam_d_password_auth_ac_template = 'pam/password-auth-ac.el6.erb'
                    $pam_d_system_auth_ac_template = 'pam/system-auth-ac.el6.erb'
                }
                '7': {
                    $pam_d_sshd_template = 'pam/sshd.el7.erb'
                    $pam_d_password_auth_ac_template = 'pam/password-auth-ac.el7.erb'
                    $pam_d_system_auth_ac_template = 'pam/system-auth-ac.el7.erb'
                }
                default: {
                    fail('This PAM module is only supported on EL 5, 6, and 7.')
                }
            }
        }
        default: {
            fail('This PAM module is only supported on RedHat and derivatives.')
        }
    }

}
