# == Class: mailman3
#
# This class sets up a Mailman3 environment, but does not provide any
# integration with web servers. Typically you would
# also want to use mailman3::apache.
#
# It is assumed that the operating system provides Mailman3 packages.
#
# === Parameters
#
# Caution: If you use Mailman on more than one server, be careful to
# only enable the Mailman service (qrunners) on ONE server.
#
# [*site_owner*]
#   This address is the "site owner" address.  Certain messages which must be
#   delivered to a human, but which can't be delivered to a list owner (e.g. a
#   bounce from a list owner), will be sent to this address.  It should point to
#   a human.
#
# [*noreply_address*]
#   This is the local-part of an email address used in the From field whenever a
#   message comes from some entity to which there is no natural reply recipient.
#   Mailman will append '@' and the host name of the list involved.  This
#   address must not bounce and it must not point to a Mailman process.
#
# [*default_language*]
#   The default language for this server.
#
# [*sender_headers*]
#   Membership tests for posting purposes are usually performed by looking at a
#   set of headers, passing the test if any of their values match a member of
#   the list.  Headers are checked in the order given in this variable.  The
#   value From_ means to use the envelope sender.  Field names are case
#   insensitive.
#
# [*email_commands_max_lines*]
#   Mail command processor will ignore mail command lines after designated max.
#
# [*pending_request_life*]
#   Default length of time a pending request is live before it is evicted from
#   the pending database.
#
# [*cache_life*]
#   How long should files be saved before they are evicted from the cache?
#
# [*pre_hook*]
#   A callable to run with no arguments early in the initialization process.
#   This runs before database initialization.
#
# [*post_hook*]
#   A callable to run with no arguments late in the initialization process.
#   This runs after adapters are initialized.
#
# [*layout*]
#   Which paths.* file system layout to use.
#   You should not change this variable.
#
# [*filtered_messages_are_preservable*]
#   Can MIME filtered messages be preserved by list owners?
#
# [*html_to_plain_text_command*]
#   How should text/html parts be converted to text/plain when the mailing list
#   is set to convert HTML to plaintext?  This names a command to be called,
#   where the substitution variable $filename is filled in by Mailman, and
#   contains the path to the temporary file that the command should read from.
#   The command should print the converted text to stdout.
#
# [*listname_chars*]
#   Specify what characters are allowed in list names.  Characters outside of
#   the class [-_.+=!$*{}~0-9a-z] matched case insensitively are never allowed,
#   but this specifies a subset as the only allowable characters.  This must be
#   a valid character class regexp or the effect on list creation is
#   unpredictable.
#
# [*prompt*]
#   mailman shell prompt.
#
# [*banner*]
#   mailman shell banner to show on startup.
#
# [*use_ipython*]
#   Use IPython as the shell, which must be found on the system.  Valid values
#   are `no`, `yes`, and `debug` where the latter is equivalent to `yes` except
#   that any import errors will be displayed to stderr.
#
# [*history_file*]
#   Set this to allow for command line history if readline is available.  This
#   can be as simple as $var_dir/history.py to put the file in the var directory.
#
# [*dirs*]
#   Important directories for Mailman operation.  These are defined here so that
#   different layouts can be supported.   For example, a developer layout would
#   be different from a FHS layout.  Most paths are based off the var_dir, and
#   often just setting that will do the right thing for all the other paths.
#   You might also have to set spool_dir though.
#
#   Substitutions are allowed, but must be of the form $var where 'var' names a
#   configuration variable in the paths.* section.  Substitutions are expanded
#   recursively until no more $-variables are present.  Beware of infinite
#   expansion loops!
#
# [*pid_file*]
#   This is where PID file for the master runner is stored.
#
# [*lock_file*]
#   Lock file.
#
# [*database*]
#   The database type. It will be converted in the right class implementing
#   the IDatabase.
#
# [*database_params*]
#   Database parameters (the hash content varies with the database type, 
#   containing for example the host, user, password etc)
#
# [*debug*]
#   Debug
#
# [*format*]
#   Log format string.
#
# [*datefmt*]
#   Log date format string.
#
# [*propagate*]
#   Boolean specifying whether to propagate log message from this
#   logger to the root "mailman" logger.  You cannot override
#   settings for the root logger.
#
# [*level*]
#   Overrides the default level; this may be any of the
#   standard Python logging levels.
#
# [*path*]
#   Overrides the default logger path.  This may be a relative
#   path name, in which case it is relative to Mailman's LOG_DIR,
#   or it may be an absolute path name.  You cannot change the
#   handler class that will be used.
#
# [*hostname*]
#   The hostname at which admin web service resources are exposed.
#
# [*port*]
#   The port at which the admin web service resources are exposed.
#
# [*use_https*]
#   Whether or not requests to the web service are secured through SSL.
#
# [*show_tracebacks*]
#   Whether or not to show tracebacks in an HTTP response for a request that
#   raised an exception.
#
# [*api_version*]
#   The API version number for the current (highest) API.
#
# [*admin_user*]
#   The administrative username.
#
# [*admin_pass*]
#   The administrative password.
#
# [*mta*]
#   The Mail Transport Agent type. It will be converted in the right class
#   defining the interface to the incoming mail transport agent.
#
# [*outgoing*]
#   The callable implementing delivery to the outgoing mail transport agent.
#   This must accept three arguments, the mailing list, the message, and the
#   message metadata dictionary.
#
# [*smtp_hostname*]
#   The host to connect to the outgoing MTA.
#
# [*smtp_port*]
#   The TCP port to connect to the outgoing MTA.
#
# [*smtp_user*]
#   If smtp_user and smtp_pass is given, then Mailman will attempt to log into 
#   the MTA when making a new connection.
#
# [*smtp_pass*]
#   If smtp_user and smtp_pass is given, then Mailman will attempt to log into 
#   the MTA when making a new connection.
#
# [*lmtp_hostname*]
#   Where the LMTP server listens for connections.  Use 127.0.0.1 instead of
#   localhost for Postfix integration, because Postfix only consults DNS
#   (e.g. not /etc/hosts).
#
# [*lmtp_port*]
#   The LMTP TCP port.
#
# [*mm_package*]
#   Mailman package name.
#
# [*mm_username*]
#   Mailman user name.
#
# [*mm_groupname*]
#   Mailman group name.
#
# [*mm_service*]
#   Mailman service name.
#
# [*enable_service*]
#   Although it's possible to have a Mailman database shared among multiple
#   hosts, you *must not* enable the qrunners on more than one server at a
#   time. In a single server setup this should be enabled. In a multi-server
#   setup, ensure that only one node has this enabled. This is effectively
#   the same as "systremctl start mailman3.service".
#
# [*mailman_site_list*]
#   Name of the default mailing list for this site,
#
# [*bin_dir*]
#   Directory containing Mailman binaries.
#
# === Examples
#
#  include mailman3
#
# === Authors
#
# Ugo Paternostro <ugo.git@paternostro.org>
#
# === Copyright
#
# Copyright 2024 Ugo Paternostro, unless otherwise noted.
#
class mailman3 (
  $site_owner                         = $mailman3::params::site_owner,
  $noreply_address                    = $mailman3::params::noreply_address,
  $default_language                   = $mailman3::params::default_language,
  $sender_headers                     = $mailman3::params::sender_headers,
  $email_commands_max_lines           = $mailman3::params::email_commands_max_lines,
  $pending_request_life               = $mailman3::params::pending_request_life,
  $cache_life                         = $mailman3::params::cache_life,
  $pre_hook                           = $mailman3::params::pre_hook,
  $post_hook                          = $mailman3::params::post_hook,
  $layout                             = $mailman3::params::layout,
  $filtered_messages_are_preservable  = $mailman3::params::filtered_messages_are_preservable,
  $html_to_plain_text_command         = $mailman3::params::html_to_plain_text_command,
  $listname_chars                     = $mailman3::params::listname_chars,
  $prompt                             = $mailman3::params::prompt,
  $banner                             = $mailman3::params::banner,
  $use_ipython                        = $mailman3::params::use_ipython,
  $history_file                       = $mailman3::params::history_file,
  $dirs                               = $mailman3::params::dirs,
  $pid_file                           = $mailman3::params::pid_file,
  $lock_file                          = $mailman3::params::lock_file,
  $database                           = $mailman3::params::database,
  $database_params                    = $mailman3::params::database_params,
  $debug                              = $mailman3::params::debug,
  $format                             = $mailman3::params::format,
  $datefmt                            = $mailman3::params::datefmt,
  $propagate                          = $mailman3::params::propagate,
  $level                              = $mailman3::params::level,
  $path                               = $mailman3::params::path,
  $hostname                           = $mailman3::params::hostname,
  $port                               = $mailman3::params::port,
  $use_https                          = $mailman3::params::use_https,
  $show_tracebacks                    = $mailman3::params::show_tracebacks,
  $api_version                        = $mailman3::params::api_version,
  $admin_user                         = $mailman3::params::admin_user,
  $admin_pass                         = $mailman3::params::admin_pass,
  $mta                                = $mailman3::params::mta,
  $outgoing                           = $mailman3::params::outgoing,
  $smtp_hostname                      = $mailman3::params::smtp_hostname,
  $smtp_port                          = $mailman3::params::smtp_port,
  $smtp_user                          = $mailman3::params::smtp_user,
  $smtp_pass                          = $mailman3::params::smtp_pass,
  $lmtp_hostname                      = $mailman3::params::lmtp_hostname,
  $lmtp_port                          = $mailman3::params::lmtp_port,
  $mm_package                         = $mailman3::params::mm_package,
  $mm_username                        = $mailman3::params::mm_username,
  $mm_groupname                       = $mailman3::params::mm_groupname,
  $mm_service                         = $mailman3::params::mm_service,
  $enable_service                     = $mailman3::params::enable_service,
  $mailman_site_list                  = $mailman3::params::mailman_site_list,
  $bin_dir                            = $mailman3::params::bin_dir,
) inherits mailman3::params {
  $langs = ['ar','ca','cs','da','de','en','es','et','eu','fi','fr','gl','he',
    'hr','hu','ia','it','ja','ko','lt','nl','no','pl','pt','pt_BR','ro',
    'ru','sk','sl','sr','sv','tr','uk','vi','zh_CN','zh_TW']
  validate_email_address($site_owner)
  validate_re($database, ['SQLite', 'MySQL', 'PostgreSQL'])
  validate_hash($database_params)
  validate_re($mta, ['Exim4', 'Postfix', 'Sendmail'])
  validate_domain_name($smtp_hostname)
  validate_integer($smtp_port, 65535, 0)
#  validate_domain_name($lmtp_hostname)
  validate_integer($lmtp_port, 65535, 0)
  validate_re($default_language, $langs)
  validate_integer($email_commands_max_lines)
  validate_re($filtered_messages_are_preservable, ['^yes$', '^no$'])
  validate_re($use_ipython, ['^yes$', '^no$', '^debug$'])
  validate_hash($dirs)
  validate_absolute_path($pid_file)
#  validate_absolute_path($lock_file)
  validate_re($debug, ['^yes$', '^no$'])
  validate_re($propagate, ['^yes$', '^no$'])
  validate_re($level, ['^(?i)notset$', '^(?i)debug$', '^(?i)info$', '^(?i)warn$', '^(?i)error$', '^(?i)critical$'])
  validate_domain_name($hostname)
  validate_integer($port, 65535, 0)
  validate_re($use_https, ['^yes$', '^no$'])
  validate_re($show_tracebacks, ['^yes$', '^no$'])
  validate_bool($enable_service)

  package { $mm_package:
    ensure  => installed,
  }

  include mailman3::config

  $var_dir = $dirs[var_dir]

  file { 'var_dir':
    path    => $var_dir,
    ensure  => directory,
    owner   => 'root',
    group   => $mm_groupname,
    mode    => '0755',
    seltype => 'mailman_data_t',
    require => Package[$mm_package],
  }
  
  $dirs.each |$key, $value| {
    if ($key != "var_dir") {
      file { $key:
        path    => regsubst($value, '\$var_dir', $var_dir, 'G'),
        ensure  => directory,
        owner   => $mm_username,
        group   => $mm_groupname,
        mode    => '0755',
        seltype => 'mailman_data_t',
        require => [
          Package[$mm_package],
          File[var_dir],
        ],
      }
    }
  }
  
  # If the site list doesn't exist already, then it is created
  exec { 'create_site_list':
    command => "mailman create --language $default_language --owner $site_owner --notify '$mailman_site_list'",
    path    => "/bin:$bin_dir",
    unless  => "mailman lists | grep '$mailman_site_list'",
    user    => $mm_username,
    group   => $mm_groupname,
    require => [ Package[$mm_package], File['mailman.cfg'] ],
  }

  service { $mm_service:
    ensure  => $enable_service,
    enable  => $enable_service,
    require => [ Package[$mm_package], File['mailman.cfg'] ],
  }
}
