class RequestsController < ApplicationController
  before_action :user_authenticated!, only: %[index]

  def index
    requests = Request.fresh.all

    render json: RequestSerializer.new(requests).serializable_hash.to_json
  end

  private

  def user_authenticated!
    raise HelpshareErrors::Unauthenticated unless user
  end
end
