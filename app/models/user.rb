class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 15 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
    has_secure_password
    
    has_many :items
    
    
    has_many :following_relationships, class_name:  "Relationship",
                                       foreign_key: "follower_id",
                                       dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
    has_many :follower_relationships, class_name:  "Relationship",
                                      foreign_key: "followed_id",
                                      dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    has_many :likes
    has_many :liked_items, through: :likes, source: :item
    
    def follow(other_user)
        following_relationships.create(followed_id: other_user.id)
    end
    
    def unfollow(other_user)
        following_relationships.find_by(followed_id: other_user.id).destroy
    end
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    def number_followings
        following_relationships.count
    end
    def number_followers
        follower_relationships.count
    end
    
    def feed_items
        Item.where(user_id: following_user_ids + [self.id])
    end
    
    def like(other_item)
        likes.create(item_id: other_item.id)
    end
    def unlike(other_item)
        likes.find_by(item_id: other_item.id).destroy
    end
    def liking?(other_item)
        liked_items.include?(other_item)
    end
end
