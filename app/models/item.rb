class Item < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  
  validates :price, presence: true, numericality: true
  
  mount_uploader :image, ImageUploader
end
