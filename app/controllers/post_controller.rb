class PostController < ApplicationController
  before_action :session_confirm
  def session_confirm
    if !session['uniqid']
      redirect_to("/sessions/login")
    end
  end
  def share

  end
end
