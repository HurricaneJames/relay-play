class CreateFairies < ActiveRecord::Migration
  def change
    create_table :fairies do |t|
      t.string :name
      t.belongs_to :talent, index: true, foreign_key: true
      t.belongs_to :region, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
