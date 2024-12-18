class PatientsController < ApplicationController
  before_action :set_patient, only: [ :show, :update, :destroy ]

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

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:name, :age, :condition)
  end
end
