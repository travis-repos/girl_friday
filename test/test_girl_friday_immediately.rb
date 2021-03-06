require 'helper'

class TestGirlFridayImmediately < MiniTest::Unit::TestCase

  def setup
    GirlFriday::WorkQueue.immediate!
  end

  def teardown
    GirlFriday::WorkQueue.queue!
  end

  def test_should_process_immediately
    queue = GirlFriday::WorkQueue.new('now') do |msg|
      msg[:start] + 1
    end
    assert_equal 42, queue.push(:start => 41)
    assert_equal 42, queue << { :start => 41 }
  end

  def test_should_process_immediately_with_callback
    queue = GirlFriday::WorkQueue.new('now') do |msg|
      msg[:start] + 1
    end
    assert_equal 43, queue.push(:start => 41) { |r| r + 1 }
  end

end
