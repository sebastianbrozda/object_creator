require "test/unit"
require "./object_creator"


class ObjectCreatorTest < Test::Unit::TestCase

  def create_object(hash)
    creator = ObjectCreator.new hash
    creator.create
  end


  def test_create_object_from_hash
    obj = create_object({field1: 1, field2: 2})

    assert obj.field1 == 1
    assert obj.field2 == 2
  end

  def test_create_object_from_hash_with_hash
    obj = create_object({hash: {key1: 'value1', key2: 'value2'}})

    assert obj.hash.key1 == 'value1'
    assert obj.hash.key2 == 'value2'
  end

  def test_create_object_from_hash_with_inner_hash
    obj = create_object({hash: {inner: {key1: 'value1', key2: 'value2'}}})

    assert obj.hash.inner.key1 == 'value1'
    assert obj.hash.inner.key2 == 'value2'
  end

  def test_create_object_from_hash_with_array
    obj = create_object({value1: 'value1', arr: [1, 2, 3]})

    assert obj.value1 == 'value1'
    assert obj.arr == [1, 2, 3]
  end
end
