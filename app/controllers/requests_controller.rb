class RequestsController < ApplicationController
  before_action :user_authenticated!, only: %i[index claim]

  def index
    requests = Request.fresh.all

    render json: RequestSerializer.new(requests).serializable_hash.to_json, status: 200
  end

  def claim
    request = Request.find(params[:id])
    Request::Claimer.new(user_id: current_user.id, request: request).call

    render json: RequestSerializer.new(request).serializable_hash.to_json, status: 201
  end

  private

  def user_authenticated!
    authenticate_user
    raise HelpshareErrors::Unauthenticated unless current_user
  end
end
