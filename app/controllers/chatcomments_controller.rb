class ChatcommentsController < ApplicationController
  def index
    @chatcomments = Chatcomment.where('id > ?', params[:after_id].to_i).order('created_at DESC')
  end

  def new
    @chatcomment = Chatcomment.new
    @chatcomments = Chatcomment.order('created_at DESC')
  end

  def create
    respond_to do |format|
      if current_user
        @chatcomment = current_user.chatcomments.build(chatcomment_params)
        if @chatcomment.save
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

  def chatcomment_params
    params.require(:chatcomment).permit(:body)
  end


end








