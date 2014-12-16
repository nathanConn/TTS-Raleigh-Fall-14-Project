class VotesController < ApplicationController
	def upvote
		@comment = Comment.find(params[:id])
		@comment.upvote_by current_user
		redirect_to posts_path
	end

	def downvote
		@comment = Comment.find(params[:id])
		@comment.downvote_by current_user
		redirect_to posts_path
	end
end