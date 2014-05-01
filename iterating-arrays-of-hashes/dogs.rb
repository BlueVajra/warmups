class Dogs
  POOR = (0..5).to_a.sample
  AVERAGE = (6..10).to_a.sample
  EXCELLENT = (11..15).to_a.sample

  def initialize
    joe = {
      :name => {:first => "Joe", :last => "Smith"},
      :owner_quality => EXCELLENT
    }
    sarah = {
      :name => {:first => "Sarah", :last => "Smith"},
      :owner_quality => AVERAGE
    }
    andrew = {
      :name => {:first => "Andrew", :last => "Beter"},
      :owner_quality => AVERAGE
    }

    @dogs = [{:name => "Fido", :size => :large, :owner => joe},
             {:name => "Yapper", :size => :small, :owner => joe},
             {:name => "Bruiser", :size => :large, :owner => joe},
             {:name => "Tank", :size => :huge, :owner => sarah},
             {:name => "Beast", :size => :large, :owner => sarah},
             {:name => "Harleigh", :size => :medium, :owner => andrew},
             {:name => "Trixie", :size => :small, :owner => andrew},]
  end

  # only edit below this line

  def small_dogs
    @dogs.select { |dog| dog[:size] == :small }
  end

  def huge_dog
    huge_dogs.map do |huge_dog|
      huge_dog.select {|k,v| k == :name}
    end
  end

  def huge_dogs
    @dogs.select { |dog| dog[:size] == :huge }
  end

  def large_dogs
    @dogs.select { |dog| dog[:size] == :large }
  end

  def large_dog_names
   large_dogs.map { |dog| dog[:name]}
  end

  def joes_large_dogs
    large_dogs.select { |dog| dog[:owner][:name][:first] == 'Joe'}.map { |dog| dog[:name]}
  end

  def sizes
    @dogs.map {|dog| dog[:size]}.uniq
  end

  def owners
    uniq_owners.map {|owner| owners_full_name(owner)}
  end

  def uniq_owners
    @dogs.map {|dog| dog[:owner]}.uniq
  end

  def owners_full_name(owner)
    owner[:name][:first] + " " + owner[:name][:last]
  end

  def average_owners
    uniq_owners.select{ |owner| owner[:owner_quality] == AVERAGE}.map {|owner| owners_full_name(owner)}
  end
end
