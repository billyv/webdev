class TodoUser < ActiveRecord::Base
  has_many :todo_items
  validates :name, uniqueness:true
end
