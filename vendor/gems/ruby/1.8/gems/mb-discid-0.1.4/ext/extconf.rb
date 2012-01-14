#!/usr/bin/env ruby
# $Id: extconf.rb 68 2007-06-03 14:12:21Z phw $

require 'mkmf'

if have_library('discid', 'discid_new') or
   have_library('discid.dll', 'discid_new')
  # Remove -MD from compiler flags on Windows.
  $CFLAGS.sub!('-MD', '') if RUBY_PLATFORM.include? 'win32'
  create_makefile('MB_DiscID')
else
  puts 'Required library libdiscid not found.'
end