class BookCommentsController < ApplicationController

    def create
        @book = Book.find(params[:book_id])
        @comment = current_user.book_comments.new(book_comment_params)
        @comment.book_id = @book.id
        if @comment.save
  		  redirect_to book_path(@book.id)
  		else
		  @user = @book.user
		  @book_new = Book.new
		  @book_comment = BookComment.new
		  render  'books/show'
		end
    end

    def destroy
        BookComment.find_by(id: params[:id]).destroy
        redirect_back(fallback_location: books_path)
    end
    
    
    private
    
    def book_comment_params
        params.require(:book_comment).permit(:comment)
    end
    
end
