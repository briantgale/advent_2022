module Advent::Helper

  def get_input(file_name)
    data = File.read(file_name)
    data.split("\n")
  end

end

