class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected
  def after_sign_in_path_for(resource)
    resource.boards.any? ? boards_path : new_board_path
  end
end
