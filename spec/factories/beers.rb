FactoryBot.define do
  factory :simple_beer, class: Beer do 
    name        { 'Beer test' }
    tagline     { 'Lorem ipsum dolor sit amet' }
    description { 'consectetur adipisicing elit' }
    abv         { 32.4 }
  end

  factory :real_beer, class: Beer do 
    id          { 1 }
    name        { 'Berliner Weisse With Yuzu - B-Sides' }
    tagline     { 'Japanese Citrus Berliner Weisse.' }
    description { 'Japanese citrus fruit intensifies the sour nature of this German classic.' }
    abv         { 4.2 }
  end
end