require 'test_helper'

class HamburguesasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hamburguesa = hamburguesas(:one)
  end

  test "should get index" do
    get hamburguesas_url, as: :json
    assert_response :success
  end

  test "should create hamburguesa" do
    assert_difference('Hamburguesa.count') do
      post hamburguesas_url, params: { hamburguesa: { descripcion: @hamburguesa.descripcion, imagen: @hamburguesa.imagen, nombre: @hamburguesa.nombre, precio: @hamburguesa.precio } }, as: :json
    end

    assert_response 201
  end

  test "should show hamburguesa" do
    get hamburguesa_url(@hamburguesa), as: :json
    assert_response :success
  end

  test "should update hamburguesa" do
    patch hamburguesa_url(@hamburguesa), params: { hamburguesa: { descripcion: @hamburguesa.descripcion, imagen: @hamburguesa.imagen, nombre: @hamburguesa.nombre, precio: @hamburguesa.precio } }, as: :json
    assert_response 200
  end

  test "should destroy hamburguesa" do
    assert_difference('Hamburguesa.count', -1) do
      delete hamburguesa_url(@hamburguesa), as: :json
    end

    assert_response 204
  end
end
