module Api
  module V1
    class Post < ApplicationRecord
      belongs_to :user
      validates :title, presence: true, uniqueness: true, length: { minimum: 3, maximum: 150 }
      validates :content, presence: true, length: { minimum: 10, maximum: 400 }
      def as_json(options = {})
        super(options.merge(include: :user))
      end
    end
  end
end
