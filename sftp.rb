#!/usr/bin/ruby 
require 'net/sftp'

class Ftpobject
	attr_accessor :file_name, :path, :size, :level, :dir
	alias dir? dir
end

Net::SFTP.start("odeubu1","dlredden", :password => "alicia234") do |sftp|
	sftp.dir.foreach("fs_in_database/vendor/plugins/ftpzee") do |entry|
		puts entry.longname
	end

end

@ftp = Net::SFTP.start("localhost","dlredden", :password => "alicia234")
#@ftp = Net::FTP.new("ftp.eversions.com","ode","mong00s3")

def list_dir(path, level = 0, ret = [])
	@files = @ftp.dir.glob(path).sort { |x,y| 
		if ((y =~ /^d/ && x =~ /^d/) || (y !~ /^d/ && x !~ /^d/))
			y.split(/\s+/)[-1].downcase <=> x.split(/\s+/)[-1].downcase
		elsif (x =~ /^d/)
			1
		else
			-1
		end
	}

	@files.reverse.each { |file|
        	@attributes = file.split(/\s+/)
		my_object = Ftpobject.new()

        	if (file =~ /^d/)
			my_object.dir = true
			my_object.level = level
			my_object.file_name = @attributes[-1]
			my_object.path = path
			ret.push(my_object)
			list_dir("#{path}/#{@attributes[-1]}", level + 1, ret) 
        	else
			my_object.dir = false
			my_object.level = level
			my_object.file_name = @attributes[-1]
                        my_object.path = path
                        my_object.size = @ftp.size("#{path}/#{@attributes[-1]}")
                        ret.push(my_object)
        	end
	}
	ret
end

raise "Unsupported OS '#{@ftp.system().chomp()}'" if (@ftp.system() !~ /UNIX/) 
list_dir("fs_in_database/vendor/plugins/ftpzee", 0).each { |obj|
	p obj
}
