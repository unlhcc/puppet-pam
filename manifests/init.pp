#
# pam
#

class pam (
    $enable_duo                         = $pam::params::enable_duo,
    $enable_sssd                        = $pam::params::enable_sssd,
    $pam_d_sshd_file                    = $pam::params::pam_d_sshd_file,
    $pam_d_sshd_template                = $pam::params::pam_d_sshd_template,
    $pam_d_system_auth_ac_file          = $pam::params::pam_d_system_auth_ac_file,
    $pam_d_system_auth_ac_template      = $pam::params::pam_d_system_auth_ac_template,
    $pam_d_password_auth_ac_file        = $pam::params::pam_d_password_auth_ac_file,
    $pam_d_password_auth_ac_template    = $pam::params::pam_d_password_auth_ac_template,
    $session_include                    = $pam::params::session_include,
) inherits pam::params {


    validate_bool($enable_duo)
    validate_bool($enable_sssd)
    validate_absolute_path($pam_d_sshd_file)
    validate_absolute_path($pam_d_system_auth_ac_file)
    validate_absolute_path($pam_d_password_auth_ac_file)
    validate_string($pam_d_sshd_template)
    validate_string($pam_d_system_auth_ac_template)
    validate_string($pam_d_password_auth_ac_template)


    file { 'pam_d_sshd':
        ensure  => file,
        path    => $pam_d_sshd_file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template($pam_d_sshd_template),
    }

    file { 'pam_system_auth_ac':
        ensure  => file,
        path    => $pam_d_system_auth_ac_file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template($pam_d_system_auth_ac_template),
    }

    if $::operatingsystemmajrelease >= '6' {
        file { 'pam_password_auth_ac':
            ensure  => file,
            path    => $pam_d_password_auth_ac_file,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template($pam_d_password_auth_ac_template),
        }
    }

}

