class AdminController < ApplicationController
	before_action :authenticate_admin!
  def home
  end

  def index
    @grid = AdminsGrid.new(params[:admins_grid]) do |scope|
      scope.page(params[:page])
    end
  end

end
