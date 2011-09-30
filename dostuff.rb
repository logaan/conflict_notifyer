require "fileutils"
require "pp"

FileUtils.cd("repository")

remote_branches =  `git branch -r`.split("\n").map(&:strip)
feature_branches = remote_branches - ["origin/HEAD -> origin/master", "origin/master"]

files_modified_by_each_feature_branch = {}
for branch in feature_branches
  files_modified_by_each_feature_branch[branch] = `git diff #{branch} --name-only`.split("\n")
end

files_modified_by_each_feature_branch.keys.each do |branch|
  files_changes_by_this_branch = files_modified_by_each_feature_branch.delete(branch)

  for comparison_branch in files_modified_by_each_feature_branch.keys
    files_changed_by_comparison_branch = files_modified_by_each_feature_branch[comparison_branch]
    conflicting_files = files_changes_by_this_branch - files_changed_by_comparison_branch
    puts "#{branch} and #{comparison_branch} are working on the same files" unless conflicting_files.empty?
  end
end

