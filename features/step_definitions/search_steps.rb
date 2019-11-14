When(/^visit homepage$/) do
  visit BASE_URL
end

When(/^fill "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, with: value)
end