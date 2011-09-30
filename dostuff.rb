require "fileutils"
require "pp"

FileUtils.cd("repository")

remote_branches =  `git branch -r`.split("\n").map(&:strip)
non_master_branches = remote_branches - ["origin/HEAD -> origin/master", "origin/master"]

for branch in non_master_branches
  files_changed_from_master = `git diff #{branch} --name-only`.split("\n")

  other_non_master_branches = non_master_branches - [branch]
  for other_branch in other_non_master_branches
    other_branches_files_changes_from_master = `git diff #{other_branch} --name-only`.split("\n")
    conflicting_files = files_changed_from_master & other_branches_files_changes_from_master 
    
    puts "#{branch} and #{other_branch} are working on the same files" unless conflicting_files.empty?
  end
end

