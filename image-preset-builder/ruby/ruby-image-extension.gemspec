# frozen_string_literal: true

require_relative "lib/image_extension/version"

Gem::Specification.new do |spec|
  spec.name = "contentstack_image_extension"
  spec.version = Contentstack::VERSION
  spec.authors = ["Uttam Krishna Ukkoji"]
  spec.email = ["uttamukkoji@gmail.com"]

  spec.summary = "Image extension utility functions."
  spec.description = "This lib contains all the image extension utility functions that will help to generate image url from the extension schema."
  spec.homepage = "https://contentstack.com"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://contentstack.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/contentstack/app-utils"
  spec.metadata["changelog_uri"] = "http://github.com/contentstack/app-utils/ruby-image-extension/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
end
