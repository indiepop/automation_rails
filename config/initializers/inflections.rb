# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end
#   Rails 的命名慣例十分倚賴英文的單複數，
# 例如將單數的類別名稱 Person 轉成複數的表格名稱 people。Inflector
# 就是負責將字串轉換成單複數的類別，雖然它內建了一些基本的轉換規格，
# 但是英文常常有例外的時候，你可以在這個檔案中加上新的規格來做修正。如果你不太確定 Rails 轉換的對不對:
#$ > "Business".singularize  => "Busines" # 轉單數
#$ > "moose".pluralize => "mooses"  # 轉複數