class CreateTalents < ActiveRecord::Migration
  def change
    create_table :talents do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
