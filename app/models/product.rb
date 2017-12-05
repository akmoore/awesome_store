class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :avatar, styles: {medium: '300x300#', thumb: '100x100#'} #=> center and crop into a square
  # has_attached_file :avatar, styles: {medium: '300x300>', thumb: '100x100>'} #=> keep deminsions

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_presence_of :name, :price, :quantity, :brand, :category
  validates :name, length: {minimum: 3}
  validates_numericality_of :price, greater_than_or_equal_to: 0.01
  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  def self.search_by_name_or_description(string, page)
    where("name LIKE LOWER(?) OR description LIKE LOWER(?)", "%#{string.downcase}%", "%#{string.downcase}%").paginate(:page => page)
  end

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items Present')
      return false
    end
  end
  
end

# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  name                :string
#  price               :decimal(, )
#  quantity            :integer
#  description         :text
#  brand_id            :integer
#  category_id         :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#
# Indexes
#
#  index_products_on_brand_id     (brand_id)
#  index_products_on_category_id  (category_id)
#
