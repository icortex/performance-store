class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :cloth_type
  belongs_to :size
  belongs_to :color

  has_attached_file :image, :styles => {:medium => "250x250>", :thumb => "60x60>"}
  validates_uniqueness_of :brand_id, :scope => [:reference, :cloth_type_id, :model, :barcode, :gender, :size_id, :color_id], :message => 'El articulo ya existe'
end