class Api::V1::RestaurantsController < Api::V1::BaseController
before_action :set_board, only: [ :show ]

  def show
  end

  def set_board
    @board = Board.find(params[:id])
    authorize @board
  end
end
