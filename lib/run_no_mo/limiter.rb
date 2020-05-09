module RunNoMo
  class LimitExceeded < StandardError; end

  class Limiter
    def initialize(times:, within:, raises:)
      @times = times
      @count = 0

      @within = within
      @last_run = nil

      @raises = raises
    end

    def run(&block)
      if reset_counter?
        @count = 0
      else
        @count+= 1
      end

      @last_run = Time.now

      return limit_exceeded! if @count > @times
      
      block.call
    end

    private

    def limit_exceeded!
      raise LimitExceeded.new if @raises
    end

    def reset_counter?
      return false if @within.nil?

      return false if @last_run.nil?

      return false if (Time.now - @last_run) < @within

      true
    end
  end
end
