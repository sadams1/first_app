require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"

class Untitled < Test::Unit::TestCase

  def setup
    @verification_errors = []
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*chrome",
      :url => "https://ciaqa2ws1.intuit.com/",
      :timeout_in_second => 60

    @selenium.start_new_browser_session
  end

  def teardown
   # @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end

  def test_untitled
    @selenium.open "/"
    @selenium.click "link=Sign In"
    @selenium.wait_for_page_to_load "30000"
    @selenium.type "memberid", "auto1"
    @selenium.type "password", "automation1"
    @selenium.click "css=input.button.button-default"
    @selenium.wait_for_page_to_load "30000"
    begin
        assert @selenium.is_text_present("Sign out")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
  end
end