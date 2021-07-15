class Order < ApplicationRecord
    has_many :line_foods
  
    validates :total_price, numericality: { greater_than: 0 }

    # 仮注文を取りやめるインスタンスメソッド
    def save_with_update_line_foods!(line_foods)
      ActiveRecord::Base.transaction do
        line_foods.each do |line_food|
          # order_idという外部keyをLineFoodが持っているので、order(_id): self(.id)のように参照先モデル名で属性を更新することができます。
          line_food.update!(active: false, order: self)
        end
        self.save!
      end
      
    end
    
end
  