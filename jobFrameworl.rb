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
                  if browser.span(:class => "quick-apply").exists? and not browser.div(:class => "applied-text").exist?

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
                        if(browser.url.include?("roberthalf"))
                          roberthalf(browser)
                        elsif(browser.url.include?("beaconhillstaffing"))
                          beacon(browser)
                        elsif(browser.url.include?("catsone"))
                          catsone(browser)
                        elsif(browser.url.include?("strategicitstaffing"))
                          strategic(browser)
                        elsif(browser.url.include?("ziprecruiter"))
                          zipRecruit(browser)
                        elsif(browser.url.include?("applytojob"))
                          applytojobfromLinkedIn(browser)
                        elsif(browser.url.include?("jobvite"))
                          jobvite(browser)
                        elsif(browser.url.include?("jobtap"))
                          jobtap(browser)
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
      }
    end
  end
# ---------------------------------- sub function for linked in job application --------------------------------

  # def jobtap()
  def jobtap(browser)
    # browser = $utility.launch_browser("Desktop");
    # browser.window.maximize
    #
    # browser = $utility.browser_goto(browser,"https://applicant.jobtap.com/jobs/apply/ad65b10afc999c659089ef232b4f235e?utm_source=lnkd&utm_medium=freeboard&utm_campaign=Relevante-Software%20Engineer-8782&utm_content=02/29/2016&sid=796c776b-0f3c-4ab9-b81a-390ac05e9fd2")

    begin

      status = $utility.setAnyTextField("FirstName", "id",$details["userCredentials"]["basic"]["firstName"], browser)
      status = $utility.setAnyTextField("LastName", "id",$details["userCredentials"]["basic"]["lastName"], browser)
      status = $utility.setAnyTextField("EmailAddress", "id",$details["userCredentials"]["basic"]["email"], browser)
      status = $utility.setAnyTextField("Phone", "id",$details["userCredentials"]["basic"]["phNo"], browser)
      status = $utility.setAnyTextField("PostalCode", "id","90007", browser)

      browser.file_field(:type,"file").set($details["userCredentials"]["resume"])
      browser.link(:id => "btnPasteCoverLetter").click
      browser.textarea(:id => "txtArPstCvrLetter").set $details["userCredentials"]["CV"]


      browser.input(:id => "Apply").click

      puts browser.url.white.on_green
    rescue => e
      puts browser.url.white.on_red
      puts e.message
      # puts e.backtrace
    end
 end

  def jobvite()
  # def jobvite(browser)
    browser = $utility.launch_browser("Desktop");
    browser.window.maximize

    browser = $utility.browser_goto(browser,"http://jobs.jobvite.com/careers/aspera/job/oqDPXfwz")

    begin

      begin
        browser.div(:class => "action").link.click
      rescue => e
        begin
          browser.p(:class => "btn_right").link.click
        rescue => e
          begin
            browser.div(:class => "applybtn").link.click
          rescue => e
            begin
              browser.div(:class => "jv-job-detail-top-actions").link.click
            rescue => e
              puts e.message
            end
          end
        end
      end

      browser.div(:id => "jvApplyWithSection").img.click
      sleep(2)
      browser.div(:class => "jvdlgtext").iframe(:id => "File1").file_field(:type,"file").set($details["userCredentials"]["resume"])
      browser.div(:class => "jvdlgtext").input.click
      sleep(5)
      status = $utility.setAnyTextField("jvfirstname", "id",$details["userCredentials"]["basic"]["firstName"], browser)
      status = $utility.setAnyTextField("jvlastname", "id",$details["userCredentials"]["basic"]["lastName"], browser)
      status = $utility.setAnyTextField("jvemail", "id",$details["userCredentials"]["basic"]["email"], browser)
      status = $utility.setAnyTextField("jvphone", "id",$details["userCredentials"]["basic"]["phNo"], browser)
      status = $utility.setAnyTextField("jvfld-x-sV9Vfwb", "id","Los Angeles", browser)

      begin
        browser.text_field(:id => "jvfld-x-XV9VfwG").set "CA"
      rescue =>  e
        browser.text_field(:id => "Text1").set "CA"
      end



      begin
        browser.select_list(:id, "jvfld-x9P9VfwM").select_value("No")
      rescue => e
        puts e.message
      end


      browser.textarea(:id => "jvcoverletter").set $details["userCredentials"]["CV"]

      browser.div(:id => "jvAttachSocialProfileSection").img(:index => 1).click

      browser.windows.last.use do
        browser.windows.last.use do
          linkedinWindow(browser)
        end
      end


      begin
        browser.scroll.to browser.p(:class => "btn-left")
        browser.p(:class => "btn-left").click
      rescue => e
        begin
          browser.scroll.to browser.input(:type => "submit")
          browser.input(:type => "submit").click
        rescue => e
          browser.scroll.to browser.p(:class => "btn_right").link
          browser.p(:class => "btn_right").link.click
        end
      end
      puts browser.url.white.on_green

    rescue => e
      begin
        browser.scroll.to browser.input(:type => "button")
        browser.input(:type => "button").click
        browser.img.click
        browser.windows.last.use do
          linkedinWindow(browser)
        end
        status = $utility.setAnyTextField("jvfirstname", "id",$details["userCredentials"]["basic"]["firstName"], browser)
        status = $utility.setAnyTextField("jvlastname", "id",$details["userCredentials"]["basic"]["lastName"], browser)
        status = $utility.setAnyTextField("jvemail", "id",$details["userCredentials"]["basic"]["email"], browser)
        status = $utility.setAnyTextField("jvphone", "id",$details["userCredentials"]["basic"]["phNo"], browser)

        begin
          status = $utility.setAnyTextField("jvfld-xVxrVfwy", "id","uni5prince", browser)
        rescue => e
          puts e.message
        end

        begin
          browser.select_list(:id, "jvfld-xkBhVfwR").select_value("Yes")
        rescue =>e
          puts e.message
        end

        browser.textarea(:id => "jvcoverletter").set $details["userCredentials"]["CV"]

        browser.scroll.to browser.input(:type => "submit")
        browser.input(:type => "submit").click
        puts browser.url.white.on_green


      rescue => e
        puts browser.url.white.on_red
        puts e.message
        # puts e.backtrace
      end
    end
  end

  def linkedinWindow(browser)
    begin
      status = $utility.setAnyTextField("session_key-oauthSAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["user"], browser)
      status = $utility.setAnyTextField("session_password-oauthSAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["pass"], browser)

      browser.input(:type => "submit").when_present.click

    rescue =>e
      begin
        status = $utility.setAnyTextField("session_key-oauth2SAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["user"], browser)
        status = $utility.setAnyTextField("session_password-oauth2SAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["pass"], browser)

        browser.input(:type => "submit").when_present.click
      rescue => e
        browser.input(:type => "submit").click
      end
    end
  end

  # def applytojobfromLinkedIn()
  def applytojobfromLinkedIn(browser)
    # browser = $utility.launch_browser("Desktop");
    # browser.window.maximize
    #
    # browser = $utility.browser_goto(browser,"http://cultivationcapital.applytojob.com/apply/job_20160127170104_9KX8ERXVQOS2Q2YQ/Full-Stack-Software-Engineer?source=LILI")


    begin

      status = $utility.setAnyTextField("resumator-firstname-value", "id",$details["userCredentials"]["basic"]["firstName"], browser)
      status = $utility.setAnyTextField("resumator-lastname-value", "id",$details["userCredentials"]["basic"]["lastName"], browser)
      status = $utility.setAnyTextField("resumator-email-value", "id",$details["userCredentials"]["basic"]["email"], browser)
      status = $utility.setAnyTextField("resumator-address-value", "id","1226 W 30th st", browser)
      status = $utility.setAnyTextField("resumator-city-value", "id","Los Angeles", browser)
      status = $utility.setAnyTextField("resumator-state-value", "id","CA", browser)
      status = $utility.setAnyTextField("resumator-postal-value", "id","90007", browser)
      status = $utility.setAnyTextField("resumator-phone-value", "id",$details["userCredentials"]["basic"]["phNo"], browser)


      browser.scroll.to browser.link(:id => "resumator-choose-upload")
      browser.link(:id => "resumator-choose-upload").click

      browser.file_field(:type,"file").set($details["userCredentials"]["resume"])



      begin
        browser.select_list(:id, "resumator-citizen-value").select_value("20")
      rescue => e
        puts e.message
      end

      begin
        browser.select_list(:id, "resumator-relocate-value").select_value("1")
      rescue => e
        puts e.message
      end

      begin
        status = $utility.setAnyTextField("resumator-salary-value", "id","$80k+", browser)
      rescue => e
        puts e.message
      end

      begin
        status = $utility.setAnyTextField("resumator-coverletter-value", "id",$details["userCredentials"]["CV"], browser)
      rescue => e
        puts e.message
        end

      begin
        status = $utility.setAnyTextField("resumator-college-value", "id","University of Southern California", browser)
      rescue => e
        puts e.message
      end

      status = $utility.setAnyTextField("resumator-wmyu-value", "id",$details["userCredentials"]["whyUnique"], browser)

      begin
        browser.input(:id => "resumator-submit-resume").click
      rescue => e
        browser.link(:id => "resumator-submit-resume").click
      end


      puts browser.url.white.on_green
    rescue => e
      puts browser.url.white.on_red
      puts e.message
      # puts e.backtrace
    end
  end


  def icims()
    browser = $utility.launch_browser("Desktop");
    browser.window.maximize

    browser = $utility.browser_goto(browser,"https://careers-vantagetravel.icims.com/jobs/1016/front-end-web-developer/job?mobile=false&width=960&height=500&bga=true&needsRedirect=false&jan1offset=-480&jun1offset=-420")
    begin
      browser.iframe(:id => "icims_content_iframe").div(:class => "iCIMS_JobOptions").div(:id => "jobOptionsMobile").link.click

      browser.iframe(:id => "icims_content_iframe").div(:class => "iCIMS_SocialLoginButtonContainer").link(:class => "socialLoginButton", :index => 0).click

      browser.windows.last.use do
        begin
          status = $utility.setAnyTextField("session_key-oauth2SAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["user"], browser)
          status = $utility.setAnyTextField("session_password-oauth2SAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["pass"], browser)

          browser.input(:type => "submit").when_present.click
        rescue => e
          browser.input(:type => "submit").click
        end
      end

      browser.iframe(:id => "icims_content_iframe").file_field(:type,"file").set($details["userCredentials"]["resume"])
      sleep(5)

      browser.scroll.to browser.iframe(:id => "icims_content_iframe").select_list(:id, "rcf3048")

      browser.iframe(:id => "icims_content_iframe").select_list(:id, "rcf3048").select_value("Internet - LinkedIn")


      browser.iframe(:id => "icims_content_iframe").input(:type => "submit").when_present.click

      puts browser.url.white.on_green
    rescue => e
      puts browser.url.white.on_red
      puts e.message
      # puts e.backtrace
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
      puts browser.url.white.on_green
    rescue => e
      puts browser.url.white.on_red
      puts e.message
    end

  end

  def catsone(browser)
   begin
      begin
        browser.div(:id=> "jobDetails").div(:class=> "actionButtons").link.click
      rescue => e
        puts e.message
      end


      browser.file_field(:type,"file").set($details["userCredentials"]["resume"])

      status = $utility.setAnyTextField("0_field_1", "id",$details["userCredentials"]["basic"]["firstName"], browser)
      status = $utility.setAnyTextField("0_field_2", "id",$details["userCredentials"]["basic"]["lastName"], browser)
      status = $utility.setAnyTextField("0_field_3", "id",$details["userCredentials"]["basic"]["email"], browser)
      status = $utility.setAnyTextField("0_field_4", "id","1226 W 30th st", browser)
      status = $utility.setAnyTextField("0_field_5", "id","Los Angeles", browser)
      status = $utility.setAnyTextField("0_field_6", "id","CA", browser)
      status = $utility.setAnyTextField("0_field_7", "id","90007", browser)
      status = $utility.setAnyTextField("0_field_8", "id",$details["userCredentials"]["basic"]["phNo"], browser)

      # begin
      # rescue => e
      #   puts e.message
      # end

      browser.input(:type => "submit").click
      sleep(5)
      puts browser.url.white.on_green

   rescue => e
     puts browser.url.white.on_red
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
      puts browser.url.white.on_green
    rescue => e
      puts browser.url.white.on_red
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

      sleep(5)

      begin
        status = $utility.setAnyTextField("session_key-oauthAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["user"], browser)
        status = $utility.setAnyTextField("session_password-oauthAuthorizeForm", "id",$details["userCredentials"]["linkedIn"]["pass"], browser)

        browser.input(:type => "submit").click
      rescue => e
        browser.input(:type => "submit").click
      end
      puts browser.url.white.on_green
    rescue => e
      puts browser.url.white.on_red
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
      puts browser.url.white.on_green
    rescue => e
      puts browser.url.white.on_red
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
      puts browser.url.white.on_green
    rescue => e
      puts browser.url.white.on_red
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
    puts browser.url.white.on_green

  end

  def greenhouse(browser)
  # def greenhouse()

    # browser = $utility.launch_browser("Desktop");
    # browser.window.maximize
    #
    # browser = $utility.browser_goto(browser,"https://boards.greenhouse.io/vungle/jobs/185646?t=e14v6k#.VvCJJBIrIUE");
    begin


      browser.scroll.to browser.button(:class => "apply-with-linkedin-button")
      browser.button(:class => "apply-with-linkedin-button").click
      browser.windows.last.use do
        linkedinWindow(browser)
      end
      browser.scroll.to browser.input(:id => "first_name")
      status = $utility.setAnyTextField("first_name", "id",$details["userCredentials"]["basic"]["firstName"], browser)
      status = $utility.setAnyTextField("last_name", "id",$details["userCredentials"]["basic"]["lastName"], browser)
      status = $utility.setAnyTextField("phone", "id",$details["userCredentials"]["basic"]["phNo"], browser)
      status = $utility.setAnyTextField("email", "id",$details["userCredentials"]["basic"]["email"], browser)
      begin
        status = $utility.setAnyTextField("job_application_location", "id","Los Angeles, CA, United States", browser)
      rescue => e
        puts e.message
      end
      browser.div(:class=> "attach-or-paste", :index => 1).div(:class=> "link-container").link(:index => 3).click
      browser.textarea(:id => "cover_letter_text").set $details["userCredentials"]["CV"]
      puts browser.url.white.on_green

      begin
        browser.input(:id => "job_application_eu_privacy_consent").click
      rescue => e
        puts browser.url.white.on_red
        puts e.message
      end

      browser.input(:id => "submit_app").click

      # browser.scroll.to browser.input(:id => "first_name")
      # status = $utility.setAnyTextField("job_application_location", "id","Los Angeles, CA, United States", browser)
      # browser.div(:class=> "cover_letter_chosen ").div(:class=> "link-container").link(:index => 2).click
      # browser.textarea(:id => "resume_text").set $details["userCredentials"]["CV"]
      # status = $utility.setAnyTextField("job_application_answers_attributes_0_text_value", "id","University of Southern California", browser)
      # status = $utility.setAnyTextField("job_application_answers_attributes_1_text_value", "id","Computer Science", browser)
      # status = $utility.setAnyTextField("job_application_answers_attributes_2_text_value", "id","https://www.linkedin.com/in/princehemrajani", browser)
      # status = $utility.setAnyTextField("job_application_answers_attributes_4_text_value", "id","LinkedIn", browser)
      # browser.select_list(:id, "job_application_answers_attributes_5_boolean_value").select_value(1)
      # browser.select_list(:id, "job_application_answers_attributes_6_boolean_value").select_value(0)
      # status = $utility.setAnyTextField("job_application_location", "id","Los Angeles, CA, United States", browser)
      # browser.input(:id => "submit_app").click


    sleep(5)
    rescue => e
      puts browser.url.white.on_red
      puts(e.message)
    end

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
