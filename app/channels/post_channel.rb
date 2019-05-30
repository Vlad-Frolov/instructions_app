class PostChannel < ApplicationCable::Channel
  def subscribed
    stream_from channel
  end

  def speak(data)
    binding.pry
    Comment.create! text: data['comment'], user_id: data['user'], post_id: data['post'], img_url: data['img_url']
  end

  private

  def channel
    "Post_Channel_#{params[:id]}"
  end
end
