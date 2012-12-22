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

  def get_posts_fb_graph
    access_token = 'AAAAAAITEghMBAA84YTWUjjLftcXWezOTegJavnMsiuVuA4wzoBNLip5jrUSTMvmoFPgKtfZA055H66zcV5lhXIDvhweWCckTMA4nwy3lPEOJonjlQ'
    #user = FbGraph::User.me(access_token)
    #user = FbGraph::User.fetch('matake')
    require 'net/http'
    client = HTTPClient.new
    @result = client.get_content('https://graph.facebook.com/me/feed?access_token='+access_token)
    @jsonRes = JSON.parse(@result)

    post = Post.new


    respond_to do |format|
      format.html
      #format.json { render :json => @jsonRes }
    end
  end


end
