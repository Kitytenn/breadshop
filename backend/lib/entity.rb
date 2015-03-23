class Entity
  attr_accessor :id, :data

  def self.attr_accessor(*vars)
    @class_attributes ||= [:id, :data]
    @class_attributes.concat vars
    super(*vars)
  end

  def self.class_attributes
    @class_attributes.uniq
  end

  def initialize(data = {})
    @data = data
    data.each do |name, value|
      if self.class.class_attributes.include? name.to_sym
        send("#{name}=", value)
      end
    end
  end
end
