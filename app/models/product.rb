class Product < ApplicationRecord
    has_many :line_items
    has_many :orders, through: :line_items
    before_destroy :ensure_not_referenced_by_any_line_item

    validates :title, uniqueness: true, length: { minimum: 10 }
    validates :title, :description, :image_url, presence: true
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|jpeg|png)\Z}i,
        message: 'must be a URL for GIF, JPG, JPEG or PNG image.'
    }
    validates :price, numericality: { greater_than_or_equal_to: 0.01 }

    private
        def ensure_not_referenced_by_any_line_item
            unless line_items.emoty?
                errors.add(:base, 'Line Items Present')
                throw :abort
            end
        end
end
