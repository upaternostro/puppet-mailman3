# == Class: mailman3::config
#
# This class has one job: get started building mm_cfg.py for Mailman.
# When using big templates, I like to dedicate an entire class to the purpose
# so that all manifests are clear about which variables are actually used.
#
# === Examples
#
# This is used internally by class 'mailman3'. Don't reference it externally.
#
# === Authors
#
# Ugo Paternostro <ugo.git@paternostro.org>
#
# === Copyright
#
# Copyright 2024 Ugo Paternostro, unless otherwise noted.
#
class mailman3::config inherits mailman3::params {
  $site_owner                         = $mailman3::site_owner
  $noreply_address                    = $mailman3::noreply_address
  $default_language                   = $mailman3::default_language
  $sender_headers                     = $mailman3::sender_headers
  $email_commands_max_lines           = $mailman3::email_commands_max_lines
  $pending_request_life               = $mailman3::pending_request_life
  $cache_life                         = $mailman3::cache_life
  $pre_hook                           = $mailman3::pre_hook
  $post_hook                          = $mailman3::post_hook
  $layout                             = $mailman3::layout
  $filtered_messages_are_preservable  = $mailman3::filtered_messages_are_preservable
  $html_to_plain_text_command         = $mailman3::html_to_plain_text_command
  $listname_chars                     = $mailman3::listname_chars
  $prompt                             = $mailman3::prompt
  $banner                             = $mailman3::banner
  $use_ipython                        = $mailman3::use_ipython
  $history_file                       = $mailman3::history_file
  $dirs                               = $mailman3::dirs
  $pid_file                           = $mailman3::pid_file
  $lock_file                          = $mailman3::lock_file
  $database                           = $mailman3::database
  $database_params                    = $mailman3::database_params
  $debug                              = $mailman3::debug
  $format                             = $mailman3::format
  $datefmt                            = $mailman3::datefmt
  $propagate                          = $mailman3::propagate
  $level                              = $mailman3::level
  $path                               = $mailman3::path
  $hostname                           = $mailman3::hostname
  $port                               = $mailman3::port
  $use_https                          = $mailman3::use_https
  $show_tracebacks                    = $mailman3::show_tracebacks
  $api_version                        = $mailman3::api_version
  $admin_user                         = $mailman3::admin_user
  $admin_pass                         = $mailman3::admin_pass
  $mta                                = $mailman3::mta
  $outgoing                           = $mailman3::outgoing
  $smtp_hostname                      = $mailman3::smtp_hostname
  $smtp_port                          = $mailman3::smtp_port
  $smtp_user                          = $mailman3::smtp_user
  $smtp_pass                          = $mailman3::smtp_pass
  $lmtp_hostname                      = $mailman3::lmtp_hostname
  $lmtp_port                          = $mailman3::lmtp_port
  $mm_package                         = $mailman3::mm_package
  $mm_username                        = $mailman3::mm_username
  $mm_groupname                       = $mailman3::mm_groupname
  $mm_service                         = $mailman3::mm_service
  $enable_service                     = $mailman3::enable_service

  file { 'mailman.cfg':
    path    => "${dirs['etc_dir']}/mailman.cfg",
    content => template("${module_name}/mailman.cfg.erb"),
    owner   => 'root',
    group   => $mm_groupname,
    mode    => '0640',
    require => Package[$mm_package],
    notify  => Service[$mm_service],
  }
}
