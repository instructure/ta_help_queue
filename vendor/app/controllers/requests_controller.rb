class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    hash = params[:post]
    student_id = hash[:student_id].to_i

    # check if student already has request submitted
    if Request.where(student_id: student_id).size > 0
      respond_to do |format|
        format.html { redirect_to Request.where(student_id: student_id).take, notice: 'You already have this request:' }
        format.json { render :show, status: 400 }
      end
    # check that student is registered
    elsif Student.where(id_num: student_id).size == 0
      respond_to do |format|
        format.html { redirect_to requests_path, notice: "Invalid ID number: #{student_id}" }
        format.json { render :show, status: 400 }
      end
    # create request
    else
      @request = Request.new(request_params)
      @request.student_id = student_id

      respond_to do |format|
        if @request.save
          format.html { redirect_to '/requests', notice: 'Request was successfully created.' }
          format.json { render :show, status: :created, location: @request }
        else
          format.html { render :new }
          format.json { render json: @request.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    if !session[:admin] && @request && session[:id] != @request.student_id
      flash[:notice] = "You do not have permission to remove this request"
      redirect_to(requests_path)
    elsif params[:helped]
      if Request.where(id: params[:id]).count > 0
        student = Student.where(id_num: @request.student_id).take

        past = PastRequest.create(student_id: student.id_num,
                           removed_by: session[:id],
                           time_waited: calc_wait(@request.created_at),
                           received_help: false)

        @request.destroy
        respond_to do |format|
          format.html { redirect_to past, notice: "Request for #{student.name} was removed." }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to requests_url, notice: "Request already removed." }
          format.json { head :no_content }
        end
      end
    else
      if Request.where(id: params[:id]).count > 0
        student = Student.where(id_num: @request.student_id).take

        PastRequest.create(student_id: student.id_num,
                           removed_by: session[:id],
                           time_waited: calc_wait(@request.created_at),
                           received_help: false)

        @request.destroy
        respond_to do |format|
          format.html { redirect_to requests_url, notice: "Request for #{student.name} was removed." }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to requests_url, notice: "Request already removed." }
          format.json { head :no_content }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = nil
      if Request.where(id: params[:id]).count > 0
        @request = Request.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.permit(:student_id)
    end

    def require_login
      unless session[:id]
        flash[:notice] = "You must log in first"
        redirect_to "/login"
      end
    end

    def calc_wait(created_at)
      Time.now - created_at
    end
end
