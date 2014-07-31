class PagesController < ApplicationController

  before_action :authenticate_user!, only: [:private], if: -> {request.format != :json}

  before_action :verify_token, only: :private, if: -> {request.format == :json}

  respond_to :html, :json

  def public
  end

  def private
    @quotes = Quote.all
    respond_with @quotes
  end

  def verify_token
    user = User.find_by api_token: request.headers["auth-token"]
    if user
      return true
    else
      render text: "NOPE", status: 401
    end
  end
end
