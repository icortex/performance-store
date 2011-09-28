class Carrier < ActiveRecord::Base
  validates_presence_of :company, :message => 'Ingrese el nombre de la empresa.'
end
