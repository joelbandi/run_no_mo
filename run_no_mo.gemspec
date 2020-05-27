
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "run_no_mo/version"

Gem::Specification.new do |spec|
  spec.name          = "run_no_mo"
  spec.version       = RunNoMo::VERSION
  spec.authors       = ["Joel Bandi"]
  spec.email         = ["joelvivekbandi@gmail.com"]
  spec.license       = "MIT"
  spec.summary       = "Rate limit execution of code."

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'activesupport', '>= 5', '< 7'
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
