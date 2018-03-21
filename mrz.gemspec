
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mrz/version"

Gem::Specification.new do |spec|
  spec.name          = "mrz"
  spec.version       = MRZ::VERSION
  spec.authors       = ["Streetspotr GmbH"]
  spec.email         = ["devs@streetspotr.com"]

  spec.summary       = %q{Small library to read and parse MRZ codes on passports and ID cards}
  spec.description   = %q{Small library to read and parse MRZ codes on passports and ID cards}
  spec.homepage      = "https://github.com/streetspotr/mrz"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
