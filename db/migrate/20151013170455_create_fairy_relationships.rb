class CreateFairyRelationships < ActiveRecord::Migration
  def change
    create_table :fairy_relationships do |t|
      t.belongs_to :fairy, index: true, foreign_key: true
      t.belongs_to :friend, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
