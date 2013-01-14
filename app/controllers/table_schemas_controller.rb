class TableSchemasController < ApplicationController
  # GET /table_schemas
  # GET /table_schemas.json
  def index
    @table_schemas = TableSchema.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @table_schemas }
    end
  end

  # GET /table_schemas/1
  # GET /table_schemas/1.json
  def show
    @table_schema = TableSchema.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @table_schema }
    end
  end

  # GET /table_schemas/new
  # GET /table_schemas/new.json
  def new
    @table_schema = TableSchema.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @table_schema }
    end
  end

  # GET /table_schemas/1/edit
  def edit
    @table_schema = TableSchema.find(params[:id])
  end

  # POST /table_schemas
  # POST /table_schemas.json
  def create
    @table_schema = TableSchema.new(params[:table_schema])

    respond_to do |format|
      if @table_schema.save
        format.html { redirect_to @table_schema, notice: 'Table schema was successfully created.' }
        format.json { render json: @table_schema, status: :created, location: @table_schema }
      else
        format.html { render action: "new" }
        format.json { render json: @table_schema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /table_schemas/1
  # PUT /table_schemas/1.json
  def update
    @table_schema = TableSchema.find(params[:id])

    respond_to do |format|
      if @table_schema.update_attributes(params[:table_schema])
        format.html { redirect_to @table_schema, notice: 'Table schema was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @table_schema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /table_schemas/1
  # DELETE /table_schemas/1.json
  def destroy
    @table_schema = TableSchema.find(params[:id])
    @table_schema.destroy

    respond_to do |format|
      format.html { redirect_to table_schemas_url }
      format.json { head :no_content }
    end
  end
end
