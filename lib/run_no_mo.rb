require "run_no_mo/version"
require "run_no_mo/limiter"
require "active_support/all"

module RunNoMo
  def self.limit(times:, within: nil, raises: false)
    Limiter.new(times: times, within: within, raises: raises)
  end
end
