class SubscribedGroup < ActiveRecord::Base
  attr_accessible :group_id, :moderator, :owner, :user_id
end
