require 'pathname'

module CodeStatistics
  class CodeStatistics #:nodoc:

    FILTER = /.*\.(rb|feature)$/

    attr_reader :print_buffer

    def initialize(pairs, ignore_file_globs = [])
      @pairs        = pairs
      @test_types   = []
      @print_buffer = "" 
      directory     = Dir.pwd
      @ignore_files = collect_files_to_ignore(ignore_file_globs)

      @pairs = remove_duplicate_pairs(@pairs)

      directories_to_search = ['app','test','spec','merb', 'bin']
      directories_to_search = remove_included_pairs(directories_to_search, @pairs)
      recursively_add_directories(directories_to_search)
      add_test_types(@pairs)
      
      @statistics  = calculate_statistics
      @total       = calculate_total if pairs.length > 1
    end

    def recursively_add_directories(dirs)
      dirs.each do |dir|
        if File.directory?(dir)
          entries = Dir.entries(dir)
          entries = entries.reject{ |entry| entry=='.' || entry=='..' }
          has_directories = add_sub_directory(entries, dir)
          @pairs << [dir, dir] unless has_directories
        end
      end
    end

    def add_sub_directory(entries, dir)
      has_directories = false
      entries = entries.reject{ |entry| entry=='.' || entry=='..' }
      entries.each do |entry|
        entry_path = File.join(dir,entry)
        if File.directory?(entry_path) 
          if Dir.entries(entry_path).select{|path| path.match(FILTER)}.length > 0
            @pairs << [entry_path, entry_path]
            has_directories = true
          else
            sub_has_directories = add_sub_directory(Dir.entries(entry_path), entry_path)
            has_directories = true if sub_has_directories
            if sub_has_directories == false && Dir.entries(entry_path).select{|path| path.match(FILTER)}.length > 0
              @pairs << [entry_path, entry_path]
              has_directories = true
            end
          end
        end
      end
      has_directories
    end

    def collect_files_to_ignore(ignore_file_globs)
      files_to_remove = []
      ignore_file_globs.each do |glob|
        files_to_remove.concat(Dir[glob])
      end
      files_to_remove.map{ |filepath| File.expand_path(filepath)}
    end
    
    def to_s
      @print_buffer = ''
      print_header
      @pairs.each { |pair| print_line(pair.first, @statistics[pair.first]) }
      print_splitter
      
      if @total
        print_line("Total", @total)
        print_splitter
      end
      
      print_code_test_stats
      @print_buffer
    end
    
    private

    #user supplied paths and set paths might slight differ like path/name and path/name/ this filters those out
    def remove_duplicate_pairs(pairs)
      unique_pairs = []
      paths = pairs.map{|pair| [pair.first, Pathname.new(pair.last).realpath.to_s] }
      paths.each{|path| unique_pairs << path unless unique_pairs.map{|u_path| u_path.last}.include?(path.last)}
      unique_pairs
    end

    def add_test_types(pairs)
      pairs.each do |key, dir_path|
        add_test_type(key) if dir_path.match(/^test/) || dir_path.match(/^spec/) || dir_path.match(/^features/) || 
          dir_path.match(/test$/) || dir_path.match(/spec$/) || dir_path.match(/features$/)
      end
    end

    def remove_included_pairs(directories_to_search, pairs)
      #if the user explicitly said to index the directory index it at the level specified not recursively
      directories_to_search.reject{|dir| @pairs.map{|pair| pair.first}.include?(dir)}
    end

    def local_file_exists?(dir,filename)
      File.exist?(File.join(dir,filename))
    end

    def calculate_statistics
      @pairs.inject({}) { |stats, pair| stats[pair.first] = calculate_directory_statistics(pair.last); stats }
    end

    def test_types
      @test_types.uniq
    end

    def add_test_type(test_type)
      @test_types << test_type
    end
    
    def ignore_file?(file_path)
      @ignore_files.include?(File.expand_path(file_path))
    end

    def calculate_directory_statistics(directory, pattern = FILTER)
      stats = { "lines" => 0, "codelines" => 0, "classes" => 0, "methods" => 0 }

      Dir.foreach(directory) do |file_name|
        if File.stat(directory + "/" + file_name).directory? and (/^\./ !~ file_name)
          newstats = calculate_directory_statistics(File.join(directory,file_name), pattern)
          stats.each { |k, v| stats[k] += newstats[k] }
        end
        
        next unless file_name =~ pattern
        file_path = File.join(directory, file_name)
        next if ignore_file?(file_path)
        
        f = File.open(file_path)
        
        while line = f.gets
          stats["lines"] += 1
          stats["classes"] += 1 if line =~ /class [A-Z]/
          stats["methods"] += 1 if line =~ /(def [a-z]|should .* do|test .* do|it .* do)/
          stats["codelines"] += 1 unless line =~ /^\s*$/ || line =~ /^\s*#/
        end
      end
      
      stats
    end
    
    def calculate_total
      total = { "lines" => 0, "codelines" => 0, "classes" => 0, "methods" => 0 }
      @statistics.each_value { |pair| pair.each { |k, v| total[k] += v } }
      total
    end
    
    def calculate_code
      calculate_type(false)
    end
    
    def calculate_tests
      calculate_type(true)
    end
    
    def calculate_type(test_match)
      type_loc = 0
      @statistics.each { |k, v| type_loc += v['codelines'] if test_types.include?(k)==test_match }
      type_loc
    end

    def print_header
      print_splitter
      @print_buffer << "| Name".ljust(22)+" "+
        "| Lines".ljust(8)+
        "| LOC".ljust(8)+
        "| Classes".ljust(10)+
        "| Methods".ljust(10)+
        "| M/C".ljust(6)+
        "| LOC/M".ljust(6)+
        " |\n"
      print_splitter
    end
    
    def print_splitter
      @print_buffer << "+----------------------+-------+-------+---------+---------+-----+-------+\n"
    end

    def x_over_y(top, bottom)
      result = (top / bottom) rescue result = 0
    end
    
    def print_line(name, statistics)
      m_over_c = x_over_y(statistics["methods"], statistics["classes"])
      loc_over_m = x_over_y(statistics["codelines"], statistics["methods"])
      loc_over_m = loc_over_m - 2 if loc_over_m >= 2

      start = if test_types.include? name
                "| #{name.ljust(20)} "
              else
                "| #{name.ljust(20)} "
              end
      
      if (statistics['lines']!=0)
        @print_buffer << start +
          "| #{statistics["lines"].to_s.rjust(5)} " +
          "| #{statistics["codelines"].to_s.rjust(5)} " +
          "| #{statistics["classes"].to_s.rjust(7)} " +
          "| #{statistics["methods"].to_s.rjust(7)} " +
          "| #{m_over_c.to_s.rjust(3)} " +
          "| #{loc_over_m.to_s.rjust(5)} |\n"
      end
    end
    
    def print_code_test_stats
      code = calculate_code
      tests = calculate_tests
      
      ratio = if code!=0
        "#{sprintf("%.1f", tests.to_f/code)}"
      else
        "0.0"
      end
      @print_buffer << " Code LOC: #{code}  Test LOC: #{tests}  Code to Test Ratio: 1:#{ratio}\n"
      @print_buffer << "\n"
    end
  end
end
