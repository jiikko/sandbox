require 'yaml'
CONDFIG_FILE = 'config.yml'
config_file = File.join(File.expand_path('../../', __FILE__), CONDFIG_FILE)
config = nil
if File.exists?(config_file)
  config = YAML.load_file(config_file)
else
  puts 'not found condfig_path'
  exit 1
end
