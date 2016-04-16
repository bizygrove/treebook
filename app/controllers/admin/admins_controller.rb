class Admin::AdminsController < AdminController
  before_action :set_admin_admin, only: [:show, :edit, :update, :destroy]


  class Grid
    include Datagrid
    scope { Admin }
    filter(:id, :integer)
    filter(:email, :string) { |value| where('email like ?', "%#{value}%") }
    filter(:sign_in_count, :integer)
    filter(:last_sign_in_at, :date, range: true)
    filter(:created_at, :date, :range => true)

    column(:id)
    column(:email)
    column(:sign_in_count)
    column(:current_sign_in_at) do |model|
      model.current_sign_in_at.to_time if model.last_sign_in_at
    end
    column(:last_sign_in_at) do |model|
      model.last_sign_in_at.to_time if model.last_sign_in_at
    end
    column(:created_at) do |model|
      model.created_at.to_time
    end
    column(:edit, :html => true) do |record|
      link_to "Edit", edit_admin_admin_path(record)
    end
    column(:delete, :html => true) do |record|
      link_to "Delete", destroy_admin_admin_path(record), method: :delete, data: { confirm: 'Are you sure?' }
    end
  end

  # GET /admin/admins
  # GET /admin/admins.json
  def index
    @admin_admins = Admin.all

    @grid = grid_class.new(grid_params) do |scope|
      scope.page(params[:page]).per(10)
    end
    @index_path = request.path
#    render 'admin/base/index'
  end

  # GET /admin/admins/1
  # GET /admin/admins/1.json
  def show
  end

  # GET /admin/admins/new
  def new
    @admin_admin = Admin.new
  end

  # GET /admin/admins/1/edit
  def edit
  end

  # POST /admin/admins
  # POST /admin/admins.json
  def create
    @admin_admin = Admin.new(admin_admin_params)

    respond_to do |format|
      if @admin_admin.save
        format.html { redirect_to @admin_admin, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin_admin }
      else
        format.html { render :new }
        format.json { render json: @admin_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/admins/1
  # PATCH/PUT /admin/admins/1.json
  def update
    respond_to do |format|
      if @admin_admin.update(admin_admin_params)
        format.html { redirect_to @admin_admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_admin }
      else
        format.html { render :edit }
        format.json { render json: @admin_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/admins/1
  # DELETE /admin/admins/1.json
  def destroy
    @admin_admin.destroy
    respond_to do |format|
      format.html { redirect_to admin_admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_admin
      @admin_admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_admin_params
      params.require(:admin_admin).permit(:email, :password)
    end

    def grid_class
      @@grid_class ||= self.class::Grid
    end

    def grid_params
      params[grid_class.name.underscore.gsub('/', '_')]
    end
end
