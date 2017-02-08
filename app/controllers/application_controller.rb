class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  skip_before_filter :verify_authenticity_token
end
