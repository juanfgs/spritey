# coding: utf-8
Gem::Specification.new do |s|
  s.name = 'Spritey'
  s.version = '0.0.1'
  s.date = '2015-02-08'
  s.summary = "A simple sprite generator"
  s.description = "Tired of writing CSS sprites by hand? well this simple gem will make it easy"
  s.authors = ["Juan GiménezSilva"]
  s.email = 'juanfgs@gmail.com'
  s.homepage = 'http://juanfgs.eosweb.info'
  s.license = 'GPL 3.0'
  s.files = ['lib/spritey.rb']
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.executables = ['spritey']
end
