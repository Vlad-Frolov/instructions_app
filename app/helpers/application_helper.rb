require 'navigation_helper.rb'

module ApplicationHelper
  include NavigationHelper

  def youtube_video(url)
		begin
			o = OhEmbedr::OhEmbedr.new(:url => url, :maxwidth => 600)
			embed_data = o.gets
			embed_data["html"].html_safe
		rescue OhEmbedr::UnsupportedError => error
			# URL not supported
		end
  end 
end
