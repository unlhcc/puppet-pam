#
# pam
#

class pam (
    Boolean              $enable_duo                   = $pam::params::enable_duo,
    Boolean              $enable_sssd                  = $pam::params::enable_sssd,
    Stdlib::Absolutepath $pam_d_sshd_file              = $pam::params::pam_d_sshd_file,
    String               $pam_d_sshd_template          = $pam::params::pam_d_sshd_template,
    Stdlib::Absolutepath $pam_d_system_auth_file       = $pam::params::pam_d_system_auth_file,
    String               $pam_d_system_auth_template   = $pam::params::pam_d_system_auth_template,
    Stdlib::Absolutepath $pam_d_password_auth_file     = $pam::params::pam_d_password_auth_file,
    String               $pam_d_password_auth_template = $pam::params::pam_d_password_auth_template,
    Array[String]        $session_include              = $pam::params::session_include,
) inherits pam::params {

    file { 'pam_d_sshd':
        ensure  => file,
        path    => $pam_d_sshd_file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template($pam_d_sshd_template),
    }

    file { 'pam_system_auth':
        ensure  => file,
        path    => $pam_d_system_auth_file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template($pam_d_system_auth_template),
    }

    if $::operatingsystemmajrelease >= '6' {
        file { 'pam_password_auth':
            ensure  => file,
            path    => $pam_d_password_auth_file,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template($pam_d_password_auth_template),
        }
    }

}

