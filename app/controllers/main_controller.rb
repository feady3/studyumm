class MainController < ApplicationController
  before_action :session_confirm

  def session_confirm
    if !session['uniqid']
      redirect_to("/sessions/login")
    end
  end

  def home
  end
  def search_page
    @tab = params[:tab]
    if !@tab or (@tab != 'users' and @tab != 'communities')
      redirect_to('/search/users')
    end
    @communities = Group.all
    i = 0
    @group_path = []
    @communities.each do |community|
      @group_path[i] = self.get_group_path(community.uniqid)
      i += 1
    end
    @users = User.all
    j = 0
    @user_path = []
    @users.each do |community|
      @user_path[j] = self.get_user_path(community.uniqid)
      j += 1
    end
    @result = User.where("user_id LIKE? OR user_name LIKE?","%#{params[:keyword]}%","%#{params[:keyword]}%")
  end
  def search_form
    keyword = params[:keyword]
    redirect_to("/search/users/?keyword=#{keyword}",allow_other_host: true)
  end
  def get_group_path(uniqid)
    in_which = Group.find_by(uniqid:uniqid).in_which
    i = 0
    path = [];
    while in_which do
      path[i] = in_which
      in_which = Group.find_by(uniqid:in_which).in_which
      i += 1;
    end
    return path;
  end

  def get_user_path(uniqid)
    i = 0
    path = []
    Grouplog.where(user_uniqid:uniqid,tip:true).reverse_each do |grouplog|
      path[i] = []
      path[i][0] = grouplog.group_uniqid
      j = 1
      while Group.find_by(uniqid:path[i][j-1]).in_which do
        path[i][j] = Group.find_by(uniqid:path[i][j-1]).in_which
        j += 1
      end
      i += 1
    end
    return path;
  end
end
