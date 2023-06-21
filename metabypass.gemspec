# -*- encoding: utf-8 -*-

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "metabypass"
  spec.version     = '1.0.0'
  spec.platform    = Gem::Platform::RUBY
  spec.licenses    = ['MIT']
  spec.authors     = ["Metabypass"]
  spec.email       = ["support@metabypass.tech"]
  spec.homepage    = "https://github.com/metabypass/captcha-solver-ruby"
  spec.summary     = 'Metabypass | Ruby-based easy implementation for solving any type of captcha by Metabypass '
  spec.description = 'Metabypass | Ruby-based easy implementation for solving any type of captcha by Metabypass '

  # If this line is removed, all fun times will cease.
  spec.post_install_message = "Welcome to the party of AI Captcha Solvers !"

  all_files = `git ls-files`.split("\n")
  spec.files         = all_files
  spec.require_paths = ["lib"]
end
