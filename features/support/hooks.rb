require 'watir'
require 'webdrivers'

def zalenium_args(scenario, feature_name)
  {
      timeout: 120,
      url: ENV['WEBDRIVER_URL'], name: "Scenario: #{scenario.name} #{Time.now}",
      'goog:chromeOptions': {
        args: ENV['WEBDRIVER_CHROMEOPTIONS']&.split(' ') || %w[]
      },
      'zal:build': "Feature: #{feature_name}",
      args: %w[--disable-popup-blocking --no-sandbox --disable-dev-shm-usage]
  }
end

Before do |scenario|
  Document.feature scenario.feature
  Document.scenario scenario.name
  browser_type = if ENV['BROWSER'] && !ENV['BROWSER'].empty?
                   ENV['BROWSER']
                 else
                   :chrome
                 end
  if ENV['remote']
    @browser = Watir::Browser.new browser_type, **zalenium_args(scenario, scenario.feature.name)
  else
    @browser = Watir::Browser.new browser_type
  end
  raise 'Error creating browser' unless @browser
end

# Add Step name as zalenium message
AfterStep do |_result, step|
  step_text = "#{step.source[2].keyword}#{step.text}"
  sleep 0.5
  begin
    @browser.cookies.add 'zaleniumMessage', step_text
  rescue Selenium::WebDriver::Error::UnknownError => e
    puts "Unknown error setting cookie #{e.message}"
  end
  Document.step step_text
  Document.page(@browser, "#{step_text}_#{Time.now.strftime("%H:%m:%S")}")
  sleep 1.5 # Give time for message to show
end

After do |scenario|
  result_string = scenario.failed? ? 'False' : 'True'
  begin
    @browser.cookies.add 'zaleniumTestPassed', result_string # Tell Zalenium test result
  rescue Selenium::WebDriver::Error::UnknownError => e
    puts "Unknown error setting cookie #{e.message}"
  end
  @browser.close
end

at_exit do
  sleep 20 if ENV['remote'] # Time for video to process
end