require 'cucumber/rake/task'

directory 'logs'

desc 'Run and create training doc'
task manual: %i[run md_to_doc]

desc 'Reset folder and files for creating manual'
task 'setup' do
  mkdir_p 'manual/img'
  rm Dir.glob('manual/*.md')
end

desc 'Run end to end'
Cucumber::Rake::Task.new('cucumber' => %i[logs setup])

desc 'Convert markdown to doc'
task :md_to_doc do
  puts `cd manual && pandoc --from=markdown --to=docx --output=test.docx *.md`
end
