require "./lib/check_files/version"

Gem::Specification.new do |spec|
  spec.name          = "check_files"
  spec.version       = CheckFiles::VERSION
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["fnando.vieira@gmail.com"]

  spec.summary       = "Check non-reloadable files changes on Rails apps"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/fnando/check_files"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest-utils"
  spec.add_development_dependency "rails"
  spec.add_development_dependency "pry-meta"
  spec.add_development_dependency "codeclimate-test-reporter"
end