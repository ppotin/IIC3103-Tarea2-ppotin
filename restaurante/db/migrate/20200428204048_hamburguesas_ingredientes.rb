class HamburguesasIngredientes < ActiveRecord::Migration[6.0]
  def change
    create_join_table :hamburguesas, :ingredientes
  end
end
