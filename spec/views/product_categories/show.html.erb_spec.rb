require 'rails_helper'

RSpec.describe "product_categories/show", type: :view do
  before(:each) do
    assign(:product_category, ProductCategory.create!(
      name: "Name",
      description: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
