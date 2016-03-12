# require 'thread'
# require 'rubygems'
# require 'watir'
# require 'watir-webdriver'
# require 'rest_client'
# require 'json'
# require './utility.rb'
# # require "./framework/utilityLogin.rb"
# # require "./framework/emailer.rb"
# require 'webdriver-user-agent'
# require "watir-webdriver/wait"
# require 'thread/pool'
# require 'colorize'
#
# Watir.default_timeout = 180
# $client = Selenium::WebDriver::Remote::Http::Default.new
# $client.timeout = 180 # seconds – default is 60
# #################################################################################################
# # Scripts Section. 												  											   #
# #################################################################################################
#
# $details = JSON.parse(File.read('./details.json'))
# $current_browser = $details["browser"][0]
#
# $utility = Utility.new
#
# pool = Thread.pool(3)
# browser=""
# begin
#
#   $details["jobSitetoApply"].each do |site|
#     pool.process{
#       begin
#         browser = $utility.launch_browser("Desktop");
#         browser = $utility.browser_goto(browser,$details["siteUrls"][site]);
#
#         status = $utility.click_link("/login", "href", browser)
#
#         status = $utility.setAnyTextField("email", "name",$details["userCredentials"][site]["user"], browser)
#         status = $utility.setAnyTextField("password","name",$details["userCredentials"][site]["pass"], browser)
#
#         status = $utility.click_button("Sign In","value",browser)
#
#         status = $utility.setAnyTextField("search","id",$details["jobSearchKeywords"][0], browser)
#         status = $utility.setAnyTextField("location","id","United States", browser)
#
#         status = $utility.click_button("Search Jobs","value",browser)
#         puts(browser.buttons(:class => "default"))
#         while(browser.link(:id => 'pagination-button-next').exists?) do
#           browser.buttons(:class => "default").each do |button_link|
#             begin
#               button_link.click
#               sleep(1)
#             rescue => e
#               puts (e.message)
#             end
#           end
#           status  = $utility.click_link("pagination-button-next","id", browser)
#         end
#
#
#
#
#
#
#
#
#         puts(status)
#
#
#
#
#
#
#
#
#
#
#           # $utility.kill_browser("Desktop",browser);
#       rescue => e
#         puts (e.backtrace)
#         # $utility.kill_browser("Desktop",browser);
#         # pool.shutdown
#       end
#     }
#     puts("Successfully executed")
#     pool.shutdown
#   end
#
#
# rescue => e
#   puts (e.backtrace)
#   # $utility.kill_browser("Desktop",browser);
#   # pool.shutdown
#
# end
#
#
#
