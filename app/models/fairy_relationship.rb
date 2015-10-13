class FairyRelationship < ActiveRecord::Base
  belongs_to :fairy
  belongs_to :friend, class_name: "Fairy"
end
