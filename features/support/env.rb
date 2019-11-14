require 'allure-cucumber'
require 'capybara/cucumber'
require 'webdrivers/chromedriver'
require_relative 'config'
c
include BaseConstants
include Capybara::DSL
include RSpec::Matchers

# Allure
Allure.configure do |c|
  c.results_directory = 'report/allure-results'
  c.clean_results_directory = true
  c.link_tms_pattern = 'https://example.org/tms/{}'
  c.link_issue_pattern = 'https://example.org/issue/{}'
end

AllureCucumber.configure do |c|
  c.tms_prefix = 'TMS_'
  c.issue_prefix = 'ISSUE_'
end

Capybara.configure do |config|
  config.default_driver = :selenium
  config.default_selector = :css
  config.app_host = BASE_URL
  config.default_max_wait_time = 10
end

#headless disable-dev-shm-usage no-sandbox
Capybara.register_driver :selenium do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w(no-sandbox start-maximized) }
  )
  Capybara::Selenium::Driver.new(app,:browser => :remote, :url => "http://selenium-team-2-selenium-hub:4444/wd/hub",
                                 desired_capabilities: capabilities)
end
