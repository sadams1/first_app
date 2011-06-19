require "spec_helper"
require "selenium/client"
require "rubygems"
require "test/unit"

gem "selenium-client"

describe "Live Community Selenium Smoke Tests (#{ENV["browser"]})" do
  before(:all) do
    @verification_errors = []
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      #:browser => (ENV["browser"].equal?(nil) ? "*firefox" : ENV["browser"]),
      #:url => Shared::SeleniumTestUtilities::FRONT_END_URL,
        :browser => "*chrome",
        :url => "https://ciaqa2ws1.intuit.com/",
      :timeout_in_second => 60
    @selenium.start_new_browser_session
    @selenium.window_maximize
    @selenium.get_eval("window.moveTo(0, 25)")
  end

  after(:all) do

    # Now cleanup any posts we created

    @selenium.close_current_browser_session
    #@verification_errors.should == []
  end

  it "should test search full view" do
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

  it "should test invalid sign in" do
    print_this ""
    print_this "- should test invalid sign in"
    print_this "  Sign In with invalid credentials"
    login_full_view "auto3", "invalidpassword"
    print_this "  Verify the Sign In error screen is displayed"
    is_element_present("css=div:contains('Sign in error')").should == true
    print_this "- should test invalid sign in - PASS"
  end

  it "should test ask answer thanks" do
    print_this ""
    print_this "- should test ask answer thanks"
    post_subject = @selenium.get_eval("'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {     var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);     return v.toString(16); }).toUpperCase();")
    print_this "  Sign In and ask a question as #{Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username]} - #{post_subject}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username], Shared::SeleniumTestUtilities::AUTO_USER_ONE[:password]
    clear_all_alerts
    open Shared::SeleniumTestUtilities::FULL_PAGE_URL
    ask_question post_subject, post_subject, false, "Other Topics", nil
    logout_full_view
    print_this "  Sign In and answer the question as #{Shared::SeleniumTestUtilities::AUTO_USER_TWO[:username]}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_TWO[:username], Shared::SeleniumTestUtilities::AUTO_USER_TWO[:password]
    click_and_wait "cat_allqa"
    print_this "  Verify question is displayed as a new question"
    "openquestion unread".should == @selenium.get_attribute("link=" + post_subject + "@class")
    print_this "  Answer Question"
    answer_question post_subject, "This is the answer to #{post_subject}.  1099 401k 1040"
    logout_full_view
    print_this "  Sign In and mark question solved as #{Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username]} - #{post_subject}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username], Shared::SeleniumTestUtilities::AUTO_USER_ONE[:password]
    print_this "  Verify question has new reply"
    is_visible("//img[@alt='New Reply']").should == true
    print_this "  Mark as Solved"
    mark_answer post_subject, 1, Shared::SeleniumTestUtilities::SOLVED
    print_this "  Verify question is marked as solved"
    is_text_present("solved").should == true
    print_this "  Send Thanks"
    click "sendthanks"
    sleep 3
    logout_full_view
    print_this "- should test ask answer thanks - PASS"
  end

  it "should test discussion topics" do
    print_this ""
    print_this "- should test discussion topics"
    print_this "  Sign In to full view as #{Shared::SeleniumTestUtilities::AUTO_USER_SUPER[:username]}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_SUPER[:username], Shared::SeleniumTestUtilities::AUTO_USER_SUPER[:password]
    click_and_wait "cat_allqa"
    print_this "  Open a discussion topic"
    if is_element_present"//li[@class='disctopic']" then
      disc_topic = @selenium.get_text "//li[@class='disctopic']"
      print_this "  Click topic " + disc_topic
      click_and_wait "link=" + disc_topic
      print_this "  Verify the discussion topic is displayed"
      print_this "  " + @selenium.get_text("//div[@id='category_header']/h2")
      get_text("//div[@id='category_header']/h2").should =~ /^#{Regexp.escape(disc_topic)}[\s\S][\s\S]*$/
    else
      print_this "  SKIP: No discussion topics found"
    end
    logout_full_view
    print_this "- should test discussion topics - PASS"
  end

  it "should test live view" do
    print_this ""
    print_this "- should test live view"
    print_this "  Sign In to full view as #{Shared::SeleniumTestUtilities::AUTO_USER_SUPER[:username]}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_SUPER[:username], Shared::SeleniumTestUtilities::AUTO_USER_SUPER[:password]
    click_and_wait "cat_allqa"
    print_this "  Open Live View"
    click_and_wait "link=Live View"
    print_this "  Verify Live View is displayed"
    print_this "  " + @selenium.get_text("//div[@id='liveview']/div/h3")
    get_text("//div[@id='liveview']/div/h3").should =~ /^Real-Time View of Live Community Activity[\s\S][\s\S]*$/
    logout_full_view
    print_this "- should test live view - PASS"
  end

  it "should test search mini view" do
    print_this ""
    print_this "- should test search mini view"
    print_this "  Open mini view"
    open_mini_view
    print_this "  Search for 'test'"
    type "query", "test"
    click "searchgo"
    select_popup "__postPopUp"
    click_and_wait "link=All time"
    print_this "  Verify that 'test' appears"
    is_element_present("css=div:contains('test')").should == true
    if is_element_present "//div[@onclick='window.close();']" then
      click "//div[@onclick='window.close();']"
    end
    print_this "- should test search mini view - PASS"
  end

end