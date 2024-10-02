class FlightsController < ApplicationController
  before_action :set_flight, only: [ :show, :edit, :update, :destroy ]

  # GET /flights or /flights.json
  def index
    @airport_options = Airport.all.map{ |airport| [airport.code, airport.id] }

    Rails.logger.debug "Flight params: #{flight_params.inspect}"
    date = get_date
    Rails.logger.debug "Parsed date: #{date}"

    @seats = flight_params["seats"]

    @flights = Flight.where(departure_id: flight_params["departure_id"])
    .where(arrival_id: flight_params["arrival_id"])
    .where("DATE(date) = ?", date)
    .where("vacancy >= ?", flight_params[:seats].to_i)

    Rails.logger.debug "Generated SQL: #{@flights.to_sql}"
    Rails.logger.debug "Result count: #{@flights.count}"
  end

  # GET /flights/1 or /flights/1.json
  def show
  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
  end

  # POST /flights or /flights.json
  def create
    @flight = Flight.new(flight_params)

    respond_to do |format|
      if @flight.save
        format.html { redirect_to @flight, notice: "Flight was successfully created." }
        format.json { render :show, status: :created, location: @flight }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flights/1 or /flights/1.json
  def update
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to @flight, notice: "Flight was successfully updated." }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1 or /flights/1.json
  def destroy
    @flight.destroy!

    respond_to do |format|
      format.html { redirect_to flights_path, status: :see_other, notice: "Flight was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flight_params
      params.permit(:name, :departure_id, :arrival_id, :seats, :commit, :date => {})
    end

    def get_date
      date_params = flight_params[:date]
      if date_params && date_params[:year] && date_params[:month] && date_params[:day]
        Date.new(date_params[:year].to_i, date_params[:month].to_i, date_params[:day].to_i)
      else
        nil
      end
    rescue ArgumentError => e
      Rails.logger.debug "Error parsing date: #{e.message}"
      nil
    end
end
