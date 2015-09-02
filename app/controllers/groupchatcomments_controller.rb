class GroupchatcommentsController < ApplicationController

  def index
    @groupchatcomments = Groupchatcomment.where('id > ?', params[:after_id].to_i).order('created_at DESC')
    @group = Group.find(params[:id])
  end

  def new
    @groupchatcomment = Groupchatcomment.new
    @groupchatcomments = Groupchatcomment.order('created_at DESC')
   

  end

  def create
  	@group = Group.find(params[:id])

    respond_to do |format|

      if current_user
        @group = Group.find(params[:id])
        @groupchatcomment.user_id = current_user.user_id
        @groupchatcomment = @group.groupchatcomments.build(groupchatcomment_params)

        if @groupchatcomment.save
          flash.now[:success] = 'Your comment was successfully posted!'
        else
          flash.now[:error] = 'Your comment cannot be saved.'
        end
        format.html {redirect_to root_url}
        format.js
      else
        format.html {redirect_to root_url}
        format.js {render nothing: true}
      end
    end
  end

  private

  def comment_params
    params.require(:groupchatcomment).permit(:body, :group_id, :user_id)
  end
end
