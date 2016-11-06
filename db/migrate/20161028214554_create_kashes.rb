class CreateKashes < ActiveRecord::Migration[5.0]
  def change
    create_table :kashes do |t|

      t.timestamps
    end
  end
end
