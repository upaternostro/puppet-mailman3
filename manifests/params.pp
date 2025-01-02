# == Class: mailman3::params
#
# This class is used to setup reasonable defaults for the essential parameters
# of a Mailman configuration.
#
# Unfortunately, Puppet manifests make it impossible to define parameters that
# have default values which derive from other parameters to the same class.
# The best workaround is to extract this logic into a "params" class and make
# other classes inherit from this one to be sure that all of these variables
# are realized. To have parameter defaults derive from other parameters more
# than one layer deep, you need to use multiple layers of inheritance. I try
# to keep it simple here, and only use one layer.
#
# To make things even more complicated, some distributions (especially RedHat)
# have changed defaults and added new variables toward the goal of being
# FHS compliant. http://wiki.list.org/pages/viewpage.action?pageId=8486957
#
# === Examples
#
# include mailman3::params
#
# === Authors
#
# Ugo Paternostro <ugo.git@paternostro.org>
#
# === Copyright
#
# Copyright 2024 Ugo Paternostro, unless otherwise noted.
#
class mailman3::params {
  $enable_service = false
  
  case $::osfamily {
    'Debian': {
      $prefix                             = '/usr/lib/mailman3'
      $exec_prefix                        = $prefix

      $wrapper_dir                        = "${exec_prefix}/mail"
      $bin_dir                            = "${prefix}/bin"
      $scripts_dir                        = "${prefix}/scripts"

      $site_owner                         = undef
      $noreply_address                    = 'noreply'
      $default_language                   = 'en'
      $sender_headers                     = [ 'from', 'from_', 'reply-to', 'sender' ]
      $email_commands_max_lines           = 10
      $pending_request_life               = '3d'
      $cache_life                         = '7d'
      $pre_hook                           = undef
      $post_hook                          = undef
      $layout                             = 'debian'
      $filtered_messages_are_preservable  = 'no'
      $html_to_plain_text_command         = '/usr/bin/lynx -dump $filename'
      $listname_chars                     = '[-_.0-9a-z]'
      $prompt                             = '>>>'
      $banner                             = 'Welcome to the GNU Mailman shell'
      $use_ipython                        = 'no'
      $history_file                       = undef
      $dirs                               = {
                                              # This is the root of the directory structure that Mailman will use to store
                                              # its run-time data.
                                              var_dir => '/var/lib/mailman3',
                                              # This is where the Mailman queue files directories will be created.
                                              queue_dir => '$var_dir/queue',
                                              # This is the directory containing the Mailman 'runner' and 'master' commands
                                              # if set to the string '$argv', it will be taken as the directory containing
                                              # the 'mailman' command.
                                              bin_dir => '/usr/lib/mailman3/bin',
                                              # All list-specific data.
                                              list_data_dir => '$var_dir/lists',
                                              # Directory where log files go.
                                              log_dir => '/var/log/mailman3',
                                              # Directory for system-wide locks.
                                              lock_dir => '$var_dir/locks',
                                              # Directory for system-wide data.
                                              data_dir => '$var_dir/data',
                                              # Cache files.
                                              cache_dir => '$var_dir/cache',
                                              # Directory for configuration files and such.
                                              etc_dir => '/etc/mailman3',
                                              # Directory containing Mailman plugins.
                                              ext_dir => '$var_dir/ext',
                                              # Directory where the default IMessageStore puts its messages.
                                              messages_dir => '$var_dir/messages',
                                              # Directory for archive backends to store their messages in.  Archivers should
                                              # create a subdirectory in here to store their files.
                                              archive_dir => '$var_dir/archives',
                                              # Root directory for site-specific template override files.
                                              template_dir => '$var_dir/templates',
                                            }
      $pid_file                           = '/run/mailman3/master.pid'
      $lock_file                          = '$lock_dir/master.lck'
      $database                           = "SQLite"
      $database_params                    = { 'path' => '$DATA_DIR/mailman.db' }
      $debug                              = 'no'
      $format                             = '%(asctime)s (%(process)d) %(message)s'
      $datefmt                            = '%b %d %H:%M:%S %Y'
      $propagate                          = 'no'
      $level                              = 'info'
      $path                               = 'mailman.log'
      $hostname                           = 'localhost'
      $port                               = 8001
      $use_https                          = 'no'
      $show_tracebacks                    = 'yes'
      $api_version                        = '3.1'
      $admin_user                         = 'restadmin'
      $admin_pass                         = undef
      $mta                                = "Postfix"
      $outgoing                           = 'mailman.mta.deliver.deliver'
      # Mailman requires two more DNS labels but Debian systems
      # only use single label "localhost" name.
      $smtp_hostname                      = "mail.${::hostname}"
      $smtp_port                          = 25
      $smtp_user                          = undef
      $smtp_pass                          = undef
      $lmtp_hostname                      = '127.0.0.1'
      $lmtp_port                          = 8024
      $mm_package                         = 'mailman3'
      $mm_username                        = 'list'
      $mm_groupname                       = 'list'
      $mm_service                         = 'mailman3'
      
      $mailman_site_list                  = 'mailman' # Allows chars are [-+_.=a-z0-9] (see $listname_chars)
    }
    default: {
      fail("Mailman3 module is not supported on ${::osfamily}.")
    }
  }
}
