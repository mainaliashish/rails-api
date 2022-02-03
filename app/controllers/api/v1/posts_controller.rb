module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user!, except: %i[index]
      before_action :set_api_v1_post, only: %i[show update destroy]

      def index
        @api_v1_posts = Api::V1::Post.all

        render json: @api_v1_posts
      end

      def show
        render json: @api_v1_post
      end

      def create
        @api_v1_post = Api::V1::Post.new(api_v1_post_params)
        if @api_v1_post.save
          render json: @api_v1_post, status: :created, location: @api_v1_post
        else
          render json: @api_v1_post.errors, status: :unprocessable_entity
        end
      end

      def update
        if @api_v1_post.update(api_v1_post_params)
          render json: @api_v1_post
        else
          render json: @api_v1_post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @api_v1_post.destroy
      end

      private

      def set_api_v1_post
        @api_v1_post = Api::V1::Post.find_by_id(params[:id])
      end

      def api_v1_post_params
        params.require(:api_v1_post).permit(:title, :content).merge(user_id: current_user.id)
      end
    end
  end
end
