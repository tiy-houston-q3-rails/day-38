class PagesController < ApplicationController

  before_action :authenticate_user!, except: [:public]

  def public
  end

  def private
  end
end
