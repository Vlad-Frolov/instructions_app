class PostChannel < ApplicationCable::Channel
  #When a user became consumer
  def subscribed
    stream_from channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Comment.create! text: data['comment'], user_id: data['user'], post_id: data['post']
  end

  private
    def channel
      "Post_Channel_#{params[:id]}"
    end
end