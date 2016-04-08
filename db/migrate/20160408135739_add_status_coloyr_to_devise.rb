class AddStatusColoyrToDevise < ActiveRecord::Migration
  def change
  	add_column :users, :status_colour, :varchar
  end
end
