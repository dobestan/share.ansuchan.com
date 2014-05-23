require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content 'hello world'" do
      visit '/'
      expect(page).to have_content "hello world"
    end
  end
end
