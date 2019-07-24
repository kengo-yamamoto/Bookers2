class BooksController < ApplicationController
	before_action :authenticate_user!, only: [:index, :show, :edit]
	before_action :corect_user, only: [:upsate, :edit]
	def index
		@user = current_user
		@bookn = Book.new
		@books = Book.all
	end

	def new
	end

	def create
		@bookn = Book.new(books_params)
		@bookn.user_id = current_user.id
		@user = current_user
		@books = Book.all
	    if @bookn.save
	        flash[:notice] = "successfully"
			redirect_to book_path(@bookn.id)
		else
			flash[:error] = "error"
			render :index
		end

	end

	def show
		@bookn = Book.new
		@book = Book.find(params[:id])
		@user = @book.user

	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(books_params)
		   flash[:notice] = "successfully"
		   redirect_to book_path(@book.id)
		else
			render :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private

	def books_params
		params.require(:book).permit(:title, :body)
	end
	def corect_user
		@book = Book.find(params[:id])
		if @book.user.id != current_user.id
			flash[:error] = "error"
			redirect_to books_path
		end
	end
end
