class Post < ActiveRecord::Base
	has_one :post
  has_many :comments	
end
