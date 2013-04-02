class ObjectCreator

  def initialize(hash)
    @hash = hash
  end

  def create
    obj = Object.new
    ObjectCreator::create_object_from_hash obj, hash
    obj
  end

  private
  attr_reader :hash

  class << self
    def create_object_from_hash(obj, hash)
      hash.each do |variable_name, value|
        if value.is_a? Array
          array = Array.new
          create_object_form_array array, value
          set_variable_and_attr_reader obj, variable_name, array
        elsif value.is_a? Hash
          o = Object.new
          create_object_from_hash o, value
          set_variable_and_attr_reader obj, variable_name, o
        else
          set_variable_and_attr_reader obj, variable_name, value
        end
      end
    end

    def create_object_form_array(obj, array)
      array.each do |value|
        if value.is_a? Hash
          o = Object.new
          create_object_from_hash o, value
          obj.push o
        else
          obj.push value
        end
      end
    end

    def set_variable_and_attr_reader obj, variable_name, value
      obj.instance_variable_set "@#{variable_name}", value
      obj.define_singleton_method(variable_name) do
        value
      end
    end
  end

end

