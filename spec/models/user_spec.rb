require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) { build(:user) }

  describe "validations" do
    context "full_name" do
      it "is invalid without a full_name" do
        valid_user.full_name = nil
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:full_name]).to include("can't be blank")
      end
    end

    context "user_name" do
      it "is invalid without a user_name" do
        valid_user.user_name = nil
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:user_name]).to include("can't be blank")
      end

      it "must be unique" do
        create(:user, user_name: 'unique_user')
        valid_user.user_name = 'unique_user'
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:user_name]).to include("has already been taken")
      end

      it "must be between 6 and 20 characters" do
        valid_user.user_name = 'short'
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:user_name]).to include("is too short (minimum is 6 characters)")

        valid_user.user_name = 'a' * 21
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:user_name]).to include("is too long (maximum is 20 characters)")
      end

      it "can only contain lowercase letters, numbers, and underscores" do
        valid_user.user_name = 'Invalid*Name'
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:user_name]).to include("can only contain lowercase letters, numbers, and underscores")
      end
    end

    context "phone_number" do
      it "is invalid without a phone_number" do
        valid_user.phone_number = nil
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:phone_number]).to include("can't be blank")
      end

      it "must be a 10-digit number (if less then 10 digits)" do
        valid_user.phone_number = '12345'
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:phone_number]).to include("must be a 10-digit number")
      end

      it "must be a 10-digit number (if greater than digits)" do
        valid_user.phone_number = '12345678912345'
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:phone_number]).to include("must be a 10-digit number")
      end

      it "must be a 10-digit number (if it contains alphabets)" do
        valid_user.phone_number = '123456789a'
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:phone_number]).to include("must be a 10-digit number")
      end
    end

    context "date_of_birth" do
      it "is invalid without a date_of_birth" do
        valid_user.date_of_birth = nil
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:date_of_birth]).to include("can't be blank")
      end
    end

    context "experience_years" do
      it "is invalid without experience_years" do
        valid_user.experience_years = nil
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:experience_years]).to include("can't be blank")
      end
    end

    context "address" do
      it "is invalid without an address" do
        valid_user.address = nil
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:address]).to include("can't be blank")
      end
    end

    context "district" do
      it "is invalid without a district" do
        valid_user.district = nil
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:district]).to include("can't be blank")
      end
    end

    context "pin_code" do
      it "is invalid without a pin_code" do
        valid_user.pin_code = nil
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:pin_code]).to include("can't be blank")
      end

      it "must be a 6-digit number (if less than 6 digits)" do
        valid_user.pin_code = '123'
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:pin_code]).to include("must be a 6-digit number")
      end

      it "must be a 6-digit number (if greater than 6 digits)" do
        valid_user.pin_code = '1234567'
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:pin_code]).to include("must be a 6-digit number")
      end

      it "must be a 6-digit number (if contains alphabets)" do
        valid_user.pin_code = '12345a'
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:pin_code]).to include("must be a 6-digit number")
      end
    end

    context "email" do
      it "is invalid without an email" do
        valid_user.email = nil
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:email]).to include("can't be blank")
      end

      it "must have a valid email format" do
        valid_user.email = 'invalid-email'
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:email]).to include("is invalid")
      end
    end

    context "must_have_at_least_one_profession" do
      it "is invalid without at least one profession" do
        valid_user.professions.clear
        expect(valid_user).to_not be_valid
        expect(valid_user.errors[:professions]).to include("must have at least one profession")
      end
    end
  end
end
