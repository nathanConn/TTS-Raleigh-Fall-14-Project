class HomeController < ApplicationController
	def show
		@posts = Post.order("created_at desc").limit(6)
	end
end