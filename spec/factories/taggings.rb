# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :tagging do |f|
  f.association :tag
  f.association :knote
end
