class Folder < ApplicationRecord
  include Discard::Model
  has_many :shared_files
  validates :name, presence: true
end

class SharedFile < ApplicationRecord
  include Discard::Model
  belongs_to :folder
end