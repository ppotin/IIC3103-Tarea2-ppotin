class HamburguesasController < ApplicationController
  #before_action :set_hamburguesa, only: [:show, :update, :destroy]

  $PATH = 'https://restaurante-ppotin.herokuapp.com/'

  def is_number? string
    true if Float(string) rescue false
  end

  # GET /hamburguesa
  def index
    @hamburguesas = Hamburguesa.all

    @response = []

    @hamburguesas.each do |hamburguesa|
      @entidad = {
        "id" => hamburguesa.id,
        "nombre" => hamburguesa.nombre,
        "precio" => hamburguesa.precio,
        "descripcion" => hamburguesa.descripcion,
        "imagen" => hamburguesa.imagen,
        "ingredientes" => []
      }
      hamburguesa.ingredientes.each do |ingrediente|
        @entidad["ingredientes"] << {"path" => $PATH + "ingrediente/" + ingrediente.id.to_s}
      end
      @response << @entidad
    end

    render json: @response
    
  end

  # GET /hamburguesa/1
  def show
    begin
      @hamburguesa = Hamburguesa.find(params[:id])
      @entidad = {
        "id" => @hamburguesa.id,
        "nombre" => @hamburguesa.nombre,
        "precio" => @hamburguesa.precio,
        "descripcion" => @hamburguesa.descripcion,
        "imagen" => @hamburguesa.imagen,
        "ingredientes" => []
      }
      @hamburguesa.ingredientes.each do |ingrediente|
        @entidad["ingredientes"] << {"path" => $PATH + "ingrediente/" + ingrediente.id.to_s}
      end
      render json: @entidad
    rescue
      @id = params[:id]
      if is_number?(@id)
        render :status => "404", json: {code: 404, description: "harburguesa inexistente"}
      else 
        render :status => "400", json: {code: 400, description: "input invalido"}
      end
    end
  end

  # POST /hamburguesa
  def create
    begin
      @hamburguesa = Hamburguesa.new(hamburguesa_params)
      if @hamburguesa.save
        @entidad = {
        "id" => @hamburguesa.id,
        "nombre" => @hamburguesa.nombre,
        "precio" => @hamburguesa.precio,
        "descripcion" => @hamburguesa.descripcion,
        "imagen" => @hamburguesa.imagen,
        "ingredientes" => []
        }
        @hamburguesa.ingredientes.each do |ingrediente|
          @entidad["ingredientes"] << {"path" => $PATH + "ingrediente/" + ingrediente.id.to_s}
        end
        render :status => "201", json: @entidad
      end
    rescue 
      render :status => "400", json: {code: 400, description: "input invalido"}
    end
  end

  # PATCH/PUT /hamburguesa/1
  def update
    begin
      @hamburguesa = Hamburguesa.find(params[:id])
      if @hamburguesa.update(hamburguesa_params)
        @entidad = {
        "id" => @hamburguesa.id,
        "nombre" => @hamburguesa.nombre,
        "precio" => @hamburguesa.precio,
        "descripcion" => @hamburguesa.descripcion,
        "imagen" => @hamburguesa.imagen,
        "ingredientes" => []
        }
        @hamburguesa.ingredientes.each do |ingrediente|
          @entidad["ingredientes"] << {"path" => $PATH + "ingrediente/" + ingrediente.id.to_s}
        end
        render json: @entidad
      end
    rescue ActionController::ParameterMissing
      render :status => "400", json: {code: 400, description: "input invalido"}
    rescue ActiveRecord::RecordNotFound
      @id = params[:id]
      if is_number?(@id)
        render :status => "404", json: {code: 404, description: "harburguesa inexistente"}
      else 
        render :status => "400", json: {code: 400, description: "input invalido"}
      end
    end
  end

  # DELETE /hamburguesa/1
  def destroy
    begin
      @hamburguesa = Hamburguesa.find(params[:id])
      @hamburguesa.destroy
      render json: {code: 200, description: "hamburguesa eliminada"}
    rescue  
      render :status => "404", json: {code: 404, description: "hamburguesa inexistente"}
    end
  end

  # DELETE /hamburguesa/1
  def destroy_ingrediente
    begin
      @hamburguesa = Hamburguesa.find(params[:hamburguesa_id])
      if !@hamburguesa.ingredientes.where("id =" + params[:ingrediente_id]).exists?
        render :status => "404", json: {code: 404, description: "Ingrediente inexistente en la hamburguesa"}
      else 
        @ingrediente = Ingrediente.find(params[:ingrediente_id])
        @hamburguesa.ingredientes.destroy(@ingrediente)
        render json: {code: 200, description: "Ingrediente retirado"}
      end
    rescue 
      render :status => "400", json: {code: 400, description: "Id de hamburguesa inválido"}
    end
  end

  # PUT /hamburguesa/1
  def put_ingrediente
    begin
      @ingrediente = Ingrediente.find(params[:ingrediente_id])
      if @ingrediente
        begin
          @hamburguesa = Hamburguesa.find(params[:hamburguesa_id])
          @hamburguesa.ingredientes << @ingrediente
          render :status => "201", json: {code: 201, description: "Ingrediente agreagado"}
        rescue ActiveRecord::RecordNotFound
          render :status => "400", json: {code: 400, description: "Id de hamburguesa inválido"}
        end
      end
    rescue ActiveRecord::RecordNotFound
      render :status => "404", json: {code: 404, description: "Ingrediente inexistente"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hamburguesa
      @hamburguesa = Hamburguesa.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hamburguesa_params
      params.require(:hamburguesa).permit(:nombre, :precio, :descripcion, :imagen)
    end
end
