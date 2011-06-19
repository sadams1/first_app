require "spec_helper"
require "selenium/client"
require "rubygems"

gem "selenium-client"

describe "Live Community Selenium Regression Tests (#{ENV["browser"]})" do

  # First run the Smoke tests
  #load File.expand_path(File.join(File.dirname(__FILE__),'selenium_smoke_tests_spec.rb'))

  before(:all) do
    @verification_errors = []
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => (ENV["browser"].equal?(nil) ? "*firefox" : ENV["browser"]),
      :url => Shared::SeleniumTestUtilities::FRONT_END_URL,
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

  it "should test Solved, Helpful, Not Helpful buttons are only shown to user that asked question" do
    print_this "- should test Solved, Helpful, Not Helpful buttons are only shown to user that asked question"
    post_subject = get_eval("'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {     var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);     return v.toString(16); }).toUpperCase();")
    print_this "  Sign In and ask a question as #{Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username]} - #{post_subject}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username], Shared::SeleniumTestUtilities::AUTO_USER_ONE[:password]
    ask_question post_subject, post_subject, false, "Other Topics", nil
    logout_full_view
    print_this "  Sign In and answer the question as #{Shared::SeleniumTestUtilities::AUTO_USER_TWO[:username]}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_TWO[:username], Shared::SeleniumTestUtilities::AUTO_USER_TWO[:password]
    answer_question(post_subject, "This is the answer to #{post_subject}. 1099 401k 1040")
    logout_full_view
    print_this "  Verify buttons are displayed for #{Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username]}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username], Shared::SeleniumTestUtilities::AUTO_USER_ONE[:password]
    select_post(post_subject)
    is_element_present("css=li.vote_solved").should == true
    is_element_present("css=li.vote_helpful").should == true
    is_element_present("css=li.vote_nothelpful").should == true
    logout_full_view
    print_this "  Verify buttons are not displayed for #{Shared::SeleniumTestUtilities::AUTO_USER_TWO[:username]}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_TWO[:username], Shared::SeleniumTestUtilities::AUTO_USER_TWO[:password]
    select_post(post_subject)
    is_element_present("css=li.vote_solved").should == false
    is_element_present("css=li.vote_helpful").should == false
    is_element_present("css=li.vote_nothelpful").should == false
    logout_full_view
    print_this "- should test Solved, Helpful, Not Helpful buttons are only shown to user that asked question"
    print_this "PASS"
  end

  it "should test Solved, Helpful, Not Helpful buttons are not displayed if a post has been marked Helpful" do
    print_this "- should test Solved, Helpful, Not Helpful buttons are not displayed if a post has been marked Helpful"
    post_subject = get_eval("'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {     var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);     return v.toString(16); }).toUpperCase();")
    print_this "  Ask a question as #{Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username]} - #{post_subject}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username], Shared::SeleniumTestUtilities::AUTO_USER_ONE[:password]
    ask_question post_subject, post_subject, false, "Other Topics", nil
    logout_full_view
    print_this "  Sign In and answer the question as #{Shared::SeleniumTestUtilities::AUTO_USER_TWO[:username]}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_TWO[:username], Shared::SeleniumTestUtilities::AUTO_USER_TWO[:password]
    answer_question(post_subject, "This is the answer to #{post_subject}. 1099 401k 1040")
    logout_full_view
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username], Shared::SeleniumTestUtilities::AUTO_USER_ONE[:password]
    select_post(post_subject)
    is_element_present("css=li.vote_solved").should == true
    is_element_present("css=li.vote_helpful").should == true
    is_element_present("css=li.vote_nothelpful").should == true
    print_this "  Mark the answer as Helpful"
    mark_answer post_subject, 1, Shared::SeleniumTestUtilities::HELPFUL
    print_this "  Verify that the buttons are not visible"
    is_element_present("css=li.vote_solved").should == false
    is_element_present("css=li.vote_helpful").should == false
    is_element_present("css=li.vote_nothelpful").should == false
    logout_full_view
    print_this "- should test Solved, Helpful, Not Helpful buttons are not displayed if a post has been marked Helpful"
    print_this "PASS"
  end

  it "should test Solved, Helpful, Not Helpful buttons are not displayed if a post has been marked Solved" do
    print_this "- should test Solved, Helpful, Not Helpful buttons are not displayed if a post has been marked Solved"
    post_subject = get_eval("'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {     var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);     return v.toString(16); }).toUpperCase();")
    print_this "  Ask a question as #{Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username]} - #{post_subject}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username], Shared::SeleniumTestUtilities::AUTO_USER_ONE[:password]
    ask_question post_subject, post_subject, false, "Other Topics", nil
    logout_full_view
    print_this "  Login and answer the question as #{Shared::SeleniumTestUtilities::AUTO_USER_TWO[:username]}"
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_TWO[:username], Shared::SeleniumTestUtilities::AUTO_USER_TWO[:password]
    answer_question(post_subject, "This is the answer to #{post_subject}. 1099 401k 1040")
    logout_full_view
    login_full_view Shared::SeleniumTestUtilities::AUTO_USER_ONE[:username], Shared::SeleniumTestUtilities::AUTO_USER_ONE[:password]
    select_post(post_subject)
   is_element_present("css=li.vote_solved").should == true
    is_element_present("css=li.vote_helpful").should == true
    is_element_present("css=li.vote_nothelpful").should == true
    print_this "  Mark the answer as Solved"
    mark_answer post_subject, 1, Shared::SeleniumTestUtilities::SOLVED
    print_this "  Verify that the buttons are not visible"
    is_element_present("css=li.vote_solved").should == false
    is_element_present("css=li.vote_helpful").should == false
    is_element_present("css=li.vote_nothelpful").should == false
    logout_full_view
    print_this "- should test Solved, Helpful, Not Helpful buttons are not displayed if a post has been marked Solved"
    print_this "PASS"
  end

end
