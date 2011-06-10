class PassthroughController < ApplicationController
  def index
    if current_user.nil?
      redirect_to new_user_session_path
    else
      redirect_to stocks_path
    end
  end
end