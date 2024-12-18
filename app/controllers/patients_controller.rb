class PatientsController < ApplicationController
  before_action :set_patient, only: [ :show, :update, :destroy, :create_recipe, :list_recipes ]

  # GET /patients
  def index
    @patients = Patient.all
    render json: @patients
  end

  # POST /patients
  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      render json: @patient, status: :created
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # GET /patients/:id
  def show
    render json: @patient
  end

  # PATCH/PUT /patients/:id
  def update
    patient = Patient.find(params[:id])
    if patient.update(patient_params)
      render json: patient
    else
      render json: { error: patient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /patients/:id
  def destroy
    patient = Patient.find(params[:id])
    patient.destroy
    render json: { message: "Paciente excluído com sucesso" }
  end

  # GET /patients/:id/recipes
  def list_recipes
    @recipes = @patient.recipes
    render json: @recipes
  end

  # POST /patients/:id/recipes
  def create_recipe
    @recipe = @patient.recipes.new(recipe_params)
    if @recipe.save
      render json: @recipe, status: :created
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:name, :age, :condition, :recipe)
  end
end
