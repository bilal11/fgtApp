class Post < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  has_many :comments
  has_many :likes
  self.inheritance_column = nil


  def get_my_posts_from_facebook
    require 'net/http'
    client = HTTPClient.new
    #user = FbGraph::User.me(access_token)
    #user = FbGraph::User.fetch('matake')

    facebook_id = params[:facebook_id]
    #facebook_id = '100000026248887'
    user = User.find_by_facebook_id(facebook_id)
    if user
      #access_token = user.fb_access_token
      access_token = 'AAAAAAITEghMBAEKj1M8AruicnSZCKhWIK8kj603FXcny8elLIZBePzMgL3a3Ab21NgtvK61PD0HBrfYnZCxRtX16q6UWbxWo3GGCs1sG4Yz94QxibRF'

      @result = client.get_content('https://graph.facebook.com/me/feed?access_token='+access_token)
      @jsonRes = (JSON.parse(@result))["data"]
      @jsonRes.each do |feed|
        feed_id = feed["id"]
        post = Post.find_by_fb_post_id(feed_id)
        if not post
          post = Post.new
          post.user_id=user.id
          post.post_from = "feed"
          post.fb_post_id=feed["id"]
          post.poster_fb_id=feed["from"]["id"]
          post.poster_name=feed["from"]["name"]
          post.type=feed["type"]
          post.status_type=feed["status_type"]
          post.post_time=feed["created_time"]
          if feed["comments"]
            post.total_comments=feed["comments"]["count"].to_i
          end
          if feed["likes"]
            post.total_likes=feed["likes"]["count"].to_i
          end
          if feed["message"]
            post.text=feed["message"]
          end
          if feed["story"]
            post.story=feed["story"]
          end
          if feed["name"]
            post.post_name=feed["name"]
          end
          if feed["picture"]
            post.picture_url=feed["picture"]
          end
          if feed["link"]
            post.shared_pic_link=feed["link"]
          end
          if post.save
            if feed["comments"]
              if feed["comments"]["data"]
                post_comments = feed["comments"]["data"]
                post_comments.each do |post_comment|
                  post_comment_id = post_comment["id"]
                  comment = Comment.find_by_comment_fb_id(post_comment_id)
                  if not comment
                    comment = Comment.new
                    comment.post_id=post.id
                    comment.comment_fb_id=post_comment["id"]
                    comment.text = post_comment["message"]
                    comment.commenter_fb_id=post_comment["from"]["id"]
                    comment.commenter_name=post_comment["from"]["name"]
                    comment.comment_time=post_comment["created_time"]
                    if post_comment["likes"]
                      comment.total_likes=post_comment["likes"].to_i
                    end
                    comment.save
                  end
                end
              else
                if feed["comments"]["count"].to_i>0
                  comments_url = 'https://graph.facebook.com/'+feed["id"].to_s+'/comments?limit='+feed["comments"]["count"].to_s+'&access_token='+access_token
                  comments_result = client.get_content(comments_url)
                  jsonComments = (JSON.parse(comments_result))["data"]
                  jsonComments.each do |post_comment|
                    post_comment_id = post_comment["id"]
                    comment = Comment.find_by_comment_fb_id(post_comment_id)
                    if not comment
                      comment = Comment.new
                      comment.post_id=post.id
                      comment.comment_fb_id=post_comment["id"]
                      comment.text = post_comment["message"]
                      comment.commenter_fb_id=post_comment["from"]["id"]
                      comment.commenter_name=post_comment["from"]["name"]
                      comment.comment_time=post_comment["created_time"]
                      comment.total_likes=post_comment["like_count"].to_i
                      comment.save
                    end
                  end
                end
              end
            end
            if feed["likes"]
              if feed["likes"]["data"]
                post_likes = feed["likes"]["data"]
                post_likes.each do |post_like|
                  #for k in 0..(post_likes.count-1)
                  #  post_like = post_likes[k]
                  post_like_id = post_like["id"]
                  like = Like.find_by_liker_fb_id(post_like_id)
                  if not like
                    like=Like.new
                    like.post_id=post.id
                    like.liker_fb_id=post_like["id"]
                    like.liker_name=post_like["name"]
                    like.save
                  end
                end
              else
                if feed["likes"]["count"].to_i>0
                  likes_url = "https://graph.facebook.com/"+feed["id"]+"/likes?limit="+feed["likes"]["count"].to_s+"&access_token="+access_token
                  likes_result = client.get_content(likes_url)
                  jsonLikes = (JSON.parse(likes_result))["data"]
                  jsonLikes.each do |post_like|
                    post_like_id = post_like["id"]
                    like = Like.find_by_liker_fb_id(post_like_id)
                    if not like
                      like=Like.new
                      like.post_id=post.id
                      like.liker_fb_id=post_like["id"]
                      like.liker_name=post_like["name"]
                      like.save
                    end
                  end
                end
              end
            end
          end
        end
      end
      #respond_to do |format|
      #  #format.html
      #  res = "posts saved Successfully"
      #  format.json { render :json => res }
      #end
    #else
    #  respond_to do |format|
    #    #format.html
    #    res = "user not found"
    #    format.json { render :json => res }
    #  end
    end
  end

  def get_all_posts_from_facebook
    require 'net/http'
    client = HTTPClient.new
    #user = FbGraph::User.me(access_token)
    #user = FbGraph::User.fetch('matake')

    facebook_id = params[:facebook_id]
    #facebook_id = '100000026248887'
    user = User.find_by_facebook_id(facebook_id)
    if user
      #access_token = user.fb_access_token
      access_token = 'AAAAAAITEghMBAEKj1M8AruicnSZCKhWIK8kj603FXcny8elLIZBePzMgL3a3Ab21NgtvK61PD0HBrfYnZCxRtX16q6UWbxWo3GGCs1sG4Yz94QxibRF'

      @result = client.get_content('https://graph.facebook.com/me/home?access_token='+access_token)
      @jsonRes = (JSON.parse(@result))["data"]
      @jsonRes.each do |feed|
        feed_id = feed["id"]
        post = Post.find_by_fb_post_id(feed_id)
        if not post
          post = Post.new
          post.user_id=user.id
          post.post_from = "feed"
          post.fb_post_id=feed["id"]
          post.poster_fb_id=feed["from"]["id"]
          post.poster_name=feed["from"]["name"]
          post.type=feed["type"]
          post.status_type=feed["status_type"]
          post.post_time=feed["created_time"]
          if feed["comments"]
            post.total_comments=feed["comments"]["count"].to_i
          end
          if feed["likes"]
            post.total_likes=feed["likes"]["count"].to_i
          end
          if feed["message"]
            post.text=feed["message"]
          end
          if feed["story"]
            post.story=feed["story"]
          end
          if feed["name"]
            post.post_name=feed["name"]
          end
          if feed["picture"]
            post.picture_url=feed["picture"]
          end
          if feed["link"]
            post.shared_pic_link=feed["link"]
          end
          if post.save
            if feed["comments"]
              if feed["comments"]["data"]
                post_comments = feed["comments"]["data"]
                post_comments.each do |post_comment|
                  post_comment_id = post_comment["id"]
                  comment = Comment.find_by_comment_fb_id(post_comment_id)
                  if not comment
                    comment = Comment.new
                    comment.post_id=post.id
                    comment.comment_fb_id=post_comment["id"]
                    comment.text = post_comment["message"]
                    comment.commenter_fb_id=post_comment["from"]["id"]
                    comment.commenter_name=post_comment["from"]["name"]
                    comment.comment_time=post_comment["created_time"]
                    if post_comment["likes"]
                      comment.total_likes=post_comment["likes"].to_i
                    end
                    comment.save
                  end
                end
              else
                if feed["comments"]["count"].to_i>0
                  comments_url = 'https://graph.facebook.com/'+feed["id"].to_s+'/comments?limit='+feed["comments"]["count"].to_s+'&access_token='+access_token
                  comments_result = client.get_content(comments_url)
                  jsonComments = (JSON.parse(comments_result))["data"]
                  jsonComments.each do |post_comment|
                    post_comment_id = post_comment["id"]
                    comment = Comment.find_by_comment_fb_id(post_comment_id)
                    if not comment
                      comment = Comment.new
                      comment.post_id=post.id
                      comment.comment_fb_id=post_comment["id"]
                      comment.text = post_comment["message"]
                      comment.commenter_fb_id=post_comment["from"]["id"]
                      comment.commenter_name=post_comment["from"]["name"]
                      comment.comment_time=post_comment["created_time"]
                      comment.total_likes=post_comment["like_count"].to_i
                      comment.save
                    end
                  end
                end
              end
            end
            if feed["likes"]
              if feed["likes"]["data"]
                post_likes = feed["likes"]["data"]
                post_likes.each do |post_like|
                  #for k in 0..(post_likes.count-1)
                  #  post_like = post_likes[k]
                  post_like_id = post_like["id"]
                  like = Like.find_by_liker_fb_id(post_like_id)
                  if not like
                    like=Like.new
                    like.post_id=post.id
                    like.liker_fb_id=post_like["id"]
                    like.liker_name=post_like["name"]
                    like.save
                  end
                end
              else
                if feed["likes"]["count"].to_i>0
                  likes_url = "https://graph.facebook.com/"+feed["id"]+"/likes?limit="+feed["likes"]["count"].to_s+"&access_token="+access_token
                  likes_result = client.get_content(likes_url)
                  jsonLikes = (JSON.parse(likes_result))["data"]
                  jsonLikes.each do |post_like|
                    post_like_id = post_like["id"]
                    like = Like.find_by_liker_fb_id(post_like_id)
                    if not like
                      like=Like.new
                      like.post_id=post.id
                      like.liker_fb_id=post_like["id"]
                      like.liker_name=post_like["name"]
                      like.save
                    end
                  end
                end
              end
            end
          end
        end
      end
      #respond_to do |format|
      #  #format.html
      #  res = "posts saved Successfully"
      #  format.json { render :json => res }
      #end
    #else
    #  respond_to do |format|
    #    #format.html
    #    res = "user not found"
    #    format.json { render :json => res }
    #  end
    end
  end

end
