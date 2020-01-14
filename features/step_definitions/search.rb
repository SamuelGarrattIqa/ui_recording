Given 'I am on the IntegrationQA blog page' do
  @browser.goto 'https://integrationqa.com/blog/'
end

When 'I search for {string}' do |search_string|
  @browser.text_field(id: 's').set search_string
  @browser.send_keys :enter
end

Then 'a result is returned' do
  @browser.div(id: 'content-area').article.wait_until_present.flash
end
