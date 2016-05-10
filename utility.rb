
class Utility
  def closeOverlay(browser)
    browser.send_keys :escape
    return broswer
  end
  def getCookies(browser, cookieName)
    cookieJar = browser.cookies.to_a
    cookieJar.each{|cookie|
      if cookie[:name].eql? cookieName
        return true, cookie
      end
    }
    return false, "Couldn't find cookie."
  end
  def click_link(elementName, elementType, browser)
    begin
      case elementType #Check the first byte of the response code.
        when 'class' then
          broswer.a(:class, elementName).when_present.click
          return ''
        when 'id' then
          browser.a(:id, elementName).when_present.click
          return ''
        when 'value' then
          browser.a(:value, elementName).when_present.click
          return ''
        when 'href' then
          browser.a(:href, elementName).when_present.click
          return ''
        when 'onclick' then
          browser.a(:onclick, elementName).when_present.click
          return ''
        else return "link Not Found"
    end
    rescue Watir::Exception::UnknownObjectException,
      Watir::Exception::ObjectDisabledException,
      Watir::Exception::ObjectReadOnlyException,
      Watir::Exception::NoValueFoundException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Watir::Exception::UnknownCellException,
      Watir::Exception::NoMatchingWindowFoundException,
      Watir::Exception::NoStatusBarException,
      Watir::Exception::NavigationException,
      Watir::Exception::UnknownFrameException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Selenium::WebDriver::Error::ElementNotVisibleError => e
      errorMessage = "cannot Find Element: " + elementType+ ": " + elementName
      return errorMessage
    end

  end

  def click_button(elementName, elementType, browser)
    begin
      case elementType #Check the first byte of the response code.
        when 'class' then
          browser.button(:class, elementName).when_present.click
          return ''
        when 'id' then
          browser.button(:id, elementName).when_present.click
          return ''
        when 'value' then
          browser.button(:value, elementName).when_present.click
          return ''
        when 'href' then
          browser.button(:href, elementName).when_present.click
          return ''
        when 'onclick' then
          browser.button(:onclick, elementName).when_present.click
          return ''
        else return "link Not Found"
      end
    rescue Watir::Exception::UnknownObjectException,
        Watir::Exception::ObjectDisabledException,
        Watir::Exception::ObjectReadOnlyException,
        Watir::Exception::NoValueFoundException,
        Watir::Exception::MissingWayOfFindingObjectException,
        Watir::Exception::UnknownCellException,
        Watir::Exception::NoMatchingWindowFoundException,
        Watir::Exception::NoStatusBarException,
        Watir::Exception::NavigationException,
        Watir::Exception::UnknownFrameException,
        Watir::Exception::MissingWayOfFindingObjectException,
        Selenium::WebDriver::Error::ElementNotVisibleError => e
      errorMessage = "cannot Find Element: " + elementType+ ": " + elementName
      return errorMessage
    end

  end



  def setAnyTextField(elementName, elementType, text, browser)
    begin
      case elementType #Check the first byte of the response code
      when 'class' then
        browser.text_field(:class, elementName).set text
        return ''
      when 'id' then
        browser.text_field(:id, elementName).set text
        return ''
      when 'name' then
        browser.text_field(:name, elementName).set text
        return ''
      else return "Element Not Found"
    end
    rescue Watir::Exception::UnknownObjectException,
      Watir::Exception::ObjectDisabledException,
      Watir::Exception::ObjectReadOnlyException,
      Watir::Exception::NoValueFoundException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Watir::Exception::UnknownCellException,
      Watir::Exception::NoMatchingWindowFoundException,
      Watir::Exception::NoStatusBarException,
      Watir::Exception::NavigationException,
      Watir::Exception::UnknownFrameException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Selenium::WebDriver::Error::ElementNotVisibleError => e
      errorMessage = "Cannot Find Element: " + elementType + ": " + elementName
      return errorMessage
    end
  end



  def getAnyTextfield(elementName, elementType, browser)
    error = ''
    begin
    case elementType # Check the first byte of the response code.
      when 'class' then return true, browser.text_field(:class, elementName).value
      when 'id' then return true, browser.text_field(:id, elementName).value
      when 'name' then return true, browser.text_field(:name, elementName).value
      else return false, "Element Not Found"
    end
    rescue  Watir::Exception::UnknownObjectException,
      Watir::Exception::ObjectDisabledException,
      Watir::Exception::ObjectReadOnlyException,
      Watir::Exception::NoValueFoundException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Watir::Exception::UnknownCellException,
      Watir::Exception::NoMatchingWindowFoundException,
      Watir::Exception::NoStatusBarException,
      Watir::Exception::NavigationException,
      Watir::Exception::UnknownFrameException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Selenium::WebDriver::Error::ElementNotVisibleError => e
      errorMessage = "Cannot Find Element: " + elementType + ": " + elementName
      return false, "Element Not Found: " + errorMessage
    end
  end

  def setAnySelectList(elementName, elementType, choice, browser)
    begin
    case elementType # Check the first byte of the response code.
      when 'class' then
        browser.select_list(:class, elementName).select choice
        return ''
      when 'id' then
        browser.select_list(:id, elementName).select choice
        return ''
      when 'value' then
        browser.select_list(:text, elementName).options[choice].select
        return ''
      when 'name' then
        browser.select_list(:name, elementName).options[value => choice].select
        return ''
      else return "Element Not Found"
    end
    rescue  Watir::Exception::UnknownObjectException,
      Watir::Exception::ObjectDisabledException,
      Watir::Exception::ObjectReadOnlyException,
      Watir::Exception::NoValueFoundException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Watir::Exception::UnknownCellException,
      Watir::Exception::NoMatchingWindowFoundException,
      Watir::Exception::NoStatusBarException,
      Watir::Exception::NavigationException,
      Watir::Exception::UnknownFrameException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Selenium::WebDriver::Error::ElementNotVisibleError => e
      errorMessage = "Cannot Find Element: " + elementType + ": " + elementName
      return errorMessage
    end
  end
  def setAnyRadio(elementName, elementType, browser)
    begin
    case elementType # Check the first byte of the response code.
      when 'class' then
        browser.radio(:class, elementName).set
        return ''
      when 'id' then
        browser.radio(:id, elementName).set
        return ''
      else return "Element Not Found"
    end
    return ""
    rescue  Watir::Exception::UnknownObjectException,
      Watir::Exception::ObjectDisabledException,
      Watir::Exception::ObjectReadOnlyException,
      Watir::Exception::NoValueFoundException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Watir::Exception::UnknownCellException,
      Watir::Exception::NoMatchingWindowFoundException,
      Watir::Exception::NoStatusBarException,
      Watir::Exception::NavigationException,
      Watir::Exception::UnknownFrameException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Selenium::WebDriver::Error::ElementNotVisibleError => e
      errorMessage = "Cannot Find Element: " + elementType + ": " + elementName
      return errorMessage
    end
  end

  def setAnyCheckbox(elementName, elementType, browser)
    begin
    case elementType # Check the first byte of the response code.
      when 'class' then
        browser.checkbox(:class, elementName).set true
        return ''
      when 'id' then
        browser.checkbox(:id, elementName).set true
        return ''
      when 'value' then
        browser.checkbox(:id, elementName).set true
        return ''
      else return "Element Not Found"
    end
    return ""
    rescue  Watir::Exception::UnknownObjectException,
      Watir::Exception::ObjectDisabledException,
      Watir::Exception::ObjectReadOnlyException,
      Watir::Exception::NoValueFoundException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Watir::Exception::UnknownCellException,
      Watir::Exception::NoMatchingWindowFoundException,
      Watir::Exception::NoStatusBarException,
      Watir::Exception::NavigationException,
      Watir::Exception::UnknownFrameException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Selenium::WebDriver::Error::ElementNotVisibleError => e
      errorMessage = "Cannot Find Element: " + elementType + ": " + elementName
      return errorMessage
    end
  end

  def clearAnyCheckbox(elementName, elementType, browser)
    begin
    case elementType # Check the first byte of the response code.
      when 'class' then
        browser.checkbox(:class, elementName).clear
        return ''
      when 'id' then
        browser.checkbox(:id, elementName).clear
        return ''
      when 'value' then
        browser.checkbox(:id, elementName).clear
        return ''
      else return "Element Not Found"
    end
    return ""
    rescue  Watir::Exception::UnknownObjectException,
      Watir::Exception::ObjectDisabledException,
      Watir::Exception::ObjectReadOnlyException,
      Watir::Exception::NoValueFoundException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Watir::Exception::UnknownCellException,
      Watir::Exception::NoMatchingWindowFoundException,
      Watir::Exception::NoStatusBarException,
      Watir::Exception::NavigationException,
      Watir::Exception::UnknownFrameException,
      Watir::Exception::MissingWayOfFindingObjectException,
      Selenium::WebDriver::Error::ElementNotVisibleError => e
      errorMessage = "Cannot Find Element: " + elementType + ": " + elementName
      return errorMessage
    end
  end

  def generateArtist
    artists = { "98 Degrees" => "121852", "Abigail Washburn" => "119985", "Aaron Nicholas" => "111819", "Donell Jones"=>"1186", "A Current Affair"=>"206474", "ACTIVATE" => "211794", "Adrenalyn" => "206221","AEROPLANE" => "110634", "Aesop" => "202174", "American Royalty" => "608", "Anthrax"=>"103897","Carnage"=>"124512", "Carrie Underwood"=>"104052","Cher"=>"202434", "Chiddy Bang"=>"110727", "Close to Home" => "111422", "Daddy Yankee" => "200272", "Daft Punk"=>"200273", "Dan Black" => "208509", "Dazz Band" => "120422", "Deadmau5" => "110703", "Elvis Costello" => "200364", "Evanescence" => "115425", "Fixers" => "207605", "French Montana" => "116619", "Jeff Bridges" => "250317", "Jeff Beck"=>"2000534", "Jingle Jazz" => "957", "Joan Baez" => "113359", "Jonny Lang"=>"104375"}

    key = artists.keys[rand(artists.length).to_i]
    artistID = artists[key]
    return {key => artistID}
  end

  def generateArtist_Sports
    artists = { "303 Boards Premier" => "203405", "Randy Stuckless"=>"251338", "Borås Basket"=>"251343","Eco Örebro"=>"251344", "Abner Mares"=>"488", "Advance Auto Parts Monster Jam"=>"117635", "Anselmo Moreno"=>"250015", "Anthony Joshua"=>"251073", "Arenacross"=>"601", "Atlanta Steam"=>"250548"}

    key = artists.keys[rand(artists.length).to_i]
    artistID = artists[key]
    return {key => artistID}
  end

  def translate_string_compare(code)
    if code == -1
      return false
    elsif code == 1
      return false
    elsif code ==0
      return true
    else
      return false
    end
  end

  def launch_browser(user_agent)
    browser_type = $current_browser
    if user_agent == 'Desktop'
      if browser_type == 'Firefox'
        b=Watir::Browser.new
        b.send_keys [:command, :subtract]
        b.send_keys [:command, :subtract]
        return b
      elsif browser_type == 'Chrome'
        b = Watir::Browser.new :chrome
        return b
      end
    elsif user_agent == 'Mobile'
      b = Watir::Browser.new :firefox
      d = Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iphone, :orientation => :landscape)
      b = Watir::Browser.new d
    else
      b=Watir::Browser.new
      b.manage.window.maximize
      b.send_keys [:command, :subtract]
      b.send_keys [:command, :subtract]
      return b, d
    end
