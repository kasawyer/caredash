class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :description, null: false
      t.belongs_to :doctor, null: false
      t.timestamps
    end
  end
end
