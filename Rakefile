require 'cucumber/rake/task'
require 'rake/clean'

directory 'logs'
directory 'tmp'
directory 'manual/img'

CLEAN.include 'tmp/*', 'manual/*.md', 'manual/img/*'

desc 'Run and create training doc'
task manual: %i[run md_to_doc]

desc 'Reset folder and files'
task setup: %w[tmp logs clean manual/img]

desc 'Check whether Zalenium is up and ready'
task :zalenium_ready do
  host_name = ENV['remote'] ? 'zalenium' : 'localhost'
  start_time = Time.now
  TIMEOUT_TIME = 300
  require 'rest-client'
  begin
    RestClient.get("#{host_name}:4444/wd/hub/status")
  rescue Errno::ECONNREFUSED, RestClient::BadGateway # Initial errors when zalenium starting up
    sleep 1
    raise 'Unable to connect to zalenium' if Time.now > start_time + TIMEOUT_TIME
    retry
  end
end

desc 'Run cucumber scenarios in parallel'
task cucumber: %i[setup zalenium_ready] do
  raise 'Test failed' unless system 'parallel_cucumber features --group-by scenarios'
end

desc 'Convert markdown to doc'
task :md_to_doc do
  puts `cd manual && pandoc --from=markdown --to=docx --output=test.docx *.md`
end