# browser_type = @@configuration["browser_type"]
#   if user_agent == 'Desktop'
#     if browser_type == 'Firefox'
#       b=Watir::Browser.new
#       return b
#     elsif browser_type == 'Chrome'
#       b = Watir::Browser.new :chrome
#       return b
#     end
#   elsif user_agent == 'Mobile'
#     b = Watir::Browser.new :firefox
#     d = Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iphone, :orientation => :landscape)
#     b = Watir::Browser.new d
#   else
#     b=Watir::Browser.new
#     return b, d
#   end
  end

  def browser_goto(browser, url)
    browser.goto url
    # browser.cookies.add('axs_suppressed_ads', '1%2C2%2C3', {:path => "/"})
    sleep 2
    if browser.html.include?("Skip this Ad")
      browser.send_keys :escape
    end
    browser.refresh
    sleep 3
    return browser
  end

  def kill_browser (user_agent, browser_object)
    if user_agent == 'Desktop'
      browser_object.quit()
    elsif user_agent == 'Mobile'
      browser_object.quit()
      system("killall -9 'Firefox'") #For Mac
      system("killall -9 'firefox-bin'") #For Mac
      system("killall -9 'firefox'") #For Ubuntu
      system("killall -9 'chromium'")
      system("killall -9 'chrome'")
    end
  end

  def show_wait_cursor(seconds,fps=10)
  chars = %w[| / - \\]
  delay = 1.0/fps
  (seconds*fps).round.times{ |i|
    print chars[i % chars.length]
    sleep delay
    print "\b"
  }
  end
  def show_wait_spinner(fps=10)
  chars = %w[| / - \\]
  delay = 1.0/fps
  iter = 0
  spinner = Thread.new do
    while iter do  # Keep spinning until told otherwise
      print chars[(iter+=1) % chars.length]
      sleep delay
      print "\b"
    end
  end
  yield.tap{       # After yielding to the block, save the return value
    iter = false   # Tell the thread to exit, cleaning up after itself…
    spinner.join   # …and wait for it to do so.
  }                # Use the block's return value as the method's
  end

  def setMCEcontent(mceId, html)
    execString = "tinyMCE.get('" + MCEid + "').setContent('" + html + "');"
    b.execute_script(execString)
  end

  def getMCEcontent(mceId)
    execString = "tinyMCE.get('" + MCEid + "').getContent();"
    return b.execute_script(execString)
  end

  def checkSectionHeadline(iframe, sectionID)
    return iframe.table(:class => "main_table").row(:id => sectionID).table(:class => "section_heading").td(:class => 'center', :class => 'axscc-label').text
  end

  def getUpcomingEvents(venue)
    latitude = ""
    longitude = ""
    siteID = ""
    url = ""
    apiBaseUrl = ""
    apiToken = ""
    apiBaseUrl = $configuration['API']
    apiToken = $configuration['APIToken']
    venueID="["
    $venueData["Venues"].each do |child|
      if(child["name"] == venue)
        latitude = child["lat"]
        longitude = child["long"]
        siteID = child["siteID"]
        if(siteID == "1" && child["name"]!="AXS Marketing")

          child["venueIDs"].length.times do |i|
            if(i == (child["venueIDs"].length-1))
              venueID = venueID + child["venueIDs"][i] + ']'
            else
              venueID = venueID + child["venueIDs"][i] + ','
            end
          end

          url =  apiBaseUrl + 'events' + apiToken + '&siteId=' + siteID + '&venueId=' + venueID + "&rows=200"
          puts url
        else
          url = apiBaseUrl + 'events' + apiToken + '&siteId=' + siteID + "&rows=200"
          puts url
        end
      end
    end
    response = RestClient.get url
    jsonify= JSON.parse(response)
    events = jsonify["events"]
    if(events.length == 0)
      raise("NO UPCOMING EVENTS FOR THIS VENUE EXITING THREAD NOW")
    end
    return events
  end
end
