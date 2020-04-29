require 'test_helper'

class IngredientesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ingrediente = ingredientes(:one)
  end

  test "should get index" do
    get ingredientes_url, as: :json
    assert_response :success
  end

  test "should create ingrediente" do
    assert_difference('Ingrediente.count') do
      post ingredientes_url, params: { ingrediente: { descripcion: @ingrediente.descripcion, nombre: @ingrediente.nombre } }, as: :json
    end

    assert_response 201
  end

  test "should show ingrediente" do
    get ingrediente_url(@ingrediente), as: :json
    assert_response :success
  end

  test "should update ingrediente" do
    patch ingrediente_url(@ingrediente), params: { ingrediente: { descripcion: @ingrediente.descripcion, nombre: @ingrediente.nombre } }, as: :json
    assert_response 200
  end

  test "should destroy ingrediente" do
    assert_difference('Ingrediente.count', -1) do
      delete ingrediente_url(@ingrediente), as: :json
    end

    assert_response 204
  end
end
