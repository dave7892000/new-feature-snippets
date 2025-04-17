class CreateFoldersTables < ActiveRecord::Migration[7.0]
  def change
    create_table :folders_tables do |t|
      t.string :name
      t.string :parent_folder_id
      t.datetime :discarded_at
      t.timestamps
    end
  end
end

class CreateFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :shared_files do |t|
      t.string :url
      t.references :folder
      t.timestamps
    end
  end
end

class AddFileNameToShareFiles < ActiveRecord::Migration[7.0]
  def change
    add_column :shared_files, :file_name, :string
  end
end

class AddDiscardedAtToSharedFiles < ActiveRecord::Migration[7.0]
  def change
    add_column :shared_files, :discarded_at, :datetime
  end
end

