class Message < ActiveRecord::Base
  validates :title, :body, :reciever_id, presence: true
end
