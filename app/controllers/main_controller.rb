class MainController < ApplicationController
  before_action :set_user
  before_action :session_confirm
  def session_confirm
    if !session['uniqid']
      redirect_to("/sessions/login")
    end
  end
  def set_user
    @myself = User.find_by(uniqid:session['uniqid'])
  end

  def home
    @posts = Post.all.order(:updated_at)
    @posts = @posts.last(10)
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

  def ranking_page
    if cookies[:ranking_group]
      @group = cookies[:ranking_group]
    else
      @group = ""
    end
    if cookies[:ranking_exam_name]
      @exam_name = cookies[:ranking_exam_name]
    else
      @exam_name = ""
    end
    # @exam_name = ""
    @exam_list = Post.where(user_uniqid:session['uniqid'])
    @path_list = self.get_group_path(@myself.uniqid)
    users = Grouplog.where(group_uniqid:@group)
    @users = []
    @post = []
    i = 0
    # @posts = Post.where(user_uniqid:Grouplog.where(group_uniqid:@group)).order(total: "DESC")
    users.each do |user|
      @post[i] = Post.find_by(user_uniqid:user.user_uniqid,exam_name:@exam_name)
      i += 1
    end
    @post = @post.compact
    if @group != "" && @exam_name != ""
      @post = @post.sort_by { |post2| -(post2[:total]) }
    end
  end
  def ranking_ctgr
    cookies.permanent[:ranking_group] = params[:group]
    cookies.permanent[:ranking_exam_name] = params[:exam_name]
    redirect_to("/ranking")
  end
  def get_group_path(uniqid)
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
