class PostController < ApplicationController
  before_action :session_confirm
  def session_confirm
    if !session['uniqid']
      redirect_to("/sessions/login")
    end
  end
  def share_form
    @path_list = self.get_user_path(session['uniqid'])
  end
  def share
    user_uniqid = session['uniqid']
    exam_name = params[:exam_name]
    math1 = params[:point]['math1']
    math2 = params[:point]['math2']
    en1 = params[:point]['en1']
    en2 = params[:point]['en2']
    ja1 = params[:point]['ja1']
    ja2 = params[:point]['ja2']
    sci1 = params[:point]['sci1']
    sci2 = params[:point]['sci2']
    soc1 = params[:point]['soc1']
    soc2 = params[:point]['soc2']
    total = math1.to_i + math2.to_i + en1.to_i + en2.to_i + ja1.to_i + ja2.to_i + sci1.to_i + sci2.to_i + soc1.to_i + soc2.to_i
    comments = params[:comments]
    if params[:publish_range] == "only_friends"
      only_friends = true
    elsif params[:published_range] == "non_published"
      only_friends = false
    end
    if math1 !="" or math2 !="" or en1 !="" or en2 !="" or ja1 !="" or ja2 !="" or sci1 !="" or sci2 !="" or soc1 !="" or soc2 !=""
      if Post.find_by(user_uniqid:session['uniqid'],exam_name:exam_name)
        post = Post.find_by(user_uniqid:session['uniqid'],exam_name:exam_name)
        post.math1 = math1
        post.math2 = math2
        post.en1 = en1
        post.en2 = en2
        post.ja1 = ja1
        post.ja2 = ja2
        post.sci1 = sci1
        post.sci2 = sci2
        post.soc1 = soc1
        post.soc2 = soc2
        post.total = total
        post.comments = comments
      else
        post = Post.new(user_uniqid:user_uniqid,exam_name:exam_name,comments:comments,only_friends:only_friends,
          math1:math1,math2:math2,en1:en1,en2:en2,ja1:ja1,ja2:ja2,sci1:sci1,sci2:sci2,soc1:soc1,soc2:soc2,total:total)
      end
      post.save
      redirect_to("/home")
    end
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
