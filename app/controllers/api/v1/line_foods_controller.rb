module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: [:create, :replace]
      def index
        line_foods = LineFood.active
        # 仮注文が空稼働下で場合わけ
        if line_foods.exists?
          line_food_ids = []
          count = 0
          amount = 0
        
          line_foods.each do |line_food|
            line_food_ids << line_food.id # (1) idを参照して配列に追加する
            count += line_food[:count] # (2)countのデータを合算する
            amount += line_food.total_amount # (3)total_amountを合算する
          end
        
          render json: {
            line_food_ids: line_food_ids,
            restaurant: line_foods[0].restaurant,
            count: count,
            amount: amount,
          }, status: :ok
        else
          render json: {}, status: :no_content
        end
      end

      def create
        # 店舗が違う仮注文(LineFood)が複数存在する場合
        if LineFood.active.other_restaurant(@ordered_food.restaurant.id).exists?
          return render json: {
            existing_restaurant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
            new_restaurant: Food.find(params[:food_id]).restaurant.name,
          }, status: :not_acceptable
        end

        set_line_food(@ordered_food)
        
        # @line_foodが保存されたかどうか
        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      def replace
        LineFood.active.other_restaurant(@ordered_food.restaurant.id).each do |line_food|
          line_food.update_attribute(:active, false)
        end

        set_line_food(@ordered_food)
        # @line_foodが保存されたかどうか
        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      private

      def set_food
        @ordered_food = Food.find(params[:food_id])
      end

      def set_line_food(ordered_food)
        # 仮注文が既に存在する時で場合分け
        if ordered_food.line_food.present?
          @line_food = ordered_food.line_food
          @line_food.attributes = {
            count: ordered_food.line_food.count + params[:count],
            active: true
          }
        else
          # order_foodはfoodモデルのインスタンスであり、line_foodモデルはbelong_to :foodを持っているため特殊なbuild_line_foodを使える。
          @line_food = ordered_food.build_line_food(
            count: params[:count],
            restaurant: ordered_food.restaurant,
            active: true
          )
        end
      end
    end
  end
end


