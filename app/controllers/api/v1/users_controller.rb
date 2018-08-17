class Api::V1::UsersController < Api::BaseController
  before_action -> { doorkeeper_authorize! }

  respond_to :json

  def show
    render json: current_user
  end

end
