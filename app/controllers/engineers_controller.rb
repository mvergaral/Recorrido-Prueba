class EngineersController < ApplicationController
  before_action :set_engineer, only: %i[ show edit update destroy ]

  # GET /engineers or /engineers.json
  def index
    @engineers = Engineer.all
  end

  # GET /engineers/1 or /engineers/1.json
  def show
  end

  # GET /engineers/new
  def new
    @engineer = Engineer.new
  end

  # GET /engineers/1/edit
  def edit
  end

  # POST /engineers or /engineers.json
  def create
    @engineer = Engineer.new(engineer_params)

    respond_to do |format|
      if @engineer.save
        format.html { redirect_to engineer_url(@engineer), notice: "Engineer was successfully created." }
        format.json { render :show, status: :created, location: @engineer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @engineer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /engineers/1 or /engineers/1.json
  def update
    respond_to do |format|
      if @engineer.update(engineer_params)
        format.html { redirect_to engineer_url(@engineer), notice: "Engineer was successfully updated." }
        format.json { render :show, status: :ok, location: @engineer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @engineer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /engineers/1 or /engineers/1.json
  def destroy
    @engineer.destroy

    respond_to do |format|
      format.html { redirect_to engineers_url, notice: "Engineer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engineer
      @engineer = Engineer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def engineer_params
      params.require(:engineer).permit(:name, :color)
    end
end
