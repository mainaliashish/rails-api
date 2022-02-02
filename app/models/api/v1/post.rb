module Api
  module V1
    class Post < ApplicationRecord
      belongs_to :user

      def as_json(options = {})
        super(options.merge(include: :user))
      end
    end
  end
end
