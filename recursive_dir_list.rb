def get_directory_contents_recursively(node_path, level, recursive = true, depth = -1)
    @ret = [] 
    @excludes = [".", "..", ".svn"] # Ignore these files and directories
  
    if (!FileTest.directory?(node_path.to_s) || File.fnmatch(".*", node_path.to_s))
      raise(ArgumentError, "Value must be a directory")
    else
      Dir.entries(node_path).sort.each { |file|
        next if (@excludes.include?(file))
 	
        @full_path = node_path.to_s + "/" + file.to_s
  
        @ret += "#{level},{"
        @ret += "label: '#{file}'"
        @ret += ",expanded: false"
        @ret += ",fullName: '#{@full_path}'"
        @ret += ",nodePath: '#{node_path}'"
  
        if (FileTest.directory?(@full_path))
          @ret += ",isLeaf: false},"
          
          if (recursive)
            unless (depth == 0)
              @ret += get_directory_contents_recursively(@full_path, level + 1, recursive, depth - 1)
            end
          end
        else
          @fileExtension = File.extname(file)
          
          if (@fileExtension == "")
            @fileExtention = "txt"
          end
          
          @ret += ",labelStyle: 'icon-#{@fileExtention}'"
          @ret += ",isLeaf: true},"
        end
      }
      @ret
    end

p get_directory_contents_recursively("/s3/123456/1/newproject", 0, true, 1)
