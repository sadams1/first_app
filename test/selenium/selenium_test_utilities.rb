require "selenium/client"

module Shared
  module SeleniumTestUtilities

    # Defaults to the build machine, not verbose, no initialization
    FRONT_END_URL = ENV['front_end_url'] || "http://lcp-build.sd.intuit.com:8080"
    BACK_END_URL =  ENV['back_end_url']  || "http://lcp-build.sd.intuit.com:8080"
    # ENV['verbose'] Prints out extra information to stdout
    OUTPUT_VERBOSE = ENV['verbose'] || false

    FULL_PAGE_URL = FRONT_END_URL + "/app/full_page?prodID=0"
    MINI_VIEW_URL = FRONT_END_URL + "/app/mini_page2?ppid=&tags=welcome&w=1680&h=1050&prodID=32&csrc=&trial=false"
    HORZ_MINI_VIEW_URL = MINI_VIEW_URL + "&layout=h"
    ADMIN_TOOL_URL = BACK_END_URL + "/login"

    NOT_HELPFUL = "I found this answer not helpful"
    HELPFUL = "I found this answer helpful"
    SOLVED = "This answer solved my question"

    EXPIRATION_ONE_WEEK = "one week from today"
    EXPIRATION_ONE_MONTH = "one month from today"
    EXPIRATION_THREE_MONTHS = "three months from today"

    MAX_ANSWERS_MINI_VIEW_HIGH_RES_NO_REC = 7
    MAX_ANSWERS_MINI_VIEW_LOW_RES_NO_REC = 3
    # TODO: Change these numbers once we fix FBI001935
    MAX_ANSWERS_MINI_VIEW_HIGH_RES_W_REC = 7
    MAX_ANSWERS_MINI_VIEW_LOW_RES_W_REC = 3

    MAX_QUESTIONS_MINI_VIEW_HIGH_RES_NO_REC = 2
    MAX_QUESTIONS_MINI_VIEW_LOW_RES_NO_REC = 2
    MAX_QUESTIONS_MINI_VIEW_HIGH_RES_W_REC = 2
    MAX_QUESTIONS_MINI_VIEW_LOW_RES_W_REC = 2

    THUMBS_UP = 0 #"a[@class='good']"
    THUMBS_DOWN = 1 #"a[@class='bad']"

    YEARLY_LEADERBOARD = 1
    WEEKLY_LEADERBOARD = 3

    POINTS_EARNED_FOR_ANSWERING = 1
    POINTS_EARNED_USER_HELPFUL = 1
    POINTS_EARNED_ASKER_HELPFUL = 5
    POINTS_EARNED_ASKER_SOLVED = 10

    # Ascii values for keys.  Add as you need them.
    KEY_RETURN = 13
    KEY_ESC = 27
    KEY_LEFT = 37
    KEY_UP = 38
    KEY_RIGHT = 39
    KEY_DOWN = 40

    AUTO_USER_ONE =   { :username => "auto1",
                        :nickname => "auto1",
                        :password => "automation1",
                        :email    => "daniel_fontanesi@intuit.com",
                        :type     => "automationuser"}
    AUTO_USER_TWO =   { :username => "auto2",
                        :nickname => "auto2",
                        :password => "automation2",
                        :email    => "daniel_fontanesi@intuit.com",
                        :type     => "automationuser"}
    AUTO_USER_THREE = { :username => "auto3",
                        :nickname => "auto3",
                        :password => "automation3",
                        :email    => "daniel_fontanesi@intuit.com",
                        :type     => "automationuser"}
    AUTO_USER_FOUR =  { :username => "auto4",
                        :nickname => "auto4",
                        :password => "automation4",
                        :email    => "daniel_fontanesi@intuit.com",
                        :type     => "automationuser"}
    AUTO_USER_FIVE =  { :username => "auto5",
                        :nickname => "auto5",
                        :password => "automation5",
                        :email    => "daniel_fontanesi@intuit.com",
                        :type     => "automationuser"}
    AUTO_USER_SIX =   { :username => "auto6",
                        :nickname => "auto6",
                        :password => "automation6",
                        :email    => "daniel_fontanesi@intuit.com",
                        :type     => "automationuser"}
    AUTO_USER_SUPER = { :username => "superauto1",
                        :nickname => "superauto1",
                        :password => "automation1",
                        :email    => "daniel_fontanesi@intuit.com",
                        :type     => "superuser"}
    AUTO_USER_MOD =   { :username => "modauto1",
                        :nickname => "modauto1",
                        :password => "automation1",
                        :email    => "daniel_fontanesi@intuit.com",
                        :type     => "moderator"}
    AUTO_USER_ADMIN = { :username => "autoadmin1",
                        :nickname => "autoadmin1",
                        :password => "automation1",
                        :email    => "daniel_fontanesi@intuit.com",
                        :type     => "admin"}

    AUTOMATION_USERS = [ AUTO_USER_ONE,
                         AUTO_USER_TWO,
                         AUTO_USER_THREE,
                         AUTO_USER_FOUR,
                         AUTO_USER_FIVE,
                         AUTO_USER_SIX,
                         AUTO_USER_SUPER,
                         AUTO_USER_MOD,
                         AUTO_USER_ADMIN ]
    
    def print_this(text)
      puts text if OUTPUT_VERBOSE
    end

    def click_and_wait(element)
      click element
      @selenium.wait_for_page_to_load 20000
    end

    def click(element)
      @selenium.click element
    end

    def submit(element)
      @selenium.submit element
      @selenium.wait_for_page_to_load 20000
    end

    def type(field, text)
      @selenium.type field, text
    end

    def type_ajax(field, text)
      # First clear the field, just in case
      type field, ""
      @selenium.type_keys field, text
      # Now allow time for any ajax magic to happen
      sleep 5
    end

    def focus(field)
      @selenium.focus field
    end

    def blur(field)
      @selenium.fire_event field, "blur"
    end

    def select_popup(popup_name)
      @selenium.wait_for_pop_up popup_name, 30000
      @selenium.select_window popup_name
    end

    def select_window(name)
      @selenium.select_window name
    end

    def open url
      @selenium.open url
    end

    def close_window
      @selenium.close
    end

    def wait_for_element(element)
      @selenium.wait_for_element element
    end

    def get_value (field)
      @selenium.get_value field
    end

    def get_text(field)
      @selenium.get_text field
    end

    def select_frame(frame)
      @selenium.select_frame frame
    end

    def is_element_present(element)
      @selenium.is_element_present element
    end

    def is_visible(element)
      @selenium.is_visible element
    end

    def is_text_present(text)
      @selenium.is_text_present text
    end

    def wait_for_page_to_load(milliseconds)
      @selenium.wait_for_page_to_load milliseconds
    end

    def get_eval(javascript)
      @selenium.get_eval javascript
    end

    def key_press(field, key)
      #@selenium.focus field
      @selenium.key_down field, key
      @selenium.key_press field, key
      @selenium.key_up field, key
    end

    def get_xpath_count(element)
      @selenium.get_xpath_count(element).to_i
    end

    def print_current_method_name
     p caller[0][/`([^']*)'/, 1]
    end

    def refresh_page
      @selenium.refresh
      sleep 1
    end

    def select(id, value, label)
      if value == nil
        @selenium.select id, "label=#{label}"
      else
        @selenium.select id, "value=#{value}"
      end
    end

    def login_full_view(username, password)
      open FULL_PAGE_URL
      if(is_element_present("css=a:contains('Sign out')")) then logout_full_view end
      click_and_wait "css=a:contains('Sign In')"
      type "memberid", username
      type "password", password
      click_and_wait "css=input[value='Sign In']"
      if is_element_present("css=div:contains('Sign in error')") then
        #do nothing
      else
        is_element_present("css=a:contains('Sign out')").should == true
      end
    end

    def logout_full_view
      open FULL_PAGE_URL
      begin
        click_and_wait "css=a:contains('Sign out')" if is_element_present "css=a:contains('Sign out')"
      rescue
        @verification_errors << $!
      end

      10.times{ break if (@selenium.is_confirmation_present rescue false); sleep 1}
      begin
        if @selenium.is_confirmation_present
          text = @selenium.get_confirmation
          text.should =~ /^Are you sure you want to sign out[\s\S]$/
        end
      rescue
        @verification_errors << $!
      end
    end

    def open_mini_view
      @selenium.open MINI_VIEW_URL
      sleep 3
    end

    def open_horizontal_mini_view
      @selenium.open HORZ_MINI_VIEW_URL
      #sleep 2
    end

    # TODO: This routine only looks on the first page of posts under All Q&A.  This is normally the case
    # for automated testing, but to make it more robust, it could look through all the pages.
    def select_post(summary)
      #open FULL_PAGE_URL
      if(@selenium.is_element_present("cat_allqa")) then
        click_and_wait "cat_allqa"
      end
      # assert !60.times{ break if (@selenium.is_visible("link=" + summary) rescue false); sleep 1 }
      if(@selenium.is_element_present("link=" + summary)) then
        click_and_wait "link=" + summary
      end
    end

    def ask_question(summary, detail, send_email, topic, nickname)
      click_and_wait "cat_allqa"
      click "link=Ask A Question"
      select_popup "__postPopUp"
      sleep 2
      is_element_present("css=input#post_subject").should == true
      type "post_subject", summary
      type "post_detail", detail
      if @selenium.is_element_present "captcha_answer" then
        # We got here because there is a spam question to answer, we'll have to look up the answer in the database
        type "captcha_answer", BrainBuster.find_by_question(get_text("//label[@for='captcha_answer']")).answer
      end

      click "email_option" if (send_email ^ (@selenium.is_checked "email_option"))
      sleep 2
      click_and_wait "//input[@value='Submit']"
      if is_element_present "css=a:contains(" + topic + ")" then
        is_element_present("css=a:contains(" + topic +")").should == true
        click "css=a:contains(" + topic + ")"
        sleep 2
      else
        # We got here because Live Community found similar questions, click the Submit button
        click_and_wait "//form[@id='frm_send_question']/a[2]/span"
        if is_element_present "css=a:contains(" + topic + ")" then
          click "css=a:contains(" + topic + ")"
        end
      end
      if is_element_present "//input[@name='platform' and @value='win']" then
        click "//input[@name='platform' and @value='win']"
        # TODO: Change these hard-coded values to work on all platforms
        if @selenium.is_visible "sku" then select("sku", nil, "Premier") end
        if @selenium.is_visible "year" then select("year", nil, "2010") end
      end
      click_and_wait "//a[@id='category_form_button']"
      # For new users, we will get another dialog to enter the nickname
      if is_element_present "//input[@id='nickname']" then
        type "//input[@id='nickname']", nickname
        click "link=Check Availability"
        sleep 1
        click_and_wait "//div[@onclick='form_createnn_submit()']"
        # TODO: What if the nickname is not available?
      end
      sleep 2
      @selenium.close
      @selenium.select_window nil
      sleep 2
    end

    def ask_question_mini_view(summary, detail, send_email)
      select_popup "__postPopUp"
      if @selenium.is_element_present "link=Submit My Question" then
        # We got here because Live Community found similar answers to similar questions
        click_and_wait "link=Submit My Question"
      end
      # type "post_subject", summary  # No need to enter the subject.  It is pre-filled from mini-view
      type "post_detail", detail
      click "email_option" if (send_email ^ (@selenium.is_checked "email_option"))
      click_and_wait "//div[@class=\"post-button-txt\"]"
      click "link=Close"
      select_window nil
    end

    def answer_question(summary, answer)
      select_post(summary)
      click "link=Submit An Answer"
      select_popup "__postPopUp"
      type "txt_reply", answer
      click_and_wait "//input[@value=\"Submit\"]"
      click "//a[@onclick='window.close();']"
      select_window nil
      @selenium.wait_for_page_to_load 3000
    end

    def comment_question(summary, comment)
      select_post(summary)
      click "link=Add A Comment"
      select_popup("__postPopUp")
      type "txt_reply", comment
      click_and_wait "//input[@value=\"Submit\"]"
      click "//a[@onclick='window.close();']"
      select_window nil
      @selenium.wait_for_page_to_load 3000
    end

    def mark_answer(summary, index, mark)
      select_post summary
      click_and_wait "//div[@id='helpful-solved-button-form-" + index.to_s + "']/ul/li/a[@title=\"" + mark + "\"]"
    end

    def rate_answer(summary, index, rating)
      select_post summary
      if rating == THUMBS_UP then
        click "//div[@class='rate'][" + index.to_s + "]/a[@class='good']"  # doesn't work in IE6. Try /descendant::div[@class="foo"][5] instead.
      elsif rating == THUMBS_DOWN then
        click "//div[@class='rate'][" + index.to_s + "]/a[@class='bad']"   # doesn't work in IE6. Try /descendant::div[@class="foo"][5] instead.
      end
      sleep 1  # Wait for the page to refresh
      # If we are rating on the mini-view, then there will be a close button
      if @selenium.is_element_present "//div[@onclick=\"close_window()\"]" then
        click "//div[@onclick=\"close_window()\"]"
        @selenium.select_window nil
        sleep 1
      end
    end

    def search(term)
      is_element_present("css=input#ps_txt").should == true
      type "css=input#ps_txt", term
      click_and_wait "css=a:contains('Go')"
    end

#    def search_mini_view(term)
#      type "query", term
#      click "asklink"
#      @selenium.wait_for_page_to_load "30000"
#    end

    # Looks for the text 'X results for TurboTax' and returns the number of results
    def get_search_results
      select_popup "__postPopUp"
      results = @selenium.get_text "//h2"
      elements = results.split(" ")
      return elements[0].to_i
    end

    # Looks for the text 'X results for TurboTax' and returns the search phrase
    def get_search_phrase
      select_popup "__postPopUp"
      results = @selenium.get_text "//h2"
      elements = results.split(" ")
      return elements[3].to_i
    end

    # Gets the total points for a given user.  It is assumed that you have
    # already navigated to the leaderboard popup.
    def get_user_leaderboard_points(user, leaderboard)
      select_popup "__leaderboardPopUp"
      for x in 1..10 do
        if @selenium.get_table("//td[#{leaderboard}]/table.#{x.to_s}.1") == user then
          return (@selenium.get_table("//td[#{leaderboard}]/table.#{x.to_s}.2")).to_i
        end
      end
      return 0
    end

    # Gets the total points on the leaderboard.  It is assumed that you have
    # already navigated to the leaderboard popup.
    def get_total_leaderboard_points(leaderboard)
      total_points = 0
      select_popup "__leaderboardPopUp"
      for x in 1..10 do
        total_points += (@selenium.get_table("//td[#{leaderboard}]/table.#{x.to_s}.2")).to_i
      end
      return total_points
    end

    # Gets the max points on the leaderboard.  It is assumed that you have
    # already navigated to the leaderboard popup.
    def get_max_leaderboard_points(leaderboard)
      max_points = 0
      select_popup "__leaderboardPopUp"
      for x in 1..10 do
        points = (@selenium.get_table("//td[#{leaderboard}]/table.#{x.to_s}.2")).to_i
        if points > max_points then
          max_points = points
        end
      end
      return max_points
    end

    # Gets the min points on the leaderboard.  It is assumed that you have
    # already navigated to the leaderboard popup.
    def get_min_leaderboard_points(leaderboard)
      min_points = 100000
      select_popup "__leaderboardPopUp"
      for x in 1..10 do
        points = (@selenium.get_table("//td[#{leaderboard}]/table.#{x.to_s}.2")).to_i
        if points < min_points then
          min_points = points
        end
      end
      return min_points
    end

    # Gets the total points for the current user.  This routine assumes you
    # have already navigated to the My Q&A screen.
    def get_community_impact_points
      return get_text("//ul[@id='stats']/li[@class='points_earned']/span").to_i
    end

    # Gets the number of questions asked for the current user.  This routine assumes you
    # have already navigated to the My Q&A screen.
    def get_community_impact_asked
      return get_text("//ul[@id='stats']/li[@class='q_number'][1]/span").to_i
    end

    # Gets the number of questions answered for the current user.  This routine assumes you
    # have already navigated to the My Q&A screen.
    def get_community_impact_answered
      return get_text("//ul[@id='stats']/li[@class='q_number'][2]/span").to_i
    end

    # Gets the number of views on answers for the current user.  This routine assumes you
    # have already navigated to the My Q&A screen.
    def get_community_impact_answer_views
      return get_text("//ul[@id='impact']/li[@class='viewct']/span").to_i
    end

    # Gets the number of thanks received for the current user.  This routine assumes you
    # have already navigated to the My Q&A screen.
    def get_community_impact_thanks
      return get_text("//ul[@id='impact']/li[@class='thanksct']/span").to_i
    end

    # Gets the number of solved votes for the current user.  This routine assumes you
    # have already navigated to the My Q&A screen.
    def get_community_impact_solved_votes
      return get_text("//ul[@id='impact']/li[@class='solvedct']/span").to_i
    end

    # Gets the number of helpful votes for the current user.  This routine assumes you
    # have already navigated to the My Q&A screen.
    def get_community_impact_helpful_votes
      return get_text("//ul[@id='impact']/li[@class='helpfulct']/span").to_i
    end

    # Marks a post as recommended (or not) and sets the subject, category and tags (or location)
    # This method assumes you are already logged in as a user that can recommend a post
    def recommend_post(recommend, subject, expiration, category, tags)
      select_post subject
      click "link=Edit Post"
      select_popup "__postPopUp"
      if recommend
        # TODO: HACK - Uncomment once bug is fixed so you can edit the tags and recommend the post all at once (FBI001918)
        #click "recommend_post"
        select("recommended_post_expiration_date", nil, expiration)
        select("category_id", nil, category) if category != nil
        type("tags", tags) if tags != nil
        # TODO: HACK - Once the bug is fixed so you can edit the tags and recommend the
        # post at the same time, delete these next three statements and uncomment the one above (FBI001918)
        click_and_wait "//div[@onclick='document.edit_post_form.submit();']"
        click_and_wait "link=Edit Post"
        click "recommend_post"
      else
        click "recommend_post" if (@selenium.is_checked("recommend_post"))
      end
      click_and_wait "//div[@onclick='document.edit_post_form.submit();']"
      click "link=Close"
      select_window nil
    end

    # Clears any New_Message or New_Reply alerts for a user
    # Assumes you have already logged in as the desired user and are at the home page
    def clear_all_alerts
      clear_reply_alerts
      clear_message_alerts
    end

    def clear_reply_alerts
      more_pages = true

      # Click the link at the top of the page to initially get to My Q&A
      if is_element_present("//a[@href='/app/myqna?fullpage=qna&page=1&sort=2&type=question']")
        click_and_wait "//a[@href='/app/myqna?fullpage=qna&page=1&sort=2&type=question']"
      end

      while more_pages do
        # Keep clicking the posts until there are no more unread ones
        while is_element_present("//li[@class='new_reply_flag']") do
          click_and_wait "//li[@class='new_reply_flag']"
          click_and_wait "link=< Back"
        end

        break if !is_element_present("//img[@alt='New Reply']")

        # Now see if there is a Next link
        if is_element_present("link=Next>")
          click_and_wait "link=Next>"
        else
          more_pages = false
        end
      end
    end

    def clear_message_alerts
      more_pages = true

      # Click the link at the top of the page to initially get to the inbox
      if is_element_present("//a[@href='/app/myqna?fullpage=qna&page=1&type=inbox']")
        click_and_wait "//a[@href='/app/myqna?fullpage=qna&page=1&type=inbox']"
      end

      while more_pages do
        # Keep clicking the mail messages until there are no more unread ones
        while is_element_present("//a[@class='readthanks unread']") do
          click "//a[@class='readthanks unread']"
          sleep 2
          refresh_page
        end

        break if !is_element_present("//img[@alt='New Message']")

        # Now see if there is a Next link
        if is_element_present("link=Next>")
          click_and_wait "link=Next>"
        else
          more_pages = false
        end
      end
      
    end
  end
end