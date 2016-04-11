class AddDoucmentName < ActiveRecord::Migration
  def change
  	add_attachment :documents, :add_attachment
  end
end
