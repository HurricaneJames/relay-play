class Fairy < ActiveRecord::Base
  belongs_to :talent
  belongs_to :region

  has_many :fairy_relationships
  has_many :friends, through: :fairy_relationships
end
