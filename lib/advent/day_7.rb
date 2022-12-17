class Advent::Day7
  include Advent::Helper
  RUN = %i(small_sum size_to_delete)

  FS_SIZE = 70000000
  FREE_NEEDED = 30000000

  def initialize
    @fs = FileSys.new
    @fs.build_with_instructions(get_input("input_day_7.txt"))
    @sums = get_all_sums(@fs.fs)
  end

  # Part 1 of the puzzle - figure out what directories (and their children) are
  # less than 100000 and sum them all up for the answer
  #
  # @return [Integer] the sum of the small dirs
  def small_sum
    @sums.select { |s| s < 100000 }.reduce(:+)
  end

  # Part 2 of the puzzle - figure out what is the smallest directory size to delete
  # to free up just enough space to get enough space
  #
  # @return [Integer] the smallest directory size to delete to get over the threshold
  def size_to_delete
    unused_space = FS_SIZE - file_sum_dir(@fs.fs)

    @sums.sort.each do |space|
      return space if (unused_space + space) > FREE_NEEDED
    end
  end

  private

  # Recursively get the sums of all the directories in the filesystem
  # 
  # @param dir [OpenStruct] the dir object ot sum up
  # @return [Array] the summed up sizes
  def get_all_sums(dir)
    stuff = []
    stuff << file_sum_dir(dir)
    children = dir.dirs.map do |d|
      get_all_sums(d)
    end
    stuff += children
    stuff.flatten
  end
  
  # Gets the complete size of a directory and its sub directories
  #
  # @param dir [OpenStruct] directory
  # @return Integer the actual computed size
  def file_sum_dir(dir)
    sizes = []
    sizes << dir.files.map { |s| s.size }.reduce(&:+)
    sizes += dir.dirs.map { |d| file_sum_dir(d) }
    sizes.flatten.reject(&:nil?).reduce(&:+)
  end

  # This class is to make dealing with the filesystem representation easier. It
  # takes the puzzle input and builds the filesystem structure making it easier
  # to interact with.
  class FileSys
    attr_reader :fs

    def initialize
      @fs = new_dir("/")
      @current_loc = []
    end

    # Takes the input instructions as an array and builds out the filesystem
    # object for use later
    def build_with_instructions(instructions)
      instructions.each do |line|
        line.start_with?("$") ? process_command(line) : process_output(line)
      end
    end

    # For convenience, outputs the structure in a human readable format
    def structure
      output_dir(@fs)
    end

    private

    # The recursive guts of the structure output method
    #
    # @param dir [OpenStruct] the dir to output
    # @param indent: [Integer] the level to indent
    def output_dir(dir, indent: 0)
      i = " " * (indent * 2)
      puts "#{i}#{dir.name}"
      dir.files.each do |f|
        puts "#{i}  - #{f.name} (#{f.size})"
      end

      dir.dirs.each do |sub_dir|
        output_dir(sub_dir, indent: indent + 1)
      end
      nil
    end

    # Processes an output line and decides what to do with it, then calls the
    # method to deal with the data
    #
    # @param line [String] the data line
    def process_output(line)
      if line.match(/\d+.*/)
        append_file(*line.split(" "))
      else
        append_dir(line.split(" ").last)
      end
    end

    # Processes a command line and decides what to do with it
    #
    # @param line [String] the command line to parse
    def process_command(line)
      _, cmd, *params = line.split(/\s/)

      return nil if cmd == "ls"
      return cd(params.first) if cmd == "cd"

      raise "unknown command #{line}"
    end

    # Appends a file to the currently selected directory
    #
    # @param size [String] file size
    # @param name [String] file name
    def append_file(size, name)
      # puts "Appending file #{name} in dir /#{@current_loc.join('/')}"
      d = get_current_dir
      d.files << new_file(size.to_i, name)
    end

    # Appends a directory to the currently selected directory
    #
    # @param name [String] directory name
    def append_dir(name)
      # puts "Appending dir #{name} in dir /#{@current_loc.join('/')}"
      d = get_current_dir
      d.dirs << new_dir(name)
    end

    # Figures out and returns the current directory and returns it
    #
    # @return [OpenStruct] the current directory
    def get_current_dir
      current = @fs
      @current_loc.each { |l| current = current.dirs.detect { |i| i.name == l } }
      current
    end

    # Changes a directory for use later
    #
    # #param loc [String] the location from the input
    def cd(loc)
      return @current_loc.clear if loc == "/"
      return @current_loc.pop if loc == ".."
      @current_loc << loc 
    end

    # Creates an object that represents a directory
    #
    def new_file(size, name)
      OpenStruct.new(type: "file", size: size.to_i, name: name)
    end

    # Create a n object that represents a file
    #
    def new_dir(name)
      OpenStruct.new(type: "dir", name: name, dirs: [], files: [])
    end

  end
  # End FileSys
end
