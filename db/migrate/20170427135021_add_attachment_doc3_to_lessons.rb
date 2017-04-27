class AddAttachmentDoc3ToLessons < ActiveRecord::Migration
  def self.up
    change_table :lessons do |t|
      t.attachment :doc3
    end
  end

  def self.down
    remove_attachment :lessons, :doc3
  end
end
