require 'rubygems'
require 'net/ssh'

WWW = 'kpsu.org'
USER = 'seve'

basedir = "/usr/local/www/drupal/sites/all/modules/station/archive/import"
contains = Dir.new(basedir).entries
puts contains

Net::SSH.start( WWW, USER, :port => 6666 ) do |ssh|  
 puts ssh.exec('hostname')
 # test writing EOF
 # echo "soemthing blah blah blah directories from above (hint)" >> filename
 ssh.exec!('')
end
