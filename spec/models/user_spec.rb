require 'spec_helper'

describe User do
  before do
    @user = User.new( name: "Example User",
                      password: "foobar",
                      password_confirmation: "foobar" )
  end

  subject { @user }

  it { should respond_to :name }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :password_digest }
  it { should respond_to :remember_token }

  # Name
  describe "when Name" do
    describe "is not presence" do
      before { @user.name = "" }
      it { should_not be_valid }
    end

    describe "is shorter than 4" do
      before { @user.name = "a" * 3 }
      it { should_not be_valid }
    end

    describe "is not unique" do
      before do
        user_with_same_name = @user.dup
        user_with_same_name.save
      end

      it { should_not be_valid }
    end

    describe "is not unique with different case" do
      before do
        user_with_same_name_diff_case = @user.dup
        user_with_same_name_diff_case.name = @user.name.upcase
        user_with_same_name_diff_case.save
      end

      it { should_not be_valid }
    end
  end

  # Password
  describe "when Password" do
    describe "is shorter than 6" do
      before do
        @user.password = "a" * 5
        @user.password_confirmation = "a" * 5
      end

      it { should_not be_valid }
    end
  end

  # Admin Permission
  describe "when Admin" do
    describe "is not presence" do
      before { @user.save }
      its(:admin) { should be false }
    end
  end

  # Remember Token
  describe "remember_token" do
    before { @user.save }
    its(:remember_token) { should_not be nil }
  end
end
