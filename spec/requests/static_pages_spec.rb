require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content 'hello world'" do
      visit root_path
      expect(page).to have_content "hello world"
    end

    it "should have the content 'dobestan'" do
      visit root_path
      expect(page).to have_content "dobestan"
    end
  end
end
