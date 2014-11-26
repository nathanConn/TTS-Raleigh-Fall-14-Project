class Post < ActiveRecord::Base
	has_one :post
  has_many :comments
end

class Post < ActiveRecord::Base
	belongs_to :user
end
