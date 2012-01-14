require 'rubygems'
require 'test/unit'
require "sahi"

class KpsuApTest
  
  def init_browser()
    @browser_name = "firefox"
    userdata_dir = "/Users/seve/Applications/sahi/userdata"
    browser_path = "/Applications/Firefox.app/Contents/MacOS/firefox"
    browser_options = "-profile #{userdata_dir}/browser/ff/profiles/sahi0"
    return Sahi::Browser.new(browser_path, browser_options)
  end
    
  def setup
    @browser = init_browser()
    @browser.open
  end
  
  def goto(url = "http://www.kpsu.org/")
    @browser.navigate_to(url)
    @browser.link("/schedule").click		
  end
  
  
  
  def teardown
    if @browser
      @browser.close
      sleep(1)
    end
  end
  
  
end

k = KpsuApTest.new
k.setup