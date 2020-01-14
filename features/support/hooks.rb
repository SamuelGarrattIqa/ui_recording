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
  if ENV['remote']
    @browser = Watir::Browser.new :firefox, **zalenium_args(scenario, scenario.feature.name)
  else
    @browser = Watir::Browser.new :firefox
  end
end

After do |scenario|
  result_string = scenario.failed? ? 'False' : 'True'
  @browser.cookies.add 'zaleniumTestPassed', result_string # Tell Zalenium test result
  @browser.close
  sleep 10 # Time for video to process
end