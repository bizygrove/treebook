class RemoveAttachmentsFromStatus < ActiveRecord::Migration
  def change
  	remove_attachment :documents, :add_attachment
  end
end
