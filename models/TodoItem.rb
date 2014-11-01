class TodoItem < ActiveRecord::Base
  belongs_to :todo_user
end
