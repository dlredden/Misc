#!/usr/bin/ruby

# in a ruby script
Config::CONFIG.keys.sort_by{|k| k.upcase}.each do |k|
  puts "#{k}: #{Config::CONFIG[k]}"
end
