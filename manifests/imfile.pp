# == Define: rsyslog::imfile
#
# Full description of class role here.
#
# === Parameters
#
# [*file_name*]
# [*file_tag*]
# [*file_facility*]
# [*polling_interval*]
# [*file_severity*]
# [*run_file_monitor*]
# [*persist_state_interval]
# [*imfile_config_template_file*]
#
# === Variables
#
# === Examples
#
#  rsyslog::imfile { 'my-imfile':
#    file_name     => '/some/file',
#    file_tag      => 'mytag',
#    file_facility => 'myfacility',
#  }
#
define rsyslog::imfile(
  $file_name,
  $file_tag,
  $file_facility,
  $polling_interval = 10,
  $file_severity = 'notice',
  $run_file_monitor = true,
  $persist_state_interval = 0,
  $imfile_config_template_file = 'rsyslog/imfile.erb',
) {


  include rsyslog
  $extra_modules = $rsyslog::extra_modules

  file { "${rsyslog::rsyslog_d}${name}.conf":
    ensure  => file,
    owner   => 'root',
    group   => $rsyslog::run_group,
    content => template($imfile_config_template_file),
    require => Class['rsyslog::install'],
    notify  => Class['rsyslog::service'],
  }

}
