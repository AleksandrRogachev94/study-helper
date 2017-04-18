class AddAttachmentDoc2ToLessons < ActiveRecord::Migration
  def self.up
    change_table :lessons do |t|
      t.attachment :doc2
    end
  end

  def self.down
    remove_attachment :lessons, :doc2
  end
end
