class Step < ApplicationRecord
    belongs_to :post
    validates :name, presence: true
    default_scope { order(:id) }
end
