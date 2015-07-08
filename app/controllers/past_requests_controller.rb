include ActionView::Helpers::DateHelper

class PastRequestsController < ApplicationController
  before_action :set_past_request, only: [:show, :edit, :update, :destroy]

  # GET /past_requests
  # GET /past_requests.json
  def index
    @past_requests = PastRequest.all.reverse
  end

  # GET /past_requests/1
  # GET /past_requests/1.json
  def show
  end

  # GET /past_requests/new
  def new
    @past_request = PastRequest.new
  end

  # GET /past_requests/1/edit
  def edit
  end

  # POST /past_requests
  # POST /past_requests.json
  def create
    @past_request = PastRequest.new(past_request_params)

    respond_to do |format|
      if @past_request.save
        format.html { redirect_to @past_request, notice: 'Past request was successfully created.' }
        format.json { render :show, status: :created, location: @past_request }
      else
        format.html { render :new }
        format.json { render json: @past_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /past_requests/1
  # PATCH/PUT /past_requests/1.json
  def update
    respond_to do |format|
      @past_request.received_help = true
      if @past_request.update(past_request_params)
        format.html { redirect_to requests_path, notice: "You spent #{time_ago_in_words(Time.now - (Time.now - @past_request.created_at), include_seconds: true)}" }
        format.json { render :show, status: :ok, location: @past_request }
      else
        format.html { render :edit }
        format.json { render json: @past_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /past_requests/1
  # DELETE /past_requests/1.json
  def destroy
    @past_request.destroy
    respond_to do |format|
      format.html { redirect_to past_requests_url, notice: 'Past request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_request
      @past_request = PastRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def past_request_params
      params.permit(:id, :student_id, :removed_by, :time_waited, :received_help)
    end
end
