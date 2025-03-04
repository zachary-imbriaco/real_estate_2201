require './lib/room'
require './lib/house'

RSpec.describe House do
  it 'exists' do
    house = House.new("$400000", "123 Sugar Lane")

    expect(house).to be_an_instance_of(House)
  end

  it 'checks if above market average' do
    house = House.new("$400000", "123 Sugar Lane")
    house_2 = House.new("$500001", "124 Sugar Lane")

    expect(house.above_market_average?).to eq(false)
    expect(house_2.above_market_average?).to eq(true)
  end

  it 'can add rooms and categorize them' do
    house = House.new("$400000", "123 Sugar Lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')    
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    expect(house.rooms_from_category(:bedroom)).to eq([room_1, room_2])
    expect(house.rooms_from_category(:basement)).to eq([room_4])
  end

  it 'can calculate total area of house' do
    house = House.new("$400000", "123 Sugar Lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')    
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    expect(house.area).to eq(1900)
  end

  it 'can provide price and address in hash format' do
    house = House.new("$400000", "123 Sugar Lane")

    expect(house.details).to eq({"price" => house.price, "address" => house.address})
  end

  it 'calculates price per square foot' do
    house = House.new("$400000", "123 Sugar Lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')    
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    expect(house.price_per_square_foot).to eq(210.53)
  end

  it 'sorts rooms by area or category' do
    house = House.new("$400000", "123 Sugar Lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')    
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)

    expect(house.rooms_sorted_by_area).to eq([room_1, room_2, room_3, room_4])
    expect(house.rooms_by_category).to eq({:bedroom => [room_1, room_2], :living_room => [room_3], :basement => [room_4]})
  end

end
