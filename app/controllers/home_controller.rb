class HomeController < ApplicationController
	def show
		@posts = Post.order("created_at desc")
		@home =  Post.paginate(:page => params[:page], :per_page => 6)
	end
end