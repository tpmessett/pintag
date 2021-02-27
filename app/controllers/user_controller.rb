class UserController < ApplicationController
    before_action :set_user

  def boards
    @boards = @user.boards
  end

  def tags
    @tags = @user.tags
  end
  
    private

    def set_user
      @user = current_user
    end
  
end
