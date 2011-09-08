class Product < ActiveRecord::Base

  belongs_to :brand
  belongs_to :cloth_type
  belongs_to :size
  belongs_to :color
  has_many :stocks, :dependent => :destroy

  has_many :sale_products
  has_many :sales, :through => :sale_products

  has_many :lot_products
  has_many :lots, :through => :lot_products

  has_attached_file :image, :styles => {:medium => "250x250>", :thumb => "60x60>"}

  validates_uniqueness_of :brand_id, :scope => [:reference, :size_id, :color_id],
                          :message => 'El articulo ya existe.'

  validates_presence_of :reference, :message => 'Por favor, ingrese la referencia del articulo.'
end
# == Schema Information
#
# Table name: products
#
#  id                 :integer(4)      not null, primary key
#  brand_id           :integer(4)
#  cloth_type_id      :integer(4)
#  reference          :string(255)
#  model              :string(255)
#  barcode            :string(255)
#  gender             :string(255)
#  size_id            :integer(4)
#  color_id           :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#

