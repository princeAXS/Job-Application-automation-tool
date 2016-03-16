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
      $pool.process{
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



          # begin
          #   browser.li(:id =>"facet-E", :class => "facet").button(:class => "facet-toggle").click
          # rescue
          #   begin
          #     browser.li(:id =>"facet-SB", :class => "facet").button(:class => "facet-toggle").click
          #   rescue
          #     browser.li(:id =>"facet-E", :class => "facet").button(:class => "facet-toggle").click
          #   end
          # end

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

                if browser.span(:class => "quick-apply").exists? and not browser.div(:class => "applied-text").exist?

                  sleep(3)
                  browser.button(:id => "apply-job-button").click

                  sleep(1)
                  browser.select_list(:id, "email-selector").select_value("phemraja@usc.edu")
                  browser.file_field(:id,"file-browse-input").set($details["userCredentials"]["resume"])

                  sleep(2)
                  browser.button(:id => "send-application-button").click

                  sleep(2)
                elsif browser.link(:id => "offsite-apply-button").exists?
                  browser.link(:id => "offsite-apply-button").click

                  begin
                    browser.windows.last.use do
                      if(browser.url.include?("roberthalf"))
                        puts(browser.url)
                        roberthalf(browser)
                      elsif(browser.url.include?("beaconhillstaffing"))
                        puts(browser.url)
                        beacon(browser)
                      elsif(browser.url.include?("catsone"))
                        puts(browser.url)
                        catsone(browser)
                      elsif(browser.url.include?("strategicitstaffing"))
                        puts(browser.url)
                        strategic(browser)
                      elsif(browser.url.include?("ziprecruiter"))
                        puts(browser.url)
                        zipRecruit(browser)
                      end
                      browser.window.close
                    end
                  rescue => e
                    puts(e.message)
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
      }
    end
  end
