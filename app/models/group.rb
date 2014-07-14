class Group < ActiveRecord::Base
  attr_accessible :avatar, :creator_id, :description, :name, :privacy_invite_only, :privacy_members_only_view, :tagline
end
