# Load the rails application
require File.expand_path('../application', __FILE__)

# Load original settings
SETTINGS              = YAML.load_file(File.join(Rails.root,"config","settings.yml"))[Rails.env]
JUKI_MATCH_CONDITIONS = YAML.load_file(File.join(Rails.root,"config","juki_match_conditions.yml"))

# Initialize the rails application
Lgdpm::Application.initialize!
