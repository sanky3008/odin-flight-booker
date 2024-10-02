class ChangeDatetimeToDate < ActiveRecord::Migration[7.2]
  def change
    change_column :flights, :date, :date
  end
end
