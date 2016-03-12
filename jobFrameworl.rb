class DifferentSitesJob < Utility

  def jobZepRecruiter(site)

    $details["jobSearchKeywords"].each do |keyword|
      $pool.process{
        begin
          browser = $utility.launch_browser("Desktop");
          browser = $utility.browser_goto(browser,$details["siteUrls"][site]);

          status = $utility.click_link("/login", "href", browser)

          status = $utility.setAnyTextField("email", "name",$details["userCredentials"][site]["user"], browser)
          status = $utility.setAnyTextField("password","name",$details["userCredentials"][site]["pass"], browser)

          status = $utility.click_button("Sign In","value",browser)

          status = $utility.setAnyTextField("search","id",keyword, browser)
          status = $utility.setAnyTextField("location","id","United States", browser)

          status = $utility.click_button("Search Jobs","value",browser)
          # puts(browser.buttons(:class => "default"))
          while(browser.link(:id => 'pagination-button-next').exists?) do
            browser.buttons(:class => "default").each do |button_link|
              begin
                button_link.click
                sleep(10)
              rescue => e
                puts (e.message)
              end
            end
            status  = $utility.click_link("pagination-button-next","id", browser)
          end
      rescue => e
        puts(e.message)
        end
      }
    end
  end

  def jobLinkedIn(site)
    $details["jobSearchKeywords"].each do |keyword|
      $pool.process{
        begin

          browser = $utility.launch_browser("Desktop");
          browser = $utility.browser_goto(browser,$details["siteUrls"][site]);

          # status = $utility.click_link("/login", "href", browser)

          status = $utility.setAnyTextField("login-email", "id",$details["userCredentials"][site]["user"], browser)
          status = $utility.setAnyTextField("login-password","id",$details["userCredentials"][site]["pass"], browser)

          browser.input(:value => "Sign in").click

          browser = $utility.browser_goto(browser,$details["siteUrls"][site]+"job/home");
          browser.refresh

          status = $utility.setAnyTextField("field-keyword-name", "id",keyword, browser)
          status = $utility.setAnyTextField("field-location-name", "id","United states", browser)

          puts("Please click search button")

          # begin
          #   browser.li(:id =>"facet-E", :class => "facet").button(:class => "facet-toggle").click
          # rescue
          #   begin
          #     browser.li(:id =>"facet-SB", :class => "facet").button(:class => "facet-toggle").click
          #   rescue
          #     browser.li(:id =>"facet-E", :class => "facet").button(:class => "facet-toggle").click
          #   end
          # end
          #
          # browser.input(:id => "2-E-ffs").click

          j=0;


          while browser.li(:class => "next").exists? do
            while browser.li(:class => "result", :index =>j).exists? do
              begin
                href = browser.li(:class => "result", :index =>j).link(:class => "result-image").href
                browser2 = $utility.launch_browser("Desktop");
                browser2 = $utility.browser_goto(browser2,href);
                if browser2.link(:class => "apply-button").exists?
                  browser2.link(:class => "apply-button").click
                  browser2.link(:class => "sign-in-link").click

                  status = $utility.setAnyTextField("session_key-login", "id",$details["userCredentials"][site]["user"], browser2)
                  status = $utility.setAnyTextField("session_password-login", "id",$details["userCredentials"][site]["pass"], browser2)

                  browser2.input(:value => "Sign In").click

                  browser2.button(:id => "apply-job-button").click

                  # browser2.button(:id => "file-browse-input").click

                  browser2.select_list(:id, "email-selector").select_value("phemraja@usc.edu")

                  browser2.button(:id => "send-application-button").click





                end
                $utility.kill_browser("Desktop",browser2)

              rescue =>e
                puts(e.message)
              end
              j=j+1
            end
            browser.li(:class => "next").click
            j=0;
          end



          # begin
          #   browser.button(:id => "toggle-advanced").click
          # rescue => e
          #   puts(e.backtrace)
          # end
          #
          # begin
          #   browser.button(:name => "Search").click
          # rescue
          #   begin
          #     browser.input(:name => "jsearch").click
          #   rescue
          #     browser.input(:class => "search-button").click
          #
          #   end
          #
          # end





        rescue => e
          puts(e.message)
        end
      }
    end
  end
end