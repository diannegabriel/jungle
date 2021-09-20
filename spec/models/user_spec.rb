require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    described_class.new(
      first_name: "Santa", 
      last_name: "Claws", 
      email: "christmas@holiday.com", 
      password: "n0rthpoLe", 
      password_confirmation: "n0rthpoLe"
    )
  }
  describe "Validations" do
    it "should save when all fields are filled'" do
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end
    it "should not be valid without first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("First name can't be blank")
    end
    it "should not be valid without last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Last name can't be blank")
    end
    it "should not be valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Email can't be blank")
    end
    it "should not be valid without pasword" do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Password can't be blank")
    end
    it "should not be valid without pasword confirmation" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Password confirmation can't be blank")
    end
    it "should not be valid when password and password_confirmation don't match" do
      subject.password_confirmation = "notsecret"
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Password confirmation doesn't match Password")
    end
    it "should not be valid when email isn't unique (case insensitive)" do
      same_as_subject = User.create(
        first_name: "Elf", 
        last_name: "Shelf", 
        email: "christmas@holiday.com", 
        password: "secret", 
        password_confirmation: "secret"
      )
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Email has already been taken")
    end
    it "should not be valid when password is less than 6 characters" do
      subject.password = "abcd"
      subject.password_confirmation = "abcd"
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Password is too short (minimum is 6 characters)")
    end
    it "ishould be valid when password is 5 characters or more" do
      subject.password = "123456"
      subject.password_confirmation = "123456"
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end
  end

  describe '.authenticate_with_credentials' do
    it "should authenticate when credentials are valid" do
      subject.save!
      auth = User.authenticate_with_credentials(subject.email, subject.password)
      expect(auth).to eq subject
    end
  end
end