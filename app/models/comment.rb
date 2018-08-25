class Comment < ApplicationRecord
  acts_as_votable
  after_create_commit { CommentBroadcastJob.perform_later self }
  belongs_to :user
  belongs_to :post
end
