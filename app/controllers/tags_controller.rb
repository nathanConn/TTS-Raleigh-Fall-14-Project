class TagsController < ApplicationController
  def tags_param
    params.permit(name)
  end
end
