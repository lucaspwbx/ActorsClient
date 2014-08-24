require 'spec_helper'

describe ActorsClient::Connection do

  it 'fetches an Array of Actors' do 
    conn = described_class.new
    
    response = conn.all

    expect(response).to be_an(Array)
    response.each do |item|
      expect(item).to be_an(ActorsClient::Actor)
    end
  end

  it 'fetches an actor' do
    conn = described_class.new
    
    response = conn.get(1)

    expect(response).to be_an(ActorsClient::Actor)
    expect(response.name).not_to be_nil
    expect(response.age).not_to be_nil
  end

  it 'deletes an actor' do
    conn = described_class.new
    
    response = conn.delete(2)

    expect(response).to eq(204)
  end

  it 'updates an actor' do
    conn = described_class.new
    
    response = conn.update(1, name: 'Toxic')

    expect(response).to eq(204)
  end

  it 'creates an actor' do
    conn = described_class.new

    response = conn.create(name: 'Kollegah', age: 80)

    expect(response).to eq(201)
  end
end
