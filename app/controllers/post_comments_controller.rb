class PostCommentsController < ApplicationController
   
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.book_id = book.id
    if comment.save
      redirect_to post_path(post)
    else
      @post = Post.find(params[:id])
      @user = @post.user
      @users = User.where.not(id: current_user.id)
      render "posts/show"
    end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end

