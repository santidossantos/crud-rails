require "test_helper"

class ProductsControllersTest < ActionDispatch::IntegrationTest
  test "render a list of products" do
    get products_path

    assert_response :success
    assert_select ".product", 2   # .product le pega a la clase html
  end

  test "render a detailed product page" do
    get product_path(products(:ps3))  # Busca un product del fixture, "products" es el .yml del fixture

    assert_response :success
    assert_select ".title", "PS3"    # Comparamos con el titulo renderizado del html
    assert_select ".description", "Vieja"
    assert_select ".price", "200"
  end

  test "render a new product form" do
    get new_product_path

    assert_response :success
    assert_select "form"           # Chequeamos que haya una etiqueta form
  end

  test "allow to create a new product" do
    post products_path, params: {
                          product: {
                            title: "Nintendo 64",
                            description: "Una descripcion",
                            price: 45,
                          },
                        }

    assert_redirected_to products_path
    assert_equal flash[:notice], "Tu producto se ha creado correctamente"
  end

  test "does not allow to create a new product with empty fields" do
    post products_path, params: {
                          product: {
                            title: "",
                            description: "Una descripcion",
                            price: 45,
                          },
                        }

    assert_response :unprocessable_entity
  end

  test "render an edit product form" do
    get edit_product_path(products(:ps3))

    assert_response :success
    assert_select "form"
  end

  test "allow to update a product" do
    patch product_path(products(:ps3).id), params: { # El .id se puede omitir, product es lo que esta en routes as product
                                             product: {
                                               price: 17979,
                                             },
                                           }

    assert_redirected_to products_path
    assert_equal flash[:notice], "Tu producto se ha actualizado correctamente"
  end

  test "does not allow to update a product" do
    patch product_path(products(:ps3)), params: {
                                          product: {
                                            price: nil,
                                          },
                                        }

    assert_response :unprocessable_entity
  end
end
