if $mongodb_values == undef { $mongodb_values = hiera_hash('mongodb', false) }
if $php_values == undef { $php_values = hiera_hash('php', false) }
if $apache_values == undef { $apache_values = hiera_hash('apache', false) }
if $nginx_values == undef { $nginx_values = hiera_hash('nginx', false) }

include puphpet::params

if hash_key_equals($apache_values, 'install', 1)
  or hash_key_equals($nginx_values, 'install', 1)
{
  $mongodb_webserver_restart = true
} else {
  $mongodb_webserver_restart = false
}

if hash_key_equals($mongodb_values, 'install', 1) {
  file { ['/data', '/data/db']:
    ensure => directory,
    mode   => '0775',
    before => Class['mongodb::globals'],
  }

  Class['mongodb::globals']
  -> Class['mongodb::server']

  class { 'mongodb::globals':
    manage_package_repo => true,
  }

  create_resources('class', {
    'mongodb::server' => $mongodb_values['settings']
  })

  if $::osfamily == 'redhat' {
    class { 'mongodb::client':
      require => Class['mongodb::server']
    }
  }

  each( $mongodb_values['databases'] ) |$key, $database| {
    $database_merged = delete(merge($database, {
      'dbname' => $database['name'],
    }), 'name')

    create_resources( puphpet::mongodb::db, {
      "${database['user']}@${database['name']}" => $database_merged
    })
  }

  if hash_key_equals($php_values, 'install', 1)
    and ! defined(Puphpet::Php::Pecl['mongo'])
  {
    puphpet::php::pecl { 'mongo':
      service_autorestart => $mongodb_webserver_restart,
      require             => Class['mongodb::server']
    }
  }
}
