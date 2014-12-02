class HomeController < ApplicationController
	def show
		@posts = Post.order("created_at desc").limit(4).offset(1)
	end
end