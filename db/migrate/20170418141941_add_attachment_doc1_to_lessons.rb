class AddAttachmentDoc1ToLessons < ActiveRecord::Migration
  def self.up
    change_table :lessons do |t|
      t.attachment :doc1
    end
  end

  def self.down
    remove_attachment :lessons, :doc1
  end
end
