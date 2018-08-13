class Step < ApplicationRecord
    belongs_to :post
    default_scope { order('position ASC') }

    



end
