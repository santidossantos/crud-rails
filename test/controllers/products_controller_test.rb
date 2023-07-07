require 'test_helper'

class ProductsControllersTest < ActionDispatch::IntegrationTest

    test 'render a list of products' do
        get products_path
        
        assert_response :success
        assert_select '.product', 2   # .product le pega a la clase html

    end

    test 'render a detailed product page' do
        get product_path(products(:ps3))  # Busca un product del fixture
    
        assert_response :success
        assert_select '.title', 'PS3'    # Comparamos con el titulo renderizado del html
        assert_select '.description', 'Vieja'
        assert_select '.price', '200'
    end

    test 'render a new product form' do
        get new_product_path

        assert_response :success
        assert_select 'form'           # Cheuqeamos que haya una etiqueta form
    end

    test 'allow to create a new product' do
        post products_path, params: {
            product: {
                title: 'Nintendo 64',
                description: '',
                price: 45
            }
        }

        assert_redirected_to products_path
    end

end