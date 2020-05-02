class IngredientesController < ApplicationController
  #before_action :set_ingrediente, only: [:show, :update, :destroy]

  def is_number? string
    true if Float(string) rescue false
  end

  # GET /ingredientes
  def index
    @ingredientes = Ingrediente.all

    render json: @ingredientes
  end

  # GET /ingredientes/1
  def show
    begin
      @ingrediente = Ingrediente.find(params[:id])
      render json: @ingrediente
    rescue
      @id = params[:id]
      if is_number?(@id)
        render :status => "404", json: {code: 404, description: "Ingrediente inexistente"}
      else 
        render :status => "400", json: {code: 400, description: "Input invalido"}
      end
    end
  end

  # POST /ingredientes
  def create
    begin
      @ingrediente = Ingrediente.new(ingrediente_params)
      if @ingrediente.save
        render json: @ingrediente, status: :created, location: @ingrediente
      end
    rescue
      render :status => "400", json: {code: 400, description: "Input invalido"}
    end
  end

  # PATCH/PUT /ingredientes/1
  def update
    if @ingrediente.update(ingrediente_params)
      render json: @ingrediente
    else
      render json: @ingrediente.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ingredientes/1
  def destroy
    begin
      @ingrediente = Ingrediente.find(params[:id])
      @hamburguesas = Hamburguesa.all
      @aux = 0
      @hamburguesas.each do |hamburguesa|
        if hamburguesa.ingredientes.where("id =" + params[:id]).exists?
          @aux = 1
          break
        end
      end
      if @aux == 0
        @ingrediente.destroy
        render json: {code: 200, description: "Ingrediente eliminado"}
      else 
        render :status => "409", json: {code: 409, description: "Ingrediente no se puede borrar, se encuentra presente en una hamburguesa"}
      end
    rescue
      render :status => "404", json: {code: 404, description: "Ingrediente inexistente"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingrediente
      @ingrediente = Ingrediente.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ingrediente_params
      params.require(:ingrediente).permit(:nombre, :descripcion)
    end
end
