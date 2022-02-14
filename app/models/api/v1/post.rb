module Api
  module V1
    class Post < ApplicationRecord
      belongs_to :user, optional: true
      validates :title, presence: true, length: { minimum: 3, maximum: 100 }
      validates :title, uniqueness: true
      validates :content, presence: true, length: { minimum: 10, maximum: 400 }
      def as_json(options = {})
        super(options.merge(include: :user))
      end
    end
  end
end
