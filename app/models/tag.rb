class Tag < ActiveRecord::Base
	
  has_many :taggings
  has_many :posts, through: :taggings

  def tag_params
  	params.permit(name)
  end
end
