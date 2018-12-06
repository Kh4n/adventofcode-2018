require 'set'

input = File.read("input").split("\n").map(&:to_i)

puts input.sum

# For a faster way to do part 2, see:
# https://www.reddit.com/r/adventofcode/comments/a20646/2018_day_1_solutions/eaukxu5/
# Summary: Track cumulative sum for one cycle through the input.
# Note that all future iterations are offset by the total delta for one cycle.
# The first repeated value *must* be one of the cumulative sums from the first cycle.

freq = 0
seen = Set.new

input.cycle { |delta|
  freq += delta
  (puts freq; break) if seen.include?(freq)
  seen << freq
}

def test (b)
    return b
end