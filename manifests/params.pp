#
# pam params
#

class pam::params {
    $enable_duo = false
    $enable_sssd = false
    $session_include = []

    $pam_d_sshd_file = '/etc/pam.d/sshd'
    $pam_d_system_auth_file = '/etc/pam.d/system-auth'
    $pam_d_password_auth_file = '/etc/pam.d/password-auth'

    case $facts['os']['family'] {
        'RedHat': {
            $maj = $facts['os']['release']['major']
            $pam_d_sshd_template = "pam/sshd.el${maj}.erb"
            $pam_d_password_auth_template = "pam/password-auth.el${maj}.erb"
            $pam_d_system_auth_template = "pam/system-auth.el${maj}.erb"
        }
        default: {
            fail('This PAM module is only supported on RedHat and derivatives.')
        }
    }
}
