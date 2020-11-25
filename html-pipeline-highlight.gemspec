require_relative 'lib/html/pipeline/highlight/version'

Gem::Specification.new do |spec|
  spec.name          = "html-pipeline-highlight"
  spec.version       = HTML::Pipeline::Highlight::VERSION
  spec.authors       = ["aki77"]
  spec.email         = ["aki77@users.noreply.github.com"]

  spec.summary       = %q{Highlight filter for html-pipeline.}
  spec.description   = %q{Highlight filter for html-pipeline.}
  spec.homepage      = "https://github.com/aki77/html-pipeline-highlight"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aki77/html-pipeline-highlight"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "html-pipeline"
end
