require "yaml"
require "git"
require "pp"

desc "Pulls remote repository to local machine"
task :clone do
  config = YAML.load_file("config.yml")
  Git.clone(config["repo_path"], "repository")
end

desc "Check for conflicts"
task :conflicts do
  Rake::Task["clone"].invoke unless File.exists?("repository")
  repo = Git.open("repository")
  branches = repo.branches.remote[0..-2]
  branches.map {|b| repo.diff("master", b).to_s }
  files_touched = branches.map{|b| repo.diff("master", b).map{|f| f.path } }
  pp files_touched.map do |files|
    files_touched.delete(files)
    files_touched.map do |comparison_files|
      files & comparison_files
    end
  end
end
