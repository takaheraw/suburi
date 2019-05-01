class Api::V1::UsersController < Api::BaseController
  before_action -> { doorkeeper_authorize! }
  before_action :set_user

  respond_to :json

  def show
    render json: @user, serializer: UserSerializer
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
