#!/usr/bin/ruby 
require 'net/ssh'

#session = Net::SSH.start("blog.odeit.com","u47823749")
session = Net::SSH.start("wikidlabs.com","dlredden", :password => "alicia234")
#session = Net::SSH.start("blog.odeit.com","u47823749", :password => "m0ng00s3")
session.exec("ls -l")
session.close()
