class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @photo, notice: "コメントを投稿しました"
    else
      redirect_to @photo, alert: "コメントを送信できませんでした"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      redirect_to @comment.photo, notice: "コメントを削除しました"
    else
      redirect_to @comment.photo, alert: "このコメントを削除する権限がありません"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
