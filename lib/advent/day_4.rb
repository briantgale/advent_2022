class Advent::Day4
  include Advent::Helper

  RUN = %i(number_fully_overlapping number_partial_overlapping)

  # The first part of the challenge - figure out which of the groups fully contain
  # the other. You have to check both combinations for this to work
  #
  # @return [Integer] count of groups
  def number_fully_overlapping
    overlapping = get_input("input_day_4.txt").select do |line|
      a, b = line.split(",")
      group_contains?(a, b) || group_contains?(b, a)
    end
    
    overlapping.count
  end

  # The second part of the challenge - figure out how many of the line items have
  # any overlap at all
  #
  # @return [Integer] count of groups
  def number_partial_overlapping
    get_input("input_day_4.txt")
      .select { |line| groups_overlap?(*line.split(",")) }
      .count
  end

  private

  # Determines if 2 groups from the challenge overlap at all
  #
  # @param group_a [String] string representing the first group
  # @param group_b [String] string representing the second group
  # @return [Boolean] whether or not the groups overlap at all
  def groups_overlap?(group_a, group_b)
    a = group_to_range(group_a)
    b = group_to_range(group_b)
    (a.to_a & b.to_a).any?
  end

  # Determines if a group fully contains another group
  #
  # @param group [String] string representing the range that might contain another range
  # @param subgroup [String] string representing a range that might be contained by another
  # @return [Boolean] whether or not the subgroup is fully contained by the group
  def group_contains?(group, subgroup)
    group_range = group_to_range(group)
    sgroup_range = group_to_range(subgroup)

    group_range.cover?(sgroup_range)
  end

  # Translate the string from the puzzle input into a range object
  #
  # @param group [String] the string from the challenge
  # @return [Range] a range object
  def group_to_range(group)
    s, e = group.split("-").map(&:to_i)
    s..e
  end
end
