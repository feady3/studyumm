class UserController < ApplicationController
  before_action :set_user, only: [:user_page,:settings,:edit_profile]
  def session_confirm
    if !session['uniqid']
      redirect_to("/sessions/login")
    end
  end
  def set_user
    @myself = User.find_by(uniqid:session['uniqid'])
    @user = User.find_by(user_id:params[:user_id])
  end
  def login
    user = User.find_by(user_id: params[:user_id])
    if user && params[:password] == user.password
      session["uniqid"] = user.uniqid
      redirect_to("/home")
    else
      flash[:msg] = "ユーザー名またはパスワードが違います。"
      redirect_to("/sessions/login")
    end
  end
  def signup
    if User.find_by(email: params[:email])
      flash[:msg] = "このメールアドレスは既に登録されています。"
      redirect_to("/sessions/signup")
    elsif User.find_by(user_id: params[:user_id])
      flash[:msg] = "このユーザー名は既に使用されています。"
      redirect_to("/sessions/signup")
    else
      require 'securerandom'
      uniqid = SecureRandom.uuid
      signup_user = User.new(uniqid:uniqid,email:params[:email],user_id:params[:user_id],user_name:params[:user_name],password:params[:password])
      signup_user.save
      session['uniqid'] = uniqid
      redirect_to("/home")
    end
  end
  def user_page
    if @user.icon
      @icon = @user.icon
    else
      @icon = Image::DEFAULT_ICON
    end
    @path_list = self.get_group_path(@user.uniqid)
  end
  def settings
    if @myself.icon
      @icon = @myself.icon
    else
      @icon = Image::DEFAULT_ICON
    end
  end
  def edit_profile
    if params[:icon]
      require 'securerandom'
      uniqid = SecureRandom.uuid
      image = params[:icon]
      image_extname = File.extname(image).delete_prefix(".")
      @myself.icon = "data:image/#{image_extname};base64,"+Base64.strict_encode64(image.read)
    end
    if User.find_by(user_id: params[:user_id]) and User.find_by(user_id: params[:user_id]).uniqid != @myself.uniqid
      flash[:msg] = "このユーザー名は既に使用されています。"
      redirect_to("/settings/profile")
    else
      @myself.user_id = params[:user_id]
      @myself.user_name = params[:user_name]
      @myself.save
      redirect_to("/@#{@myself.user_id}")
    end
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
end
