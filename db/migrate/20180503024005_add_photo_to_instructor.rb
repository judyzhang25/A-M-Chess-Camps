class AddPhotoToInstructor < ActiveRecord::Migration[5.1]
  def change
    add_column :instructors, :photo, :string
  end
end
