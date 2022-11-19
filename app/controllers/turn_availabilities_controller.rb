class TurnAvailabilitiesController < ApplicationController
  before_action :set_turn_availability, only: %i[ show edit update destroy ]

  # GET /turn_availabilities or /turn_availabilities.json
  def index
    @turn_availabilities = TurnAvailability.all
  end

  # GET /turn_availabilities/1 or /turn_availabilities/1.json
  def show
  end

  # GET /turn_availabilities/new
  def new
    @turn_availability = TurnAvailability.new
  end

  # GET /turn_availabilities/1/edit
  def edit
  end

  # POST /turn_availabilities or /turn_availabilities.json
  def create
    @turn_availability = TurnAvailability.new(turn_availability_params)

    respond_to do |format|
      if @turn_availability.save
        format.html { redirect_to turn_availability_url(@turn_availability), notice: "Turn availability was successfully created." }
        format.json { render :show, status: :created, location: @turn_availability }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @turn_availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turn_availabilities/1 or /turn_availabilities/1.json
  def update
    respond_to do |format|
      if @turn_availability.update(turn_availability_params)
        format.html { redirect_to turn_availability_url(@turn_availability), notice: "Turn availability was successfully updated." }
        format.json { render :show, status: :ok, location: @turn_availability }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @turn_availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /turn_availabilities/1 or /turn_availabilities/1.json
  def destroy
    @turn_availability.destroy

    respond_to do |format|
      format.html { redirect_to turn_availabilities_url, notice: "Turn availability was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn_availability
      @turn_availability = TurnAvailability.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turn_availability_params
      params.require(:turn_availability).permit(:date, :engineer_id, :company_id, :turn_id)
    end
end
