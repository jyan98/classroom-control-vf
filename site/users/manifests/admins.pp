class users::admins {
users::managed_user { 'jack': }
users::managed_user { 'lynne':
group => 'staff',
}
users::managed_user { 'kieth':
group => 'staff',
}
group { 'staff':
ensure => present,
}
}
