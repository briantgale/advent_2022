class Advent::Day8
  include Advent::Helper

  RUN = %i(visible_trees best_scenic_score)

  # Part 1 - count the number of trees that are visible from the edges of the grove of trees
  #
  # @return [Integer]
  def visible_trees
    visible_count = 0

    forest.each_with_index do |row, row_i|
      row.each_with_index do |_, col_i|
        p = [row_i, col_i]
        r = visible_left?(*p) || visible_right?(*p) || visible_up?(*p) || visible_down?(*p)
        visible_count += 1 if r
      end
    end

    visible_count
  end

  def best_scenic_score
    scores = []
    forest.each_with_index do |row, row_i|
      row.each_with_index do |_, col_i|
        p = [row_i, col_i]
        r = [score_left(*p), score_right(*p), score_down(*p), score_up(*p)]
        scores << r.reduce(:*)
      end
    end
    scores.sort.last
  end
  # 1362816 too high


  private

  def score_right(row_i, col_i)
    return 0 if col_i == forest_width - 1

    tree = forest[row_i][col_i]
    score = 1
    forest[row_i][(col_i + 1)..(forest_width - 1)].each do |n|
      if n < tree
        score += 1
      else
        break
      end
    end
    score
  end

  def score_left(row_i, col_i)
    return 0 if col_i == 0

    tree = forest[row_i][col_i]
    score = 1
    forest[row_i][0..(col_i - 1)].reverse.each do |n|
      if n < tree
        score += 1
      else
        break
      end
    end
    score
  end

  def score_down(row_i, col_i)
    return 0 if col_i == 0

    tree = forest[row_i][col_i]
    score = 1
    forest[(row_i + 1)..(forest_height - 1)].map { |r| r[col_i] }.each do |n|
      if n < tree
        score += 1
      else
        break
      end
    end
    score
  end

  def score_up(row_i, col_i)
    return 0 if row_i == forest_height - 1

    tree = forest[row_i][col_i]
    score = 1
    forest[0..(row_i-1)].map { |r| r[col_i] }.each do |n|
      if n < tree
        score += 1
      else
        break
      end
    end
    score
  end

  # Figure out if the given tree is visible from the left
  #
  # @param row_i [Integer] row index
  # @param col_i [Integer] col index
  # @return [Boolean] whether or not the tree is visible
  def visible_left?(row_i, col_i)
    return true if col_i == 0

    tree = forest[row_i][col_i]
    e = col_i - 1
    forest[row_i][0..e].select { |i| i >= tree }.empty?
  end

  # Figure out if the given tree is visible from the right
  #
  # @param row_i [Integer] row index
  # @param col_i [Integer] col index
  # @return [Boolean] whether or not the tree is visible
  def visible_right?(row_i, col_i)
    return true if col_i == forest_width - 1

    tree = forest[row_i][col_i]
    s = col_i + 1
    w = forest_width - 1
    forest[row_i][s..w].select { |i| i >= tree }.empty?
  end

  # Figure out if the given tree is visible from the top
  #
  # @param row_i [Integer] row index
  # @param col_i [Integer] col index
  # @return [Boolean] whether or not the tree is visible
  def visible_up?(row_i, col_i)
    return true if row_i == 0

    tree = forest[row_i][col_i]
    e = row_i - 1
    forest[0..e].map { |r| r[col_i] }.select { |i| i >= tree }.empty?
  end

  # Figure out if the given tree is visible from the bottom
  #
  # @param row_i [Integer] row index
  # @param col_i [Integer] col index
  # @return [Boolean] whether or not the tree is visible
  def visible_down?(row_i, col_i)
    return true if row_i == forest_height - 1
    
    tree = forest[row_i][col_i]
    s = row_i + 1
    e = forest_height - 1
    forest[s..e].map { |r| r[col_i] }.select { |i| i >= tree }.empty?
  end
  
  # Gets the forest layout and memoizes it
  #
  # @return [Array] forest
  def forest
    return @forest if @forest
    
    @forest = get_input("input_day_8.txt").map do |row|
      row.split("").map(&:to_i)
    end
  end

  # Gets the width of the forest and memoizes it
  #
  # @return [Integer] width
  def forest_width
    return @width if @width

    @width = forest.first.length
  end

  # Gets the height of the forest and memoizes it
  #
  # @return [Integer] height
  def forest_height
    return @height if @height

    @height = forest.length
  end
end
