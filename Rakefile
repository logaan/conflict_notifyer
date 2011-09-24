require "yaml"
require "git"

desc "Pulls remote repository to local machine"
task :clone do
  config = YAML.load_file("config.yml")
  Git.clone(config["repo_path"], :name => 'repository', :path => ".")
end

