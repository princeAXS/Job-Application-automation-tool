

        1.) $(".browse_startups_table_row").each(function(){ $(this).click(); });

        steps to follow. pls wait for a while after every step
        1.) $(".interested-button").click();

        2.) $(".interested-note").val("I am Recent graduate with MS in computer science and 1 year of internship experience in software engineering.Excellent research, time management and problem solving skills. Highly organized with the ability to manage multiple projects and consistently meet deadlines.");
        3.) $(".interested-with-note-button").click();
        4.) location.reload();
        repeat for more jobs. this will apply for the jobs that are visible on the page. pls avoid to have more than 20 jobs listed(visible) on the page
        while(true)
          {
          $(".interested-button").click();
          setTimeout(function(){ console.log("Hello"); }, 10000);
          $(".interested-note").val("I am Recent graduate with MS in computer science and 1 year of internship experience in software engineering.Excellent research, time management and problem solving skills. Highly organized with the ability to manage multiple projects and consistently meet deadlines.");
          setTimeout(function(){ console.log("Hello"); }, 5000);
          $(".interested-with-note-button").click();
          setTimeout(function(){ console.log("Hello"); }, 5000);


          }

# cyber
# INDEED
# catsome extra fields

# http://jobs.jobvite.com/careers/aspera/job/oqDPXfwz
#
#
# # http://www.modis.com/http://www.modis.com/job/jr-net-developer/?ID=US_EN_6_21886_50421809#apply
# # http://www.cybercoders.com/apply/jobappskills/260964/
# #
# # http://fuhu.mytribehr.com/careers/view/486
# #
# # http://latitudeinc.theresumator.com/apply/1dLgwJ/Jr-PHP-HTMLCSS-Web-Developer?source=LINKEDIN
#
#
#
# # require 'thread'
# # require 'rubygems'
# # require 'watir'
# # require 'watir-webdriver'
# # require 'rest_client'
# # require 'json'
# # require './utility.rb'
# # # require "./framework/utilityLogin.rb"
# # # require "./framework/emailer.rb"
# # require 'webdriver-user-agent'
# # require "watir-webdriver/wait"
# # require 'thread/pool'
# # require 'colorize'
# #
# # Watir.default_timeout = 180
# # $client = Selenium::WebDriver::Remote::Http::Default.new
# # $client.timeout = 180 # seconds – default is 60
# # #################################################################################################
# # # Scripts Section. 												  											   #
# # #################################################################################################
# #
# # $details = JSON.parse(File.read('./details.json'))
# # $current_browser = $details["browser"][0]
# #
# # $utility = Utility.new
# #
# # pool = Thread.pool(3)
# # browser=""
# # begin
# #
# #   $details["jobSitetoApply"].each do |site|
# #     pool.process{
# #       begin
# #         browser = $utility.launch_browser("Desktop");
# #         browser = $utility.browser_goto(browser,$details["siteUrls"][site]);
# #
# #         status = $utility.click_link("/login", "href", browser)
# #
# #         status = $utility.setAnyTextField("email", "name",$details["userCredentials"][site]["user"], browser)
# #         status = $utility.setAnyTextField("password","name",$details["userCredentials"][site]["pass"], browser)
# #
# #         status = $utility.click_button("Sign In","value",browser)
# #
# #         status = $utility.setAnyTextField("search","id",$details["jobSearchKeywords"][0], browser)
# #         status = $utility.setAnyTextField("location","id","United States", browser)
# #
# #         status = $utility.click_button("Search Jobs","value",browser)
# #         puts(browser.buttons(:class => "default"))
# #         while(browser.link(:id => 'pagination-button-next').exists?) do
# #           browser.buttons(:class => "default").each do |button_link|
# #             begin
# #               button_link.click
# #               sleep(1)
# #             rescue => e
# #               puts (e.message)
# #             end
# #           end
# #           status  = $utility.click_link("pagination-button-next","id", browser)
# #         end
# #
# #
# #
# #
# #
# #
# #
# #
# #         puts(status)
# #
# #
# #
# #
# #
# #
# #
# #
# #
# #
# #           # $utility.kill_browser("Desktop",browser);
# #       rescue => e
# #         puts (e.backtrace)
# #         # $utility.kill_browser("Desktop",browser);
# #         # pool.shutdown
# #       end
# #     }
# #     puts("Successfully executed")
# #     pool.shutdown
# #   end
# #
# #
# # rescue => e
# #   puts (e.backtrace)
# #   # $utility.kill_browser("Desktop",browser);
# #   # pool.shutdown
# #
# # end
# #
# #
# #
#
#
# # begin
# #   browser.button(:id => "toggle-advanced").click
# # rescue => e
# #   puts(e.backtrace)
# # end
# #
# # begin
# #   browser.button(:name => "Search").click
# # rescue
# #   begin
# #     browser.input(:name => "jsearch").click
# #   rescue
# #     browser.input(:class => "search-button").click
# #
# #   end
# #
# # end
# # browser.refresh
#
# # status = $utility.setAnyTextField("field-keyword-name", "id",keyword, browser)
# # status = $utility.setAnyTextField("field-location-name", "id","United states", browser)
# #
# # browser.link(:class => "notifications-alert").click
# # browser.button(:id => "toggle-advanced").click
# # browser.input(:class => "search-button").click
# #
# # puts("Please click search button")
#
# # begin
# #   browser.li(:id =>"facet-E", :class => "facet").button(:class => "facet-toggle").click
# # rescue
# #   begin
# #     browser.li(:id =>"facet-SB", :class => "facet").button(:class => "facet-toggle").click
# #   rescue
# #     browser.li(:id =>"facet-E", :class => "facet").button(:class => "facet-toggle").click
# #   end
# # end
# #
# # browser.input(:id => "2-E-ffs").click
#
#
# def jobLinkedIn(site)
#   $details["jobSearchKeywords"].each do |keyword|
#     $pool.process{
#       begin
#
#         browser = $utility.launch_browser("Desktop");
#         browser.window.maximize
#
#         browser = $utility.browser_goto(browser,$details["siteUrls"][site]);
#
#         status = $utility.setAnyTextField("login-email", "id",$details["userCredentials"][site]["user"], browser)
#         status = $utility.setAnyTextField("login-password","id",$details["userCredentials"][site]["pass"], browser)
#
#         browser.input(:value => "Sign in").click
#
#         browser = $utility.browser_goto(browser,$details["siteUrls"][site]+"job/home");
#
#         status = $utility.setAnyTextField("main-search-box", "id",keyword, browser)
#         browser.button(:class => "search-button").click
#
#
#
#         begin
#           browser.li(:id =>"facet-E", :class => "facet").button(:class => "facet-toggle").click
#         rescue
#           begin
#             browser.li(:id =>"facet-SB", :class => "facet").button(:class => "facet-toggle").click
#           rescue
#             browser.li(:id =>"facet-E", :class => "facet").button(:class => "facet-toggle").click
#           end
#         end
#
#         browser.input(:id => "2-E-ffs").click
#
#
#
#         j=0;
#         while browser.li(:class => "next").exists? do
#           while browser.li(:class => "result", :index =>j).exists? do
#             begin
#               href = browser.li(:class => "result", :index =>j).link(:class => "result-image").href
#               # href = "https://www.linkedin.com/jobs2/view/93886650?trk=vsrp_jobs_res_name&trkInfo=VSRPsearchId%3A3121471711457819234761%2CVSRPtargetId%3A93886650%2CVSRPcmpt%3Aprimary"
#
#               browser2 = Watir::Browser.new :ff
#               browser2.window.maximize
#
#               browser2 = $utility.browser_goto(browser2,href);
#
#               if browser2.span(:class => "quick-apply").exists?
#                 browser2.link(:class => "apply-button").click
#                 browser2.link(:class => "sign-in-link").click
#
#                 status = $utility.setAnyTextField("session_key-login", "id",$details["userCredentials"][site]["user"], browser2)
#                 status = $utility.setAnyTextField("session_password-login", "id",$details["userCredentials"][site]["pass"], browser2)
#
#                 browser2.input(:value => "Sign In").click
#
#                 sleep(1)
#                 browser2.button(:id => "apply-job-button").click
#
#                 # browser2.button(:id => "file-browse-input").click
#
#                 browser2.select_list(:id, "email-selector").select_value("phemraja@usc.edu")
#
#                 browser2.file_field(:id,"file-browse-input").set($details["userCredentials"]["resume"])
#
#                 sleep(2)
#                 browser2.button(:id => "send-application-button").click
#                 random = rand(2..5)
#                 sleep(random)
#               end
#               $utility.kill_browser("Desktop",browser2)
#             rescue =>e
#               sleep(1)
#               begin
#                 if browser2.div(:class => "applied-text").exists?
#                   puts("Already applied for this job. URL: "+href)
#                   $utility.kill_browser("Desktop",browser2)
#                 else
#                   puts(e.message)
#                   puts("error with this job. URL: "+href)
#                   $utility.kill_browser("Desktop",browser2)
#                 end
#               rescue => e
#                 puts(e.message)
#                 $utility.kill_browser("Desktop",browser2)
#               end
#             end
#
#             j=j+1
#           end
#           browser.li(:class => "next").click
#           j=0;
#         end
#       rescue => e
#         puts(e.backtrace)
#       end
#     }
#   end
# end