class CommunitiesController < ApplicationController
  before_action :session_confirm
  before_action :in_group_redirect, only: [:create_page]
  def session_confirm
    if !session['uniqid']
      redirect_to("/sessions/login")
    end
  end
  def in_group_redirect
    @community = Group.find_by(uniqid:params[:group])
    if params[:group]
      if !self.in_group(session['uniqid'],@community.uniqid)
        redirect_to("/community/#{@community.uniqid}")
      end
    end
  end
  def community_page
    @community = Group.find_by(uniqid:params[:uniqid])
    if @community.icon
      @icon = @community.icon
    else
      @icon = Image::DEFAULT_ICON
    end
    @in_group = self.in_group(session['uniqid'],params[:uniqid])
    @join_allow = self.join_allow(session['uniqid'],params[:uniqid])
    @path = self.get_group_path(@community.uniqid)
    @member_number = self.group_member(params[:uniqid]).count
    @tab = params[:tab]
    @included_communities = self.included_communities(params[:uniqid])
  end
  def create_page
    if params[:group]
      @community = Group.find_by(uniqid:params[:group])
      @uniqid = @community.uniqid
      @path = self.get_group_path(@community.uniqid)
    else
      @uniqid = ""
      @path = "/"
    end
  end
  def included_communities(uniqid)
    communities = Group.where(in_which:uniqid)
    return communities
  end
  def join_allow(user_uniqid,group_uniqid)
    if Group.find_by(uniqid:Group.find_by(uniqid:group_uniqid).in_which)
      in_which = Grouplog.find_by(user_uniqid:user_uniqid,group_uniqid:Group.find_by(uniqid:Group.find_by(uniqid:group_uniqid).in_which).uniqid)
    else
      in_which = true
    end
    if in_which
      return true
    else
      return false
    end
  end
  def in_group(user_uniqid,group_uniqid)
    search = Grouplog.find_by(user_uniqid:user_uniqid,group_uniqid:group_uniqid)
    if search
      return true
    else
      return false
    end
  end
  def group_member(group_uniqid)
    search = Grouplog.where(group_uniqid:group_uniqid)
    return search
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
    j = 0
    Grouplog.where(user_uniqid:uniqid).reverse_each do |grouplog|
      in_which = grouplog.group_uniqid
      i = 1
      @user_path = []
      @user_path[j] = []
      @user_path[j][0] = in_which
      while in_which do
        if Group.find_by(uniqid:in_which)
          @user_path[j][i] = in_which
          in_which = Group.find_by(uniqid:in_which).in_which
          i += 1
          j += 1
        else
          in_which = nil
        end
      end
    end
    return @user_path;
  end
  def group_join
    if Group.find_by(uniqid:params[:group]).in_which
      upper_group = Group.find_by(uniqid:Group.find_by(uniqid:params[:group]).in_which)
      upper_group_log = Grouplog.find_by(user_uniqid:session['uniqid'],group_uniqid:upper_group.uniqid)
      upper_group_log.tip = false
      upper_group_log.save
    end
    group_log = Grouplog.new(user_uniqid:session['uniqid'],group_uniqid:params[:group],tip:true)
    group_log.save
    redirect_to("/community/#{params[:group]}")
  end
  def group_getout
    if Grouplog.find_by(user_uniqid:session['uniqid'],group_uniqid:params[:group]).tip == "t"
      group_log = Grouplog.find_by(user_uniqid:session['uniqid'],group_uniqid:params[:group])
      group_log.delete
      if Group.find_by(uniqid:params[:group]).in_which
        # Group.where(in_which:Group.find_by(uniqid:Group.find_by(uniqid:params[:group]).in_which).uniqid)
        same_level_groups = Group.where(in_which:params[:group])
        upper_group = Group.find_by(uniqid:Group.find_by(uniqid:params[:group]).in_which)
        upper_group_log = Grouplog.find_by(user_uniqid:session['uniqid'],group_uniqid:upper_group.uniqid)
        joined_groups = []
        group_list = []
        i = 0
        Grouplog.where(user_uniqid:session['uniqid']).each do |grouplog|
          joined_groups[i] = grouplog.group_uniqid
          i += 1
        end
        same_level_groups.each do |same_level_group|
          group_list[i] = same_level_group.uniqid
          i += 1
        end
        a = joined_groups & group_list
        if a[0]
          upper_group_log.tip = false
          upper_group_log.save
        else
          upper_group_log.tip = true
          upper_group_log.save
        end
      end
      redirect_to("/community/#{params[:group]}")
    end
  end
  def create
    require 'securerandom'
    uniqid = SecureRandom.uuid
    manager = session['uniqid']
    if params[:icon]
      icon_uniqid = SecureRandom.uuid
      image_extname = File.extname(params[:icon])
      image = params[:icon]
      image_data = "data:image/#{image_extname};base64,"+Base64.strict_encode64(image.read)
    end
    if params[:group]
      in_which = params[:group]
      if Group.find_by(uniqid:params[:group]).uniqid
        upper_group = Group.find_by(uniqid:params[:group])
        upper_group_log = Grouplog.find_by(user_uniqid:session['uniqid'],group_uniqid:upper_group.uniqid)
        upper_group_log.tip = false
        upper_group_log.save
      end
    else
      in_which = nil
    end
    new_group = Group.new(uniqid:uniqid,name:params[:name],in_which:in_which,icon:image_data,manager:manager)
    new_group.save
    group_log = Grouplog.new(user_uniqid:session['uniqid'],group_uniqid:uniqid,tip:true)
    group_log.save
    redirect_to("/community/#{uniqid}")
  end
end
