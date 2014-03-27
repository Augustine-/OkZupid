class MessagesController < ApplicationController
  before_action :require_logged_in!
  
  def index
    @messages = {
      recieved_messages: Message.all.where(reciever_id: current_user.id, secret: false, visible_to_reciever: true), 
      sent_messages: Message.all.where(sender_id: current_user.id, visible_to_sender: true),
      secret_messages: Message.all.where(reciever_id: current_user.id, secret: true, visible_to_reciever: true)
    }
    
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @messages }
    end
    
    
  end

  def create
    @message = Message.new(message_params)
    @message.reciever_id = recipient
    
    if @message.save
      redirect_to "/mail"
    else
      flash[:errors] = ["Message not sent! Invalid inputs!"]
      redirect_to :back
    end
  end

  def show
    @message = Message.find(params[:id])
    render json: @message
  end

  def destroy_recieved
    @message = Message.find(params[:id])
    
    @message.visible_to_reciever = false 
    @message.save!
    
    render json: @message
  end
  
  def destroy_sent
    @message = Message.find(params[:id])
    
    @message.visible_to_sender = false 
    @message.save!
    
    render json: @message
  end
  
  private
  def recipient
    username = params[:message][:reciever_username].split(' ')[0].capitalize
    user = User.find_by(username: username)
    
    if user.nil?
      flash[:errors] = ["No such user. Message not sent!"]
    else
      User.find_by(username: username).id
    end
  end
  
  # def kill(message)
#     if message.visible_to_sender == false && @message.visible_to_reciever == false
#       message.destroy!
#     end
#     
#     render json: message 
#   end
     
  def message_params
    params.require(:message).permit(:sender_id, :title, :body, :secret)
  end
end

