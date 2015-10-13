# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FAIRIES = [
  {name: 'Fawn',        talent: 'Animal', region: 'Summer' },
  {name: 'Iridessa',    talent: 'Light',  region: 'Summer' },
  {name: 'Periwinkle',  talent: 'Frost',  region: 'Winter' },
  {name: 'Rosetta',     talent: 'Garden', region: 'Summer' },
  {name: 'Silvermist',  talent: 'Water',  region: 'Summer' },
  {name: 'Tinker Bell', talent: 'Tinker', region: ''       },
  {name: 'Vidia',       talent: 'Wind',   region: 'Fall'   },
  {name: 'Zarina',      talent: 'Dust',   region: ''       },
]

TALENTS = FAIRIES.collect { |fairy| fairy[:talent] }.uniq
TALENTS.each do |talent|
  Talent.create(name: talent)
end

REGIONS = FAIRIES.collect { |fairy| fairy[:region] }.uniq
REGIONS.each do |region|
  Region.create(name: region)
end

FAIRIES.each do |fairy|
  Fairy.create(
    name: fairy[:name],
    talent: Talent.where(name: fairy[:talent]).first,
    region: Region.where(name: fairy[:region]).first
  )
end

RELATIONSHIPS = [
  { fairy: FAIRIES[0][:name], friend: FAIRIES[1][:name] },
  { fairy: FAIRIES[0][:name], friend: FAIRIES[2][:name] },
  { fairy: FAIRIES[0][:name], friend: FAIRIES[3][:name] },
  { fairy: FAIRIES[0][:name], friend: FAIRIES[4][:name] },
  { fairy: FAIRIES[1][:name], friend: FAIRIES[5][:name] },
  { fairy: FAIRIES[2][:name], friend: FAIRIES[5][:name] },
  { fairy: FAIRIES[3][:name], friend: FAIRIES[5][:name] },
]
RELATIONSHIPS.each do |relationship|
  FairyRelationship.create(
    fairy:  Fairy.where(name: relationship[:fairy]).first,
    friend: Fairy.where(name: relationship[:friend]).first
  )
  FairyRelationship.create(
    friend: Fairy.where(name: relationship[:fairy]).first,
    fairy:  Fairy.where(name: relationship[:friend]).first
  )
end