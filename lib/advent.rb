# frozen_string_literal: true

require 'pry'
require_relative "advent/version"
require_relative "advent/helper"

# Dynamicly load my day classes
dir = File.join(Dir.pwd, "lib", "advent")
Dir.entries(dir).each do |entry|
  next if !File.file?(File.join(dir, entry))
  next if !entry.start_with?("day")

  s = "advent/#{entry.gsub('.rb', '')}"
  require_relative s
end

module Advent
  class Error < StandardError; end

  class << self
    def new_day(day)
      if File.exists?(File.join(lib_advent_path, file_name_for_day(day)))
        puts "File already exists"
        return
      end
      
      File.open(File.join(lib_advent_path, file_name_for_day(day)), "w+") do |f|
        f.write klass_contents(day)
      end

      puts "Created class for day #{day}"
    end

    private

    def file_name_for_day(day)
      "day_#{day}.rb"
    end

    def lib_advent_path
      File.join(app_path, "lib", "advent")
    end

    def app_path
      File.join(Dir.pwd)
    end

    def klass_contents(day)
      <<-EOS
class Advent::Day#{day}
  include Advent::Helper

  RUN = %i(run)

  def run
    "run"
  end
end
EOS
    end
  end
end
