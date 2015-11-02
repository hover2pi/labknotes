Factory.define :tag do |f|
  f.sequence(:name) { |n| "Tag #{n}"}
end
