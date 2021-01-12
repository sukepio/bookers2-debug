class Room < ApplicationRecord
  
  has_many :chats, dependent: :des
  has_many :user_rooms, dependent: :destroy
end
