
# A class with no parameters
class test::linux {
  file { '/nginx/files/test.txt':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
}
