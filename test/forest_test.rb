require_relative "test_helper"

class ForestTest < Minitest::Test
  def test_scores
    forest = Rcf::Forest.new(3)

    scores = []
    200.times do |i|
      point = [rand, rand, rand]

      # make the second to last point an anomaly
      if i == 198
        point[1] = 2
      end

      scores << forest.score(point)
      forest.update(point)
    end

    assert_in_delta 0, scores[0]
    assert_in_delta 0, scores[63]
    assert_operator scores[64], :>, 0.5
    assert_operator scores[-3], :<, 1.2
    assert_operator scores[-2], :>, 3
    assert_operator scores[-1], :<, 1.2
  end

  def test_bad_size
    forest = Rcf::Forest.new(3)
    error = assert_raises(ArgumentError) do
      forest.score([1])
    end
    assert_equal "Bad size", error.message
  end
end
