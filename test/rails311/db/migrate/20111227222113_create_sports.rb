class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|

      t.timestamps
    end
  end
end
