class Api::BaseController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: 'Record not found' }, status: 404
  end

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: (error.try(:description) || 'Not authorized') } }
  end

  def doorkeeper_forbidden_render_options(*)
    { json: { error: 'This action is outside the authorized scopes' } }
  end

end
