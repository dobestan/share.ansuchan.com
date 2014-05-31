require 'spec_helper'

describe Link do
  before do
    @link = Link.new( original: "http://blog.ansuchan.com",
                      shorten: "blog",
                      message: "@dobestan's blog" )
  end

  subject { @link }

  it { should respond_to :original }
  it { should respond_to :shorten }
  it { should respond_to :message }
  it { should respond_to :public }

  # Original
  describe "when Original" do
    describe "is not present" do
      before { @link.original = "" }
      it { should_not be_valid }
    end

    describe "is not unique" do
      before {
        link_with_same_original = @link.dup
        link_with_same_original.save
      }
      it { should_not be_valid }
    end
  end

  # Shorten
  describe "when Shorten" do
    describe "is not present" do
      before { @link.shorten = "" }
      it { should_not be_valid }
    end

    describe "is not unique" do
      before do
        link_with_same_shorten = @link.dup
        link_with_same_shorten.save
      end
      it { should_not be_valid }
    end

    describe "is shorter than 4 characters" do
      before { @link.shorten = "a" * 3 }
      it { should_not be_valid }
    end
  end

  # Public
  describe "when Public" do
    describe "is not presence" do
      before { @link.save }
      its(:public) { should be true }
    end
  end

end
