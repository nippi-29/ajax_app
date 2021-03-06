class ApplicationController < ActionController::Base
  class MyLogger < Logger
    include LoggerSilence
    include ActiveSupport::LoggerThreadSafeLevel
  end
  before_action :basic_auth
  before_action :mylogger_test

  private

  def mylogger_test
    mylogger = MyLogger.new(STDOUT)
    mylogger.silence do
      mylogger.debug("controller = #{controller_name}")
      mylogger.info("action = #{action_name}")
      mylogger.error("controler#action = #{controller_name}##{action_name}")
    end
  end


  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
