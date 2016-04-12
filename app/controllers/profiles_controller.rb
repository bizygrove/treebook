class ProfilesController < ApplicationController
	before_action  :authenticate_user!, only: [:show]
	def show
		@user = User.find_by_profile_name(params[:id])

		if @user
			@statuses = @user.statuses.order('created_at DESC').all
			@gallery = @user.statuses.all.where('document_id IS NOT NULL').order('created_at DESC')
			@king = Status.order("created_at").last
			render action: :show
		else
			render file: 'public/404', status: 404, formats: [:html]
		end
	end
end
