class CreateChips < ActiveRecord::Migration
  def change
    create_table :chips do |t|

      t.timestamps
    end
  end
end
