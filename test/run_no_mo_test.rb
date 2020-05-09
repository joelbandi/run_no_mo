require "test_helper"

class RunNoMoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RunNoMo::VERSION
  end

  def test_limiter_limits__count
    #  create a limiter using factory
    limiter = RunNoMo.limit times: 5, raises: true
    
    # run 4 times
    4.times do
      limiter.run { noop }
    end

    # run 1 more time
    limiter.run { noop }
    
    # run once again NO-MO
    assert_raises RunNoMo::LimitExceeded do
      # does not get executed
      limiter.run { noop }
    end
  end

  def test_limiter__limiters__count__within
    limiter = RunNoMo::limit times: 2, within: 3.seconds, raises: true

    assert_raises RunNoMo::LimitExceeded do
      3.times do
        limiter.run { noop }
      end
    end

    limiter = RunNoMo::limit times: 2, within: 1.second, raises: true

    3.times do
      limiter.run { sleep 1 }
    end
  end

  def test_limiter_no_throw
    limiter = RunNoMo::limit times: 3

    count = 0

    5.times do
      limiter.run { count += 1 }
    end

    assert_equal 3, count
  end

  private

  def noop; end
end
