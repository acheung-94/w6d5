require 'action_view'

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper
    CAT_COLORS = %w(black white gray tabby calico tortoiseshell)
    
    validates :birth_date, :name, presence:true
    validates :color, inclusion: {in: CAT_COLORS}
    validates :sex, inclusion: {in: %w(M F)}, presence: true
    validate :birth_date_cannot_be_future

    def birth_date_cannot_be_future
       if birth_date > Date.today
            errors.add(:birth_date, "cannot be in the future")
       end
    end

    def age
       "#{time_ago_in_words(birth_date)} old"
    end
end