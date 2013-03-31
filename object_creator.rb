class ObjectCreator

  def initialize(hash)
    @hash = hash
  end

  def create
    obj = Object.new
    ObjectCreator::create_object_from obj, hash
    obj
  end

  private
  attr_reader :hash

  class << self
    def create_object_from(obj, hash)
      hash.each do |variable_name, value|
        if value.is_a? Hash
          o = Object.new
          create_object_from o, value
          set_variable_and_attr_reader o, variable_name, o
        else
          set_variable_and_attr_reader obj, variable_name, value
        end
      end
    end

    def set_variable_and_attr_reader obj, variable_name, value
      obj.instance_variable_set "@#{variable_name}", value
      obj.class.send(:define_method, variable_name) { value }
    end
  end

end