require 'rails_helper'

RSpec.describe "product_categories/edit", type: :view do
  let(:product_category) {
    ProductCategory.create!(
      name: "MyString",
      description: "MyText"
    )
  }

  before(:each) do
    assign(:product_category, product_category)
  end

  it "renders the edit product_category form" do
    render

    assert_select "form[action=?][method=?]", product_category_path(product_category), "post" do

      assert_select "input[name=?]", "product_category[name]"

      assert_select "textarea[name=?]", "product_category[description]"
    end
  end
end
