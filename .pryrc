Pry.config.prompt = proc do |obj, nest_level, _pry_|
  version = ''
  version << "\001\e[0;31m\002"
  version << "#{RUBY_VERSION}"
  version << "\001\e[0m\002"
  "#{version} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})> "
end

begin
  print "Loading awesome_print..."
  require 'awesome_print'
  puts " OK!"
rescue LoadError
  puts " Error!"
else
  AwesomePrint.pry!
end
