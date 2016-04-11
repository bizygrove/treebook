class StatusesController < ApplicationController
  before_action  :authenticate_user!, :set_status, only: [:show, :edit, :update, :destroy, :new, :create, :index]

  # GET /statuses
  # GET /statuses.json
  def index
    @user = current_user
    @status = current_user.statuses.new
    @statuses = Status.order('created_at DESC').all
    @king = Status.order("created_at").last
    @status.build_document
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @user = current_user
    @king = Status.order("created_at").last
  end

  # GET /statuses/new
  def new
    @status = current_user.statuses.new
    @status.build_document
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = current_user.statuses.new(status_params)

    respond_to do |format|
      if @status.user == current_user
        @status.save
        format.html { redirect_to feed_path, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    respond_to do |format|
      if @status.user == current_user
        @status.update(status_params)
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { render :show, status: :ok, location: @status }
      else
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    if @status.user == current_user
      @status.destroy
      respond_to do |format|
        format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to statuses_path, notice: 'You cant delete this item'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id]) rescue nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:content, :user_id, :document_id, document_attributes: [:add_attachment, :add_attachment_file_name] )
    end
end
