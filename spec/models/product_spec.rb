require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'Validations' do
    it 'should save when all fields are filled' do
      @category = Category.new(name: 'Gadgets')
      @category.save
      @product = Product.new(
        name: 'Solar Socket',
        description: "It's a powerbank but the sun charges it for you!",
        category_id: @category.id,
        quantity: 10,
        image: "https://www.ippinka.com/wp-content/uploads/2014/01/window-socket-00.jpg",
        price: 75)
      @product.save!

      expect(@product.id).to be_present
    end

    it 'should give an error when there is no category' do 
      @category = Category.new(name: 'Gadgets')
      @category.save
      @product = Product.new(
        name: 'Solar Socket',
        description: "It's a powerbank but the sun charges it for you!",
        quantity: 10,
        image: "https://www.ippinka.com/wp-content/uploads/2014/01/window-socket-00.jpg",
        price: 75)
      @product.save

      expect(@product.errors.full_messages).to eql(["Category can't be blank"])
    end

    it 'should give an error when there is product quantity' do 
      @category = Category.new(name: 'Gadgets')
      @category.save
      @product = Product.new(
        name: 'Solar Socket',
        description: "It's a powerbank but the sun charges it for you!",
        category_id: @category.id,
        image: "https://www.ippinka.com/wp-content/uploads/2014/01/window-socket-00.jpg",
        price: 75)
      @product.save

      expect(@product.errors.full_messages).to eql(["Quantity can't be blank"])
    end


    it 'should give an error when there is no product price' do 
      @category = Category.new(name: 'Gadgets')
      @category.save
      @product = Product.new(
        name: 'Solar Socket',
        description: "It's a powerbank but the sun charges it for you!",
        category_id: @category.id,
        quantity: 10,
        image: "https://www.ippinka.com/wp-content/uploads/2014/01/window-socket-00.jpg")
        @product.save

      expect(@product.errors.full_messages).to eql(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end


    it 'should give an error when there is no product name' do 
      @category = Category.new(name: 'Gadgets')
      @category.save
      @product = Product.new(
        description: "It's a powerbank but the sun charges it for you!",
        category_id: @category.id,
        quantity: 10,
        image: "https://www.ippinka.com/wp-content/uploads/2014/01/window-socket-00.jpg",
        price: 75)
      @product.save

      expect(@product.errors.full_messages).to eql(["Name can't be blank"])
    end
  end
end
