# This class is called from kibana to configure the daemon's configuration
# file.
# It is not meant to be called directly.
#
# @author Tyler Langlois <tyler.langlois@elastic.co>
#
class kibana::config {

  if $::kibana::configdir {
    $_config_dir = $::kibana::configdir
  } else {
    $_config_dir = $::kibana::repo_version ? {
      /^4[.]/ => '/opt/kibana/config',
      default => '/etc/kibana'
    }
  }
  $_ensure = $::kibana::ensure ? {
    'absent' => $::kibana::ensure,
    default  => 'file',
  }
  $config = $::kibana::config

  file { '/etc/kibana/kibana.yml':
    ensure  => $_ensure,
    content => template("${module_name}/etc/kibana/kibana.yml.erb"),
    owner   => $::kibana::kibana_user,
    group   => $::kibana::kibana_user,
    mode    => '0660',
  }
}
