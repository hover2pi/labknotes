# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :knoting do |f|
  f.association :knotebook
  f.association :knote
end