# ---------------------------------- sub function for linked in job application --------------------------------

  def icims()
    browser = $utility.launch_browser("Desktop");
    browser.window.maximize

    browser = $utility.browser_goto(browser,"https://careers-vantagetravel.icims.com/jobs/1016/front-end-web-developer/job?mobile=false&width=960&height=500&bga=true&needsRedirect=false&jan1offset=-480&jun1offset=-420")
    begin
      browser.iframe(:id => "icims_content_iframe").div(:class => "iCIMS_JobOptions").div(:id => "jobOptionsMobile").link.click

      browser.iframe(:id => "icims_content_iframe").div(:class => "iCIMS_SocialLoginButtonContainer").link(:class => "socialLoginButton", :index => 0).click

      begin
        status = $utility.setAnyTextField("session_key-oauthAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["user"], browser)
        status = $utility.setAnyTextField("session_password-oauthAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["pass"], browser)

        browser.input(:type => "submit").when_present.click
      rescue => e
        browser.input(:type => "submit").click
      end

      browser.iframe(:id => "icims_content_iframe").file_field(:type,"file").set($details["userCredentials"]["resume"])
      sleep(5)

      browser.scroll.to browser.iframe(:id => "icims_content_iframe").select_list(:id, "rcf3048")

      browser.iframe(:id => "icims_content_iframe").select_list(:id, "rcf3048").select_value("Internet - LinkedIn")


      browser.input(:type => "submit").click

    rescue => e
      puts e.message
    end

  end


  def strategic(browser)
    begin
      browser.div(:class => "atsJobDetailsAlreadyLogin").link.click


      status = $utility.setAnyTextField("j_id0:j_id1:atsForm:firstName", "id",$details["userCredentials"]["basic"]["firstName"], browser)
      status = $utility.setAnyTextField("j_id0:j_id1:atsForm:lastName", "id",$details["userCredentials"]["basic"]["lastName"], browser)
      status = $utility.setAnyTextField("j_id0:j_id1:atsForm:email", "id",$details["userCredentials"]["basic"]["email"], browser)
      browser.select_list(:id, "j_id0:j_id1:atsForm:candidateSource").select_value("a0Y70000002vzD8EAI")
      browser.input(:type => "submit").click

      browser.file_field(:type,"file").set($details["userCredentials"]["resume"])


      browser.input(:type => "submit").click
      sleep(5)
    rescue => e
      puts e.message
    end

  end

  def catsone(browser)
    begin
      browser.div(:id=> "jobDetails").div(:class=> "actionButtons").link.click

      browser.file_field(:type,"file").set($details["userCredentials"]["resume"])

      status = $utility.setAnyTextField("0_field_1", "id",$details["userCredentials"]["basic"]["firstName"], browser)
      status = $utility.setAnyTextField("0_field_2", "id",$details["userCredentials"]["basic"]["lastName"], browser)
      status = $utility.setAnyTextField("0_field_3", "id",$details["userCredentials"]["basic"]["email"], browser)
      status = $utility.setAnyTextField("0_field_4", "id","1226 W 30th st", browser)
      status = $utility.setAnyTextField("0_field_5", "id","Los Angeles", browser)
      status = $utility.setAnyTextField("0_field_6", "id","CA", browser)
      status = $utility.setAnyTextField("0_field_7", "id","90007", browser)
      status = $utility.setAnyTextField("0_field_8", "id",$details["userCredentials"]["basic"]["phNo"], browser)

      browser.input(:type => "submit").click
      sleep(5)

    rescue => e
      puts e.message
    end
  end


  def beacon(browser)

    begin
      browser.div(:class=> "EMB_Jobs_Detail_Resume").link(:class => "button", :index=>0).click
      sleep(5)

      browser.scroll.to browser.input(:id => "dnn_ctr595_EMB_Jobs_Resume_lstResumeType_1")

      browser.input(:id => "dnn_ctr595_EMB_Jobs_Resume_lstResumeType_1").click
      sleep(2)
      browser.link(:id => "dnn_ctr595_EMB_Jobs_Resume_btnSubmit2").click
      sleep(2)
      browser.file_field(:type,"file").set($details["userCredentials"]["resume"])
      sleep(2)

      status = $utility.setAnyTextField("dnn_ctr595_EMB_Jobs_Resume_txtName", "id",$details["userCredentials"]["basic"]["firstName"], browser)
      status = $utility.setAnyTextField("candidate_lastname", "id",$details["userCredentials"]["basic"]["lastName"], browser)
      status = $utility.setAnyTextField("dnn_ctr595_EMB_Jobs_Resume_txtPhone1", "id",$details["userCredentials"]["basic"]["phNo"], browser)
      status = $utility.setAnyTextField("dnn_ctr595_EMB_Jobs_Resume_txtEmail", "id",$details["userCredentials"]["basic"]["email"], browser)
      status = $utility.setAnyTextField("dnn_ctr595_EMB_Jobs_Resume_txtCity", "id","Los Angeles", browser)
      status = $utility.setAnyTextField("dnn_ctr595_EMB_Jobs_Resume_txtZip", "id","90007", browser)

      browser.div(:id => "dnn_ctr595_EMB_Jobs_Resume_lstState").text_field(:id => "dnn_ctr595_EMB_Jobs_Resume_lstState_Input").click
      browser.li(:class => "rcbItem",:index =>4).click

      browser.link(:id => "dnn_ctr595_EMB_Jobs_Resume_btnSubmit2").click
      sleep(3)
    rescue => e
      puts e.message
    end
  end

  def zipRecruit(browser)
    # browser = $utility.launch_browser("Desktop");
    # browser.window.maximize
    #
    # browser = $utility.browser_goto(browser,"https://www.ziprecruiter.com/jobs/sms-da7479b7/web-developer-1de5e180?mid=1595&source=feed-linkedin")
    begin
      browser.div(:class => "topApplyButtons").div(:class => "applyButtons").ul(:class => "applyMenu").li(:index => 2).click

      begin
        status = $utility.setAnyTextField("session_key-oauthAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["user"], browser)
        status = $utility.setAnyTextField("session_password-oauthAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["pass"], browser)

        browser.input(:type => "submit").click
      rescue => e
        browser.input(:type => "submit").click
      end
    rescue => e
      puts e.message
    end

  end

  def workable()
    browser = $utility.launch_browser("Desktop");
    browser.window.maximize

    browser = $utility.browser_goto(browser,"https://mustang-marketing.workable.com/jobs/208165")
    begin
      browser.scroll.to browser.section(:class => "section--cta").link(:class => "btn--primary")
      browser.section(:class => "section--cta").link(:class => "btn--primary").click

      status = $utility.setAnyTextField("candidate_firstname", "id",$details["userCredentials"]["basic"]["firstName"], browser)
      status = $utility.setAnyTextField("candidate_lastname", "id",$details["userCredentials"]["basic"]["lastName"], browser)
      status = $utility.setAnyTextField("candidate_phone", "id",$details["userCredentials"]["basic"]["phNo"], browser)
      status = $utility.setAnyTextField("candidate_email", "id",$details["userCredentials"]["basic"]["email"], browser)

      browser.scroll.to browser.div(:id =>"resume_cache").div(:class => "form-text").link
      browser.browser.div(:id =>"resume_cache").div(:class => "form-text").link.click
      sleep(1)

      browser.div(:class=>"modal-body").file_field(:id,"file").set($details["userCredentials"]["resume"])
      sleep(2)

      browser.button(:type => "submit").click
    rescue => e
      puts(e.message)
    end
end

  def roberthalf(browser)
    # browser = $utility.launch_browser("Desktop");
    # browser.window.maximize
    #
    # browser = $utility.browser_goto(browser,"https://www.roberthalf.com/technology/job-search/buena-park-ca/jr-web-developer-up-to-105k-will-teach-sql/43531074");
    begin
      browser.button(:class => "apply").click
      browser.div(:id => "upload_section_title").click
      sleep(1)
      browser.file_field(:id,"file").set($details["userCredentials"]["resume"])
      browser.input(:id => "termsOfUseChecked").click

      status = $utility.setAnyTextField("firstName", "id",$details["userCredentials"]["basic"]["firstName"], browser)
      status = $utility.setAnyTextField("lastName", "id",$details["userCredentials"]["basic"]["lastName"], browser)
      status = $utility.setAnyTextField("phone", "id",$details["userCredentials"]["basic"]["phNo"], browser)
      status = $utility.setAnyTextField("emailAddress", "id",$details["userCredentials"]["basic"]["email"], browser)
      status = $utility.setAnyTextField("AddressLine1", "id","1226 w 30th st", browser)
      status = $utility.setAnyTextField("city", "id","Los Angeles", browser)
      browser.select_list(:id, "stateCountry").select_value("CA")
      status = $utility.setAnyTextField("zip", "id","90007", browser)

      browser.input(:id => "submit_btn").click
    rescue => e
      puts(e.message)
    end
  end


  def applytojob(browser)
    browser = $utility.launch_browser("Desktop");
    browser.window.maximize

    browser = $utility.browser_goto(browser,"http://apogeeintegration.applytojob.com/apply/job_20160310235151_KC7KFGQV4JPCCPWC/Jr-Web-Developer?source=LILI");
    browser.div(:id => "resumator-apply-with-linkedin-wrapper").click
    sleep(5)
    status = $utility.setAnyTextField("resumator-email-value", "id",$details["userCredentials"]["basic"]["email"], browser)
    status = $utility.setAnyTextField("first_name", "id",$details["userCredentials"]["basic"]["firstName"], browser)
    status = $utility.setAnyTextField("first_name", "id",$details["userCredentials"]["basic"]["firstName"], browser)

  end

  def greenhouse(browser)


    browser.scroll.to browser.input(:id => "first_name")
    status = $utility.setAnyTextField("first_name", "id",$details["userCredentials"]["basic"]["firstName"], browser)
    status = $utility.setAnyTextField("last_name", "id",$details["userCredentials"]["basic"]["lastName"], browser)
    status = $utility.setAnyTextField("phone", "id",$details["userCredentials"]["basic"]["phNo"], browser)
    status = $utility.setAnyTextField("email", "id",$details["userCredentials"]["basic"]["email"], browser)
    # status = $utility.setAnyTextField("job_application_location", "id","Los Angeles, CA, United States", browser)
    browser.div(:class=> "attach-or-paste ").div(:class=> "link-container").link(:index => 2).click
    browser.textarea(:id => "resume_text").set File.read("/Users/prince/Desktop/ PRINCE_HEMRAJANI_RESUME.docx")
    status = $utility.setAnyTextField("job_application_answers_attributes_0_text_value", "id","University of Southern California", browser)
    status = $utility.setAnyTextField("job_application_answers_attributes_1_text_value", "id","Computer Science", browser)
    status = $utility.setAnyTextField("job_application_answers_attributes_2_text_value", "id","https://www.linkedin.com/in/princehemrajani", browser)
    status = $utility.setAnyTextField("job_application_answers_attributes_4_text_value", "id","LinkedIn", browser)
    browser.select_list(:id, "job_application_answers_attributes_5_boolean_value").select_value(1)
    browser.select_list(:id, "job_application_answers_attributes_6_boolean_value").select_value(0)
    status = $utility.setAnyTextField("job_application_location", "id","Los Angeles, CA, United States", browser)
    browser.input(:id => "submit_app").click


    sleep(5)

  end

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
