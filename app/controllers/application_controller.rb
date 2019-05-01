class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  unless Rails.env.development?
    rescue_from StandardError,                              with: :render_500
    rescue_from ActionController::InvalidAuthenticityToken, with: :render_422
    rescue_from ActionController::RoutingError,             with: :render_404
    rescue_from ActiveRecord::RecordNotFound,               with: :render_404
    rescue_from ActiveRecord::RecordInvalid,                with: :render_400
    rescue_from Pundit::NotAuthorizedError,                 with: :render_401
  end

  def append_info_to_payload(payload)
    super
    payload[:host]          = request.host
    payload[:ip]            = request.remote_ip
    payload[:referer]       = request.referer
    payload[:user_id]       = current_user.try(:id)
    payload[:req_params]    = request.request_parameters
    ua                      = Woothee.parse(request.user_agent)
    payload[:ua_name]       = ua[:name]
    payload[:ua_category]   = ua[:category].to_s
    payload[:ua_os]         = ua[:os]
    payload[:ua_os_version] = ua[:os_version]
    payload[:ua_version]    = ua[:version]
    payload[:ua_vendor]     = ua[:vendor]
  end

  def raise_not_found
    raise ActionController::RoutingError, "No route matches #{params[:unmatched_route]}"
  end

  protected

  def render_400(e)
    respond_with_error(e, 400)
  end

  def render_401(e)
    respond_with_error(e, 401)
  end

  def render_404(e)
    respond_with_error(e, 404)
  end

  def render_408(e)
    respond_with_error(e, 408)
  end

  def render_422(e)
    respond_with_error(e, 422)
  end

  def render_500(e)
    airbrake_notify(e)
    respond_with_error(e, 500)
  end

  def respond_with_error(_e, code)
    respond_to do |format|
      format.any  { head code }
      format.html do
        render "errors/#{code}", layout: 'error', status: code
      end
    end
  end

  def airbrake_notify(e)
    notice = Airbrake.build_notice(e)
    notice.stash[:rack_request] = request
    Airbrake.notify(notice)
  end
end
