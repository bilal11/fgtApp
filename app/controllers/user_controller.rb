require 'rubygems'
require 'koala'

class UserController < ApplicationController

  def get_posts_koala
    graph = Koala::Facebook::GraphAPI.new('AAAG2mnvP5UUBANMtbl1pEUYZApVKZC8kCkvnvYzKJrZColZBx0BgqJcjiw1JYMXUiRsFEdHG1GuQ82jtZB1B36qRRKy1WLXVbZB9EzZA1emdIwwLELXS5vt')
    #res = graph.get_object("me")
    feed = graph.get_connection('me', 'feed')
    #next_feed = feed.previous_page

    #@feed = Koala::Facebook::API.new(current_user.token)
    #to = Time.now.to_i
    #yest = 1.day.ago.to_i
    #feed = graph.fql_query("SELECT post_id, actor_id, target_id, message, likes FROM stream WHERE source_id = me()")

    #feed = graph.get_connection('me', 'friends')

    respond_to do |format|
      format.json { render :json => feed }
    end
  end

  def register_user
    #userName = params[:userName]
    #facebook_id = params[:facebooko_id]
    #fb_access_token = params[:fb_access_token]

    userName = 'EngineerBilalShabbir'
    facebook_id = '100000026248887'
    fb_access_token = 'AAAAAAITEghMBAAfOCFUevyZBaSyFFTa4UgskcbtXtsx4GX4PFs5KSkR993qQytEqpQ8TwRNSGDAY1TDUTbxUyejC7DPCUEXwRM0f463iVa22NRMks'

    user = User.find_by_facebook_id(facebook_id)
    response = ""
    if user
      response = 'user already exists'
    else
      url = 'http://graph.facebook.com/'+facebook_id+'/picture'
      user = User.new
      user.name=userName
      user.facebook_id=facebook_id
      user.fb_access_token=fb_access_token
      user.fb_display_picture_url=url
      if user.save
        require 'net/http'
        client = HTTPClient.new
        result = client.get_content('https://graph.facebook.com/me/feed?access_token='+fb_access_token)
        jsonRes = (JSON.parse(result))["data"]
        jsonRes.each do |feed|
          post = Post.find_by_fb_post_id(feed["id"])
          if not post
            post = Post.new
            post.user_id=user.id
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
              post_comments = feed["comments"]["data"]
              post_comments.each do |post_comment|
                comment = Comment.find_by_comment_fb_id(post_comment["id"])
                if not comment
                  comment = Comment.new
                  comment.post_id=post.id
                  comment.comment_fb_id=post_comment["id"]
                  comment.text = post_comment["message"]
                  comment.commenter_fb_id=post_comment["from"]["id"]
                  comment.commenter_name=post_comment["from"]["name"]
                  comment.comment_time=post_comment["created_time"]
                  comment.save
                end
              end
              post_likes = feed["likes"]["data"]
              post_likes.each do |post_like|
                like = Like.find_by_liker_fb_id(post_like["id"])
                if not like
                  like=Like.new
                  like.liker_fb_id=post_like["id"]
                  like.liker_name=post_like["name"]
                  like.save
                end
              end
            end
          end
        end
        response = 'user created successfully'
      else
        response = 'user could not created'
      end
    end
    respond_to do |format|
      format.json { render :json => response }
    end
  end

  def get_posts_fb_graph
    require 'net/http'
    client = HTTPClient.new
    #user = FbGraph::User.me(access_token)
    #user = FbGraph::User.fetch('matake')

    #facebook_id = params[:facebook_id]
    #access_token = User.find_by_facebook_id(facebook_id).fb_access_token
    facebook_id = '100000026248887'
    user = User.find_by_facebook_id(facebook_id)
    access_token = user.fb_access_token
    #access_token = 'AAAAAAITEghMBAA84YTWUjjLftcXWezOTegJavnMsiuVuA4wzoBNLip5jrUSTMvmoFPgKtfZA055H66zcV5lhXIDvhweWCckTMA4nwy3lPEOJonjlQ'

    @result = client.get_content('https://graph.facebook.com/me/feed?access_token='+access_token)
    @jsonRes = (JSON.parse(@result))["data"]
    @jsonRes.each do |feed|
      post = Post.find_by_fb_post_id(feed["id"])
      if not post
        post = Post.new
        post.user_id=user.id
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

      end
    end

    respond_to do |format|
      format.html
      #format.json { render :json => @jsonRes }
    end
  end


end
