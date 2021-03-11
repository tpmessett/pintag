class Api::V1::BoardsController < Api::V1::BaseController
acts_as_token_authentication_handler_for User
before_action :set_board, only: [ :show ]

  def show
  end

  def set_board
    @board = Board.find(params[:id])
    authorize @board
  end

  def index
    @boards = policy_scope(Board)
    @tags = policy_scope(Tag)
  end
end
