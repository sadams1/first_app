#require File.dirname(__FILE__) + '/../test_helper'
require "selenium"
require "test/unit"

class NewTest < Test::Unit::TestCase
  def setup
    @verification_errors = []
    if $selenium
      @selenium = $selenium
    else
      @selenium = Selenium::SeleniumDriver.new("localhost", 4444, "*chrome", "https://ciaqa2ws1.intuit.com/", 10000);

      @selenium.start
    end
    @selenium.set_context("test_new")
  end

  def teardown
    @selenium.stop unless $selenium
    assert_equal [], @verification_errors
  end

  def test_new
    @selenium.open "/"
    @selenium.type "ps_txt", "taxes"
    @selenium.click "link=Go"
    @selenium.wait_for_page_to_load "30000"
    begin
        assert @selenium.is_text_present("17 results found on \"taxes\"")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
    @selenium.click "link=Today"
    @selenium.wait_for_page_to_load "30000"

    begin
        assert @selenium.is_text_present("0 results found on \"taxes\"")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
    @selenium.click "css=p"
    @selenium.wait_for_page_to_load "30000"
    begin
        assert @selenium.is_text_present("exact:What's TurboTax Live Community?")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
  end
end