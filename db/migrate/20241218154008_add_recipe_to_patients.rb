class AddRecipeToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :recipe, :text
  end
end
