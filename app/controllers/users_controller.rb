class UsersController < ApplicationController
before_action :authenticate_user!, except: [:top]
before_action :corect_user, only: [:update, :edit]
	def top

	end

	def index
		@user = current_user
		@bookn = Book.new
		@userlist = User.all
	end

	def create
	end
	def show
		@user = User.find(params[:id])
		@bookn = Book.new
		@books = @user.books


	end
	def edit
		@user = User.find(params[:id])
		@book =Book.new

	end
	def update
		@user = User.find(params[:id])
	if  @user.update(user_params)
		flash[:notice] = "successfully"
		redirect_to user_path(@user.id)
	else

		render :edit
	end
	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end
	def corect_user
		@user = User.find(params[:id])
		if @user.id != current_user.id
			flash[:error] = "error"
			redirect_to user_path(current_user.id)
		end
	end
end
