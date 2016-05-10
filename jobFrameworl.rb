class DifferentSitesJob < Utility

  def jobZepRecruiter(site)

    $details["jobSearchKeywords"].each do |keyword|
      $pool.process{
        begin
          browser = $utility.launch_browser("Desktop");
          browser.window.maximize
          browser = $utility.browser_goto(browser,$details["siteUrls"][site]);

          status = $utility.click_link("/login", "href", browser)

          status = $utility.setAnyTextField("email", "name",$details["userCredentials"][site]["user"], browser)
          status = $utility.setAnyTextField("password","name",$details["userCredentials"][site]["pass"], browser)

          status = $utility.click_button("Sign In","value",browser)

          status = $utility.setAnyTextField("search","id",keyword, browser)
          status = $utility.setAnyTextField("location","id","United States", browser)

          status = $utility.click_button("Search Jobs","value",browser)
          # sleep(1)
          # href = browser.link(:class => "select-menu-item", :index => 1).href
          # browser = $utility.browser_goto(browser,href);
          # keyword.split.map(&:capitalize).join(' ')

          # puts(browser.buttons(:class => "default"))
          while(browser.link(:id => 'pagination-button-next').exists?) do
            browser.buttons(:class => "default").each do |button_link|
              begin
                button_link.when_present.click
                random = rand(10..15)
                sleep(random)
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

        begin

          browser = $utility.launch_browser("Desktop");
          browser.window.maximize

          browser = $utility.browser_goto(browser,$details["siteUrls"][site]);

          status = $utility.setAnyTextField("login-email", "id",$details["userCredentials"][site]["user"], browser)
          status = $utility.setAnyTextField("login-password","id",$details["userCredentials"][site]["pass"], browser)

          browser.input(:value => "Sign in").click

          browser = $utility.browser_goto(browser,$details["siteUrls"][site]+"job/home");

          status = $utility.setAnyTextField("main-search-box", "id",keyword, browser)
          browser.button(:class => "search-button").click




          browser.scroll.to browser.li(:id =>"facet-C", :class => "facet").button(:class => "facet-toggle")
          browser.li(:id =>"facet-E", :class => "facet").button(:class => "facet-toggle").click

          # browser.scroll.to browser.input(:id => "2-E-ffs")
          browser.input(:id => "2-E-ffs").click



          j=0;
          while browser.li(:class => "next").exists? do
            while browser.li(:class => "result", :index =>j).exists? do
              begin
                sleep(3)
                browser.scroll.to browser.li(:class => "result", :index =>j)
                browser.li(:class => "result", :index =>j).link(:class => "result-image").click

                title = browser.h1(:class => "title").text.downcase
                if ["stack", "software","java","web","application","php","front end"].any? { |titleKeyword| title.include? titleKeyword }
                  if (browser.span(:class => "quick-apply").exists? or browser.li(:class => "in-apply-icon").exist?)  and not browser.div(:class => "applied-text").exist?

                    sleep(3)
                    #browser.scroll.to browser.button(:id => "apply-job-button")
                    browser.button(:id => "apply-job-button").click

                    sleep(1)
                    browser.select_list(:id, "email-selector").select_value("phemraja@usc.edu")
                    browser.file_field(:id,"file-browse-input").set($details["userCredentials"]["resume"])

                    sleep(2)
                    browser.button(:id => "send-application-button").click

                    sleep(2)
                    puts browser.url.white.on_green
                  elsif browser.link(:id => "offsite-apply-button").exists?
                    browser.link(:id => "offsite-apply-button").click

                    begin
                      browser.windows.last.use do
                        # puts browser.url.white.on_yellow
                        # if(browser.url.include?("roberthalf"))
                          # $linkedIn.roberthalf(browser)
                        if(browser.url.include?("beaconhillstaffing"))
                          $linkedIn.beacon(browser)
                        elsif(browser.url.include?("catsone"))
                          $linkedIn.catsone(browser)
                        elsif(browser.url.include?("strategicitstaffing"))
                          $linkedIn.strategic(browser)
                        elsif(browser.url.include?("ziprecruiter"))
                          $linkedIn.zipRecruit(browser)
                        elsif(browser.url.include?("applytojob"))
                          $linkedIn.applytojobfromLinkedIn(browser)
                        elsif(browser.url.include?("jobvite"))
                          $linkedIn.jobvite(browser)
                        elsif(browser.url.include?("jobtap"))
                          $linkedIn.jobtap(browser)
                        elsif(browser.url.include?("greenhouse"))
                          $linkedIn.greenhouse(browser)
                        else
                          puts browser.url
                        end
                        browser.window.close
                      end
                    rescue => e
                      puts(e.message)
                    end

                  end
                end
                browser.back
              rescue =>e
                puts(e.message)
                sleep(6)

                if browser.span(:class => "quick-apply").exists? or browser.div(:class => "applied-text").exist? or browser.link(:id => "offsite-apply-button").exists?
                  browser.back
                end

              end

              j=j+1
            end
            browser.li(:class => "next").click
            j=0;
          end
        rescue => e
          puts(e.backtrace)

        end

    end
  end
# ---------------------------------- sub function for linked in job application --------------------------------

  # def jobtap()


  # --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  def jobWorkBridge(site)
    $details["jobSearchKeywords"].each do |keyword|
      $pool.process{
        begin
          browser = $utility.launch_browser("Desktop");
          browser.window.maximize

          browser = $utility.browser_goto(browser,$details["siteUrls"][site]);

          status = $utility.setAnyTextField("header_search", "id",keyword, browser)
          browser.input(:id => "search_submit").click

          browser.ul(:class => "magic_box",:index => 1).li(:index =>1).when_present.click

          sleep(1)
          while browser.li(:class => "next_results").exists? do
            j=0
            while browser.td(:class => "listings_title", :index => j).exists? do
              begin
                href = browser.td(:class => "listings_title", :index => j).link.href
                browser2 = $utility.launch_browser("Desktop");
                browser2.window.maximize

                browser2 = $utility.browser_goto(browser2,href);

                browser2.link(:id => "apply_for_this_job").click

                sleep(1)

                status = $utility.setAnyTextField("firstname", "id",$details["userCredentials"]["basic"]["firstName"], browser2)
                status = $utility.setAnyTextField("lastname", "id",$details["userCredentials"]["basic"]["lastName"], browser2)
                status = $utility.setAnyTextField("phone", "id",$details["userCredentials"]["basic"]["phNo"], browser2)
                status = $utility.setAnyTextField("email", "id",$details["userCredentials"]["basic"]["email"], browser2)
                browser2.file_field(:id,"apply_attach_file").set($details["userCredentials"]["resume"])
                browser2.link(:id => "jobpost_send_info").click




                # $utility.kill_browser("Desktop",browser2)

                j=j+1
                  #add logic that will stop script afeter evry 5th browser opens
              rescue => e
                puts(e.message)
                puts("error with this job. URL: "+href)
                $utility.kill_browser("Desktop",browser2)
              end
            end
            j=0
            browser.li(:class => "next_results").click

          end


          $utility.kill_browser("Desktop",browser)
        rescue => e
          puts(e.message)
          puts(e.backtrace)
          $utility.kill_browser("Desktop",browser)

        end
      }

    end

  end

  def jobglassDoor(site)
    $details["jobSearchKeywords"].each do |keyword|
      $pool.process{
        begin
          browser = $utility.launch_browser("Desktop");
          browser.window.maximize

          browser = $utility.browser_goto(browser,$details["siteUrls"][site]);
          status = $utility.setAnyTextField("KeywordSearch", "id",keyword, browser)
          status = $utility.setAnyTextField("LocationSearch", "id","United States", browser)
          browser.button(:class => "gd-btn-submit").click


          puts(browser)
        rescue => e
          puts(e.message)
          puts(e.backtrace)
          $utility.kill_browser("Desktop",browser)

        end
      }

    end

  end

  def jobsmartRecruiter(site)
    $details["jobSearchKeywords"].each do |keyword|
      $pool.process{
        begin
          browser = $utility.launch_browser("Desktop");
          browser.window.maximize

          browser = $utility.browser_goto(browser,$details["siteUrls"][site]);

          status = $utility.setAnyTextField("search-input", "class",keyword, browser)
          browser.button(:class => "search-button").click
          sleep(2)
          j=0
          while browser.li(:class => "jobs-item", :index =>j).exists? do
            begin
              href = browser.li(:class => "jobs-item", :index =>j).a.href
              browser2 = $utility.launch_browser("Desktop");
              browser2.window.maximize

              browser2 = $utility.browser_goto(browser2,href);

              browser2.button(:id => "st-apply").when_present.click

              browser2.link(:id => "st-skip").when_present.click

              sleep(1)

              browser2.file_field(:id,"st-connect-upload").set($details["userCredentials"]["resume"])

              sleep(5)

              # browser2.button(:id => "js-popup-submit").when_present.click




            rescue => e
              puts(e.message)
              puts("error with this job. URL: "+href)
              $utility.kill_browser("Desktop",browser2)
            end
            j=j+1
            #add logic that will stop script afeter evry 5th browser opens
          end
        rescue => e
          puts(e.message)
          puts(e.backtrace)
          $utility.kill_browser("Desktop",browser)

        end
      }

    end
  end
end
