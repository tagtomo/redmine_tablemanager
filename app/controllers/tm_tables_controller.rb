class TmTablesController < ApplicationController
  unloadable
  menu_item :redmine_tablemanager
  before_filter :find_project #, :authorize
  #before_action :set_tm_table, only: [:show, :edit, :update, :destroy]
  before_filter :set_tm_table, only: [:edit, :update, :destroy]

  def index
    @tm_tables = TmTable.find_all_by_project_name(params[:project_id])
  end

  def show
    @tm_table = TmTable.find(params[:id])
  end

  def new
    @tm_table = TmTable.new
    @tm_table.project_name = @project.identifier
    @tm_table.tm_table_columns.build
  end

  def edit
  end

  def commit
    @tm_table = TmTable.find(params[:id])
    @tm_table.commit
    render "show"
  end

  def create
    #@tm_table = TmTable.new(tm_table_params)
    @tm_table = TmTable.new(params[:tm_table])

    respond_to do |format|
      if @tm_table.save
        format.html { redirect_to [@project,@tm_table], notice: 'Tm table was successfully created.' }
        #format.json { render :show, status: :created, location: @tm_table }
      else
        format.html { render :new }
        #format.json { render json: @tm_table.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      #if @tm_table.update(tm_table_params)
      #if @tm_table.update(params[:tm_table])
      if @tm_table.update_attributes(params[:tm_table])
        format.html { redirect_to [@project,@tm_table], notice: 'Tm table was successfully updated.' }
        #format.json { render :show, status: :ok, location: @tm_table }
      else
        format.html { render :edit }
        #format.json { render json: @tm_table.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tm_table.destroy
    respond_to do |format|
      format.html { redirect_to [@project,@tm_table], notice: 'Tm table was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  def getgentext
      gentext = TmTable.find(params[:id]).to_gentext
      render :text =>  gentext
  end

  def getlocaleyml
      localeyml = TmTable.find(params[:id]).to_localeyml
      puts localeyml
      render :text =>  localeyml
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tm_table
      @tm_table = TmTable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def tm_table_params
    #  params.require(:tm_table).permit(:project_name, :table_name, :table_name_jp, :revision_number, :note,
    #    tm_table_columns_attributes: [:id, :column_number, :column_name, :column_name_jp, :column_type, :column_size, :column_null, :column_default, :column_p_key, :column_f_key, :note, :tm_table_id,:_destroy]
    #  )
    #end

    #redmine専用　タブの表示用
	  def find_project
	    @project = Project.find(params[:project_id])
	  rescue ActiveRecord::RecordNotFound
	    render_404
	  end
end
