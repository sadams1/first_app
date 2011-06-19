require 'rubygems'
gem "rspec", ">=1.2.6"
gem "selenium-client", ">=1.2.16"
require "selenium/client"
require "spec_helper"
require "test/unit"
#require 'selenium_test_utilities'
#load "selenium_test_utilities.rb"
#include "selenium_test_utilities"

    describe "Google Search" do
        attr_reader :selenium_driver
        alias :page :selenium_driver

      before(:all) do
        @selenium_driver = Selenium::Client::Driver.new \
              :host => "localhost",
              :port => 4444,
              :browser => "*firefox",
              #:url => "http://www.google.com",
              :url => "https://ciaqa2ws1.intuit.com",
              :timeout_in_second => 60
      end

      before(:each) do
        selenium_driver.start_new_browser_session
      end

      # The system capture need to happen BEFORE closing the Selenium session
      after(:all) do
        @selenium_driver.close_current_browser_session
      end

      it "can find Selenium" do
        page.open "/"
#        page.title.should eql("Google")
#        page.type "q", "Selenium seleniumhq"
#        page.click "btnG", :wait_for => :page
#        page.value("q").should eql("Selenium seleniumhq")
#        page.text?("seleniumhq.org").should be_true
#        page.title.should eql("Selenium seleniumhq - Google Search")
#        page.text?("seleniumhq.org").should be_true
#                page.element?("link=Cached").should be_true
         # page.click "link=Sign In"
         # page.wait_for_page_to_load "30000"
         # page.type "memberid", "auto1"
         # page.type "password", "automation1"
         # page.click "css=input.button.button-default"
         # page.wait_for_page_to_load "30000"
         # begin
         #     page.is_text_present("Sign in").should be_true
         # rescue ExpectationNotMetError
         #     @verification_errors << $!
         # end


        print_this ""
        print_this "- should test search full view"
        print_this "  Sign In as #{Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username]}"
        login_full_view Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username], Shared::SeleniumTestUtilities::AUTO_USER_ONE[:password]
        print_this "  Search for 'test'"
        search "test"
        click_and_wait "link=All time" if is_element_present "link=All time"
        print_this "  Verify search results contain 'test'"
        is_element_present("css=div:contains('test')").should == true
        logout_full_view
        print_this "- should test search full view - PASS"
      end

        def print_this(text)
      #puts text if OUTPUT_VERBOSE
        end


    end
