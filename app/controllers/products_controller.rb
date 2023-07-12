class ProductsController < ApplicationController
  def index
    @products = Product.all.with_attached_photo # attached -> IMPORTANTE PARA TRAER LOS ATTACHED EN UNA SOLA CONSULTA
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path, notice: t(".updated"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path, notice: t(".destroyed"), status: :see_other
  end

  private

  def product_params # Metodo privado  para reutilizar codigo
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end
end
