require 'thread'
require 'rubygems'
require 'watir'
require 'watir-webdriver'
require 'rest_client'
require 'json'
require './utility.rb'
require './jobFrameworl.rb'
# require "./framework/utilityLogin.rb"
# require "./framework/emailer.rb"
require 'webdriver-user-agent'
require "watir-webdriver/wait"
require 'thread/pool'
require 'colorize'
require 'watir-scroll'

Watir.default_timeout = 180
#################################################################################################
# Scripts Section. 												  											   #
#################################################################################################

$details = JSON.parse(File.read('./details.json'))
$utility = Utility.new
$diffJobSites = DifferentSitesJob.new

$pool = Thread.pool(1)
$current_browser = "Firefox"


begin

  $details["jobSitetoApply"].each do |site|
    begin
      case site
        when "Ziprecruiter"
          $diffJobSites.jobZepRecruiter(site)
          $pool.shutdown

        when "linkedIn"
          $diffJobSites.icims()
          $diffJobSites.jobLinkedIn(site)
          $pool.shutdown

        when "workBridge"
          $diffJobSites.jobWorkBridge(site)
          $pool.shutdown

        when "glassDoor"
          $diffJobSites.jobglassDoor(site)
          $pool.shutdown

        when "smartRecruiter"
          $diffJobSites.jobsmartRecruiter(site)
          $pool.shutdown



      end
    rescue => e
      puts("problem occured with "+site)
      puts(e.message)
      puts(e.backtrace)

    end



  end
  puts("Successfully excecuted for all sites")
    $utility.kill_browser("Desktop",browser);
    pool.shutdown


rescue => e
  puts (e.backtrace)
  $utility.kill_browser("Desktop",browser);
  pool.shutdown

end



