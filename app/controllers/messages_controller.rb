class MessagesController < ApplicationController
  before_action :require_logged_in!
  
  def index
    @messages = {
      recieved_messages: Message.all.where(reciever_id: current_user.id, secret: false), 
      sent_messages: Message.all.where(sender_id: current_user.id),
      secret_messages: Message.all.where(reciever_id: current_user.id, secret: true)
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
    
    @message.reciever_id = 0 
    @message.save!
   
    kill(@message)
  end
  
  def destroy_sent
    @message = Message.find(params[:id])
    
    @message.sender_id = 0 
    @message.save!
   
    kill(@message)
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
  
  def kill(message)
    if message.sender_id == 0 && @message.reciever_id == 0
      message.destroy!
    end
    head :ok
  end
     
  def message_params
    params.require(:message).permit(:sender_id, :title, :body, :secret)
  end
end

