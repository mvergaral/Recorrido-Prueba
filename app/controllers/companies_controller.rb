class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]

  # GET /companies or /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1 or /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies or /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save

        @company.create_turns(Date.today)

        format.html { redirect_to company_url(@company), notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to company_url(@company), notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    puts(params)
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def company_turns_week_schedule
    @turns_hours = {"00:00-01:00" => 0, "01:00-02:00" => 1, "02:00-03:00" => 2, "03:00-04:00" => 3, "04:00-05:00" => 4, "05:00-06:00" => 5, "06:00-07:00" => 6, "07:00-08:00" => 7, "08:00-09:00" => 8, "09:00-10:00" => 9, "10:00-11:00" => 10, "11:00-12:00" => 11, "12:00-13:00" => 12, "13:00-14:00" => 13, "14:00-15:00" => 14, "15:00-16:00" => 15, "16:00-17:00" => 16, "17:00-18:00" => 17, "18:00-19:00" => 18, "19:00-20:00" => 19, "20:00-21:00" => 20, "21:00-22:00" => 21, "22:00-23:00" => 22, "23:00-00:00" => 23}
    @date = params[:date] ? Date.parse(params[:date]).at_beginning_of_week : Date.today.at_beginning_of_week
    @days = @date.beginning_of_week..@date.end_of_week
    @company = Company.find(params[:company_id])
    @weeks = (Date.today - @company.created_at.to_date).to_i / 7
    @weeks = @weeks <= 5 ? @weeks : 5
    
    @turns = @company.turns.where(date: @date.beginning_of_week..@date.end_of_week.at_end_of_day)

    if @turns.empty?
      @company.create_turns(@date)
      @turns = @company.turns.where(date: @date.beginning_of_week..@date.end_of_week.at_end_of_day)
    end

    @count_turns_per_engineer = @company.count_turns_per_engineer(@date)
    
  end

  def company_engineer_turn_availabilities
    @turns_hours = {"00:00-01:00" => 0, "01:00-02:00" => 1, "02:00-03:00" => 2, "03:00-04:00" => 3, "04:00-05:00" => 4, "05:00-06:00" => 5, "06:00-07:00" => 6, "07:00-08:00" => 7, "08:00-09:00" => 8, "09:00-10:00" => 9, "10:00-11:00" => 10, "11:00-12:00" => 11, "12:00-13:00" => 12, "13:00-14:00" => 13, "14:00-15:00" => 14, "15:00-16:00" => 15, "16:00-17:00" => 16, "17:00-18:00" => 17, "18:00-19:00" => 18, "19:00-20:00" => 19, "20:00-21:00" => 20, "21:00-22:00" => 21, "22:00-23:00" => 22, "23:00-00:00" => 23}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @company = Company.find(params[:company_id])
    @engineer = Engineer.find(params[:engineer_id])
    @days = @date.beginning_of_week..@date.end_of_week
    @company_engineers = @company.engineers

    @turns = @company.turns.where(date: @date.beginning_of_week..@date.end_of_week.at_end_of_day)
    @engineer_turn_availabilities = @engineer.turn_availabilities.where(turn_id: @turns.ids, company_id: @company.id)
  end

  def update_company_engineer_turn_availabilities
    @company = Company.find(params[:company_id])
    @engineer = Engineer.find(params[:engineer_id])
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @days = @date.beginning_of_week..@date.end_of_week
    @company_engineers = @company.engineers

    @turns = @company.turns.where(date: @date.beginning_of_week..@date.end_of_week.at_end_of_day)
    @engineer_turn_availabilities = @engineer.turn_availabilities.where(turn_id: @turns.ids, company_id: @company.id)

    @engineer_turn_availabilities.each do |engineer_turn_availability|
      if params[:turn_availability_ids].include?(engineer_turn_availability.id.to_s)
        engineer_turn_availability.update(available: true)
      else
        engineer_turn_availability.update(available: false)
      end
    end

    @company.assign_best_turns(@date)

    redirect_to company_company_schedule_url(@company, @engineer, date: @date)
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :schedule,:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :engineer_ids => [], :turn_availability => [])
    end

end
