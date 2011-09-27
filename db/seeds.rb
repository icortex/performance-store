# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Variable.create(:key => 'IVA (%)', :value => '16')
Variable.create(:key => 'Dolar', :value => '1800')
Variable.create(:key => 'Utilidad (%)', :value => '20')
Variable.create(:key => 'Impuestos (%)', :value => '30')
Variable.create(:key => 'Reserva (%)', :value => '10')

Headquarter.create(:name => 'Sede')

User.create(:username=>'waaa', :email=>'admin@performance.com',
            :type=>'SuperAdmin',:password=>'admin123', :validated=>'1', :headquarter_id => 1)

Size.create(:size=>'S')
Size.create(:size=>'M')
Size.create(:size=>'L')

Color.create(:color=>'Blanco',:rgb=>'ffffff')
Color.create(:color=>'Negro',:rgb=>'000000')
Color.create(:color=>'Rojo',:rgb=>'ff0000')
Color.create(:color=>'Verde',:rgb=>'00ff00')
Color.create(:color=>'Azul',:rgb=>'0000ff')
Color.create(:color=>'Amarillo',:rgb=>'ffff00')
Color.create(:color=>'Naranja',:rgb=>'ff8000')
Color.create(:color=>'Violeta',:rgb=>'ff0080')

Brand.create(:brand=>'Adidas')
Brand.create(:brand=>'Nike')

ClothType.create(:cloth_type=>'Camiseta')

ExpenseType.create(:name => 'operacional')
ExpenseType.create(:name => 'ventas')
ExpenseType.create(:name => 'otro')
